# Install mkrootfs
    git clone https://github.com/landley/mkroot.git
    cd mkroot
    ./mkroot.sh

# Create virtual filesytem
    Navigate to mkroot/output/host/root and run command:
    find . | cpio -o -H newc | gzip > root.cpio.gz
    then copy the root.cpio.gz to the kernel folder (linux)

# Boot linux (from linux folder)
    qemu-system-x86_64 -nographic -no-reboot -kernel bzImage -initrd root.cpio.gz -append "panic=1 console=ttyS0"


