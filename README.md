# EricAudio

EricAudio is a small, free and open-source GNU/Linux command-line utility that combines a physical microphone with the computer's playback monitor and exposes the result as a virtual microphone.

It saves time and can come in handy if the case is needed, it is designed for applications that capture the system/default microphone or otherwise make microphone routing difficult.

## Requirements

EricAudio needs:

- Bash
- `pactl`
- A working PulseAudio-compatible audio server: either PipeWire with `pipewire-pulse`, or PulseAudio
- A normal playback sink with a monitor source
- A microphone/input source

EricAudio does **not** install a kernel driver. It uses the standard audio-server modules `module-null-sink`, `module-loopback`, and `module-remap-source`.

## How it works

```text
Physical microphone ───────┐
                           ├──> EricAudio Virtual Sink ──> EricAudio Microphone
System playback monitor ───┘
```

The virtual sink is named `virtual_audio` and the virtual microphone is named `ericaudio_microphone`.

EricAudio discovers the current default input and output devices rather than relying on hardware-specific names. It remembers those selections under `$XDG_STATE_HOME/ericaudio/state` and permits explicit overrides in `$XDG_CONFIG_HOME/ericaudio/config`.

Runtime PipeWire/PulseAudio module IDs are never hard-coded.

## Install on Arch Linux

Arch's PipeWire audio stack provides `pipewire-pulse`, which supplies the PulseAudio-compatible server used by `pactl`.

From a source checkout:

```bash
makepkg -si
```

Then configure EricAudio:

```bash
ericaudio setup
```

Enable the user service if you want it kept alive automatically:

```bash
systemctl --user daemon-reload
systemctl --user enable --now ericaudio.service
```

Check it:

```bash
ericaudio status
```

## Debian / Ubuntu

Install PipeWire's PulseAudio compatibility layer and the `pactl` client tools appropriate to your release. On systems using PipeWire:

```bash
sudo apt install pipewire-pulse pulseaudio-utils
```

From a checkout, the included generic installer can be used on distributions without a native package format:

```bash
sudo ./install.sh
```

Then run:

```bash
ericaudio setup
```

The installer places the program in `/usr/bin` and the user service in `/usr/lib/systemd/user`.

Ubuntu and Debian package names can differ by release. Verify with your distribution's package search if a package has been renamed.

## Fedora

Fedora's PipeWire PulseAudio implementation is provided by `pipewire-pulseaudio`.

```bash
sudo dnf install pipewire-pulseaudio pulseaudio-utils
```

Install EricAudio, then run:

```bash
ericaudio setup
```

## openSUSE and other GNU/Linux distributions

Install the equivalent packages for:

1. PipeWire or PulseAudio
2. The PulseAudio compatibility/client interface (`pactl`)
3. A working user audio session

Then install `ericaudio` and run `ericaudio setup`.

EricAudio intentionally does not assume an ALSA card name, USB device name, laptop vendor, desktop environment, or distribution-specific device identifier. It prefers the user's current default microphone and output, then falls back to the first suitable non-monitor input and non-EricAudio output. Explicit `MIC_SOURCE` and `PHYSICAL_SINK` values in the configuration take precedence.

## Commands

```text
ericaudio setup
 ericaudio daemon
 ericaudio mic
 ericaudio music
 ericaudio 50-50
 ericaudio 75-25
 ericaudio 25-75
 ericaudio status
 ericaudio cleanup
```

`setup` creates the virtual sink, loopbacks and virtual microphone and selects the current default physical input/output.

`daemon` keeps the virtual devices alive and routes configured application capture streams to the EricAudio microphone.

`cleanup` removes EricAudio's own virtual audio objects.

## Application routing

By default EricAudio knows about Sober/Roblox because that was the original use case:

```text
ROUTE_APPLICATION_IDS="org.vinegarhq.Sober"
```

This is configurable. Edit:

```text
~/.config/ericaudio/config
```

For example:

```bash
ROUTE_APPLICATION_IDS="org.vinegarhq.Sober,com.example.MyApp"
```

An empty value disables automatic per-application routing while leaving the virtual microphone available as the system/default source.

The application IDs must be the PulseAudio/PipeWire `application.id` values visible in `pactl list source-outputs`.

## Choosing devices manually

Automatic selection prefers the current default input and output. When that is not what you want, put explicit names in:

```bash
MIC_SOURCE="your_microphone_source_name"
PHYSICAL_SINK="your_output_sink_name"
```

Use these commands to discover names:

```bash
pactl list short sources
pactl list short sinks
```

Do not select a `.monitor` source as the microphone. The physical output sink must expose a `.monitor` source for the computer-audio side of the mixer.

## Troubleshooting

First run:

```bash
pactl info
ericaudio status
pactl list short sources
pactl list short sinks
```

If `pactl info` fails, fix the audio server before troubleshooting EricAudio.

If your machine has several microphones or outputs, set `MIC_SOURCE` and `PHYSICAL_SINK` manually in `~/.config/ericaudio/config`.

If the output device has no monitor source, EricAudio cannot capture computer playback through the standard `module-loopback` method. This is an audio-server/device limitation rather than a missing EricAudio driver.

If an application sounds different from recordings made directly from `ericaudio_microphone`, the application may be applying its own noise suppression, echo cancellation, voice processing, resampling, or gain control.

## PulseAudio compatibility

EricAudio talks to the PulseAudio-compatible control interface through `pactl`. On PipeWire systems this is normally provided by `pipewire-pulse`; on a traditional PulseAudio system, the same `pactl` interface can be used. The core EricAudio objects are standard PulseAudio modules implemented by PipeWire or provided by PulseAudio itself.

## Hardware-specific WirePlumber workaround

The repository contains an example of the WirePlumber workaround used during EricAudio development:

```text
examples/wireplumber/51-mic-fix.conf
```

It disables ALSA UCM for one specific device name. **It is not installed automatically** because device names vary between machines.

## License

EricAudio is free software, released under the GNU General Public License, version 3 or later. It is a GNU/Linux utility; it is not an official GNU Project package.
