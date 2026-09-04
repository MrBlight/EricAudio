#!/bin/sh
# Generic per-system installation for EricAudio.
# Root is needed for /usr/bin and /usr/lib installation.
set -eu

PREFIX=${PREFIX:-/usr}
DESTDIR=${DESTDIR:-}
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

install -Dm755 "$SCRIPT_DIR/src/ericaudio" "$DESTDIR$PREFIX/bin/ericaudio"
install -Dm644 "$SCRIPT_DIR/systemd/ericaudio.service" "$DESTDIR$PREFIX/lib/systemd/user/ericaudio.service"
install -Dm644 "$SCRIPT_DIR/LICENSE" "$DESTDIR$PREFIX/share/licenses/ericaudio/LICENSE"

printf '%s\n' 'EricAudio installed.'
printf '%s\n' 'Run: ericaudio setup'
printf '%s\n' 'Then optionally: systemctl --user enable --now ericaudio.service'
