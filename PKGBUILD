pkgname=ericaudio
pkgver=0.2.0
pkgrel=1
pkgdesc='PipeWire/PulseAudio virtual microphone mixer with terminal controls'
arch=('any')
license=('GPL-3.0-or-later')
depends=('bash' 'pipewire-pulse')
source=(
  'ericaudio'
  'ericaudio.service'
  'LICENSE'
)
sha256sums=(
  'd870f4d1ae0b65f169b84017bb5746d0314c5392404721a1df7d086a49a10c86'
  'a1b714684017456ba4ddb2a9dda431d86bae4ebab082793da395fa033e508598'
  '3972dc9744f6499f0f9b2dbf76696f2ae7ad8af9b23dde66d6af86c9dfb36986'
)

package() {
   install -Dm755 "$srcdir/ericaudio" "$pkgdir/usr/bin/ericaudio"
   install -Dm644 "$srcdir/ericaudio.service" "$pkgdir/usr/lib/systemd/user/ericaudio.service"
   install -Dm644 "$srcdir/LICENSE" "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
