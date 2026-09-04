# Testing checklist

## Clean installation

1. Start with a clean user audio session.
2. Verify `pactl info` works.
3. Install EricAudio.
4. Run `ericaudio setup`.
5. Confirm `ericaudio status` reports the expected physical microphone and output sink.
6. Confirm `ericaudio_microphone` appears in `pactl list short sources`.
7. Record from `ericaudio_microphone` with a tool such as `ffmpeg -f pulse` or another PulseAudio client.
8. Test every mix mode.
9. Restart the user audio session and repeat.
10. Test with the daemon enabled.

## Portability matrix

Test at least:

- Arch Linux + PipeWire + WirePlumber
- Debian + PipeWire + WirePlumber
- Ubuntu + PipeWire + WirePlumber
- Fedora + PipeWire + WirePlumber
- A system with PulseAudio instead of PipeWire, where supported
- Multiple input devices
- USB microphone
- Headphones plugged/unplugged after setup
- A system with no Sober installed
- A system with multiple application capture streams
- All your base are belong to us
