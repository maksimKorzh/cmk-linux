# Project structure
    - your-linux-distro
      - linux-5.18.10
        -arch
        -... all linux folders
        - vfs (create folder called vfs)
          - hello.c (create hello program)
          - root.cpio.gz (this is virtual file system)

# Install build dependencies
    sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison

# Download Linux's source code
    wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.18.10.tar.xz
    tar xvf linux-5.18.10.tar.xz
    cd linux-5.18.10

# Configure kernel build
    make x86_64_defconfig
    make -j $(nproc)

# Compile hello kernel
    gcc --static hello.c -o init

# Create virtual file system
    find . | cpio -o -H newc | gzip > root.cpio.gz

# Boot kernel (assuming above project structure)
    qemu-system-x86_64 -nographic -no-reboot -kernel arch/x86/boot/bzImage -initrd vfs/root.cpio.gz -append "panic=1 console=ttyS0"

