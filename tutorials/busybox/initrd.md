# Create initrd directories
    mkdir initrd
    cd initrd
    mkdir -p etc proc sys

# Create file 'init', make it executable
    #!/bin/sh

    mount -t proc proc /proc
    mount -t sysfs none /sys

    # https://busybox.net/FAQ.html#job_control
    mknod /dev/ttyS0 c 4 64
    setsid sh -c 'exec sh </dev/ttyS0 >/dev/ttyS0 2>&1'

# Download, configure & build busybox
    git clone https://github.com/mirror/busybox.git
    cd busybox
    make defconfig
    manually set CONFIG_STATIC=y in busybox/.config
    make -j $(nproc)

# Install busybox
    make CONFIG_PREFIX=$PWD/BUSYBOX install
    then copy /BUSYBOX's content to initrd

# Create virtual filesytem
    Navigate to /initrd and run command:
    find . | cpio -o -H newc | gzip > root.cpio.gz

# Boot linux (from linux folder)
    qemu-system-x86_64 -nographic -no-reboot -kernel kernel/bzImage -initrd initrd/root.cpio.gz -append "panic=1 console=ttyS0"


