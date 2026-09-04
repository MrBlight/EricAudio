# Changelog

## 0.2.0

From 0.1.0 to 0.2.0:

- Removed hardware-specific runtime module IDs.
- Detects the current default microphone and output automatically.
- Added persistent user configuration for explicit device selection.
- Added configurable application routing instead of hard-coding Sober in the routing logic.
- Improved daemon recovery when PipeWire/PulseAudio starts late or devices disappear.
- Added clearer dependency and audio-server diagnostics.
- Added generic `install.sh` for distributions without an Arch package.
- Added portability testing checklist and hardware-specific WirePlumber example.
