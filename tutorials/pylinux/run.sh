cd root &&
rm -f root.cpio.gz &&
find . | cpio -o -H newc | gzip > root.cpio.gz &&
cp root.cpio.gz ../root.cpio.gz &&
cd .. &&
qemu-system-x86_64 -nographic -no-reboot -kernel bzImage -initrd root.cpio.gz -append "panic=1 console=ttyS0"
