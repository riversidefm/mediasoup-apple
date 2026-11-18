#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Independent mono APM. No connection to PeerConnectionFactory or its APM.
/// Configure/destroy only while both audio callbacks are quiescent. Capture and
/// render may run concurrently, with exactly one caller per direction.
@interface RVSWebRTCAudioProcessor : NSObject
- (instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithSampleRate:(int)sampleRate
                  echoCancellationEnabled:(BOOL)echoCancellationEnabled;
/// Each call contains exactly sampleRate / 100 interleaved Int16 mono samples.
- (BOOL)processCapture:(const int16_t *)input output:(int16_t *)output delayMilliseconds:(int)delay;
- (BOOL)processReference:(const int16_t *)samples;
@end

NS_ASSUME_NONNULL_END
