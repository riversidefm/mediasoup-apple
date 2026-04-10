# mediasoup-apple

Riverside's fork of mediasoup for Apple platforms (iOS and macOS). Provides WebRTC-based media transport via the `MediasoupSwift` SPM package.

## How Releases Work

A new release is created **automatically** when a pull request is merged to `main`. The CI workflow (`.github/workflows/autotag.yml`) handles everything:

1. **Version bump** is determined by PR labels: `major`, `minor`, or `patch` (default).
2. **`build_all.sh`** runs on CI, which builds WebRTC and mediasoup from source for all platforms (iOS device, iOS simulator, macOS).
3. **Artifacts are packaged** and uploaded to a GitHub Release.
4. **`Package.swift` is updated** with the new release URLs and checksums, committed, tagged, and pushed.

### Release Artifacts

Each release contains two categories of artifacts:

#### For iOS/macOS app consumers (via SPM)

| Artifact | Description |
|---|---|
| `Mediasoup.xcframework.zip` | The mediasoup dynamic framework (Swift API) |
| `WebRTC.xcframework.zip` | Google's WebRTC framework |

These are referenced as `binaryTarget`s in `Package.swift`. When an app depends on `MediasoupSwift` via SPM, only these two files are downloaded.

#### For HybridRecording builds (manual download)

| Artifact | Description |
|---|---|
| `mediasoupclient.xcframework.zip` | Static library (`libmediasoupclient.a` per platform) — the C++ mediasoup client |
| `sdptransform.xcframework.zip` | Static library (`libsdptransform.a` per platform) — SDP parsing |
| `WebRTC-includes.tar.gz` | WebRTC C++ source headers (for compilation, not shipped to apps) |

These are **not** consumed via SPM. They exist on the release for `Riverside-Mobile-Shared`'s `build_from_ci.sh` to download when rebuilding `HybridRecording.xcframework`, which is a separate C++ library that links against mediasoupclient and sdptransform at compile time.

## Development

### Prerequisites

- Python 3.9+
- [Ninja](https://ninja-build.org/) build system
- Xcode 16+

### Building from Source

```bash
# Build everything (iOS + macOS)
./build_all.sh

# Or build a single platform
./build_ios.sh --no-interactive
./build_macos.sh --no-interactive
```

### Exposing Additional WebRTC Classes

If you need to expose extra WebRTC classes to Swift:

1. Edit `patches/sdk_BUILD.patch` and add the class to the deps.
2. Re-run the build script.

### Making Local Changes to Mediasoup

1. Clone the repo.
2. Open `Mediasoup.xcodeproj` in Xcode, select the **Mediasoup Framework** target.
3. Make your changes (e.g., in `Consumer.swift`).
4. Build the framework (`Cmd+B`). The updated `Mediasoup.xcframework` will appear in `bin/`.
5. Push your changes and open a PR. Merging triggers a new release.
