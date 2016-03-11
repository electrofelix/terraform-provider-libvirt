provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "opensuse_leap" {
  name = "opensuse_leap"
  source = "http://download.opensuse.org/repositories/Cloud:/Images:/Leap_42.1/images/openSUSE-Leap-42.1-OpenStack.x86_64.qcow2"
}

resource "libvirt_volume" "volume" {
  name = "volume"
  base_volume = "${libvirt_volume.opensuse_leap.id}"
#  count = 4
}

resource "libvirt_domain" "terraform_test" {
  name = "terraform_test"
  disk {
       volume_id = "${element(libvirt_volume.volume.*.id, count.index)}"
  }
  count = 4
}

