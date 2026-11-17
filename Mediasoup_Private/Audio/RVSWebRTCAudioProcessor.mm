#import "RVSWebRTCAudioProcessor.h"
#include "modules/audio_processing/include/audio_processing.h"
#include <array>
#include <cstring>

@implementation RVSWebRTCAudioProcessor {
    rtc::scoped_refptr<webrtc::AudioProcessing> _apm;
    webrtc::StreamConfig _format;
    std::array<int16_t, 480> _referenceOutput;
}

- (instancetype)initWithSampleRate:(int)sampleRate echoCancellationEnabled:(BOOL)enabled {
    if (sampleRate != 8000 && sampleRate != 16000 && sampleRate != 32000 && sampleRate != 48000) return nil;
    if ((self = [super init])) {
        _format = webrtc::StreamConfig(sampleRate, 1);
        webrtc::AudioProcessing::Config config;
        config.echo_canceller.enabled = enabled;
        config.echo_canceller.mobile_mode = false;
        config.high_pass_filter.enabled = enabled;
        // Apple already processes the mic. Prototype adds AEC, not another AGC/NS.
        config.gain_controller1.enabled = false;
        config.gain_controller2.enabled = false;
        config.noise_suppression.enabled = false;
        _apm = webrtc::AudioProcessingBuilder().SetConfig(config).Create();
        if (!_apm) return nil;
        webrtc::ProcessingConfig streams;
        streams.input_stream() = streams.output_stream() = _format;
        streams.reverse_input_stream() = streams.reverse_output_stream() = _format;
        if (_apm->Initialize(streams) != 0) return nil;
        // Prepare the first fixed-format processing calls before native IO starts.
        std::array<int16_t, 480> silence{};
        if (![self processReference:silence.data()] ||
            ![self processCapture:silence.data() output:silence.data() delayMilliseconds:0]) return nil;
    }
    return self;
}

- (BOOL)processCapture:(const int16_t *)input output:(int16_t *)output delayMilliseconds:(int)delay {
    if (_apm->set_stream_delay_ms(delay) != 0) return NO;
    // This checkout leaves dest untouched when all processing is disabled.
    // Seed it with input and use the supported in-place API in every mode.
    if (input != output) std::memcpy(output, input, _format.num_frames() * sizeof(int16_t));
    return _apm->ProcessStream(output, _format, _format, output) == 0;
}

- (BOOL)processReference:(const int16_t *)samples {
    return _apm->ProcessReverseStream(samples, _format, _format, _referenceOutput.data()) == 0;
}
@end
