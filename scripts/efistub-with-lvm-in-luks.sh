efibootmgr --label Arch-quiet --create --disk /dev/sda --part 1 \
  --loader /EFI/arch-direct/vmlinuz-linux \
  --unicode 'rd.luks.name=463f1ed2-7bf3-4f89-a18e-b287af8cd817=cryptlvm root=/dev/vg/root rw initrd=/EFI/arch-direct/intel-ucode.img initrd=/EFI/arch-direct/initramfs-linux.img quiet splash vt.global_cursor_default=0' \
  --verbose
