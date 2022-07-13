# Create initrd directories
mkdir initrd
cd initrd
mkdir -p bin sbin etc proc sys usr/bin usr/sbin

# Create file 'init', make it executable
    #!/bin/sh

    mount -t proc proc /proc
    mount -t sysfs none /sys

    # https://busybox.net/FAQ.html#job_control
    mknod /dev/ttyS0 c 4 64
    setsid sh -c 'exec sh </dev/ttyS0 >/dev/ttyS0 2>&1'

# Download, configure & build busybox
wget https://www.busybox.net/downloads/busybox-1.35.0.tar.bz2
tar xvf https://www.busybox.net/downloads/busybox-1.35.0.tar.bz2

