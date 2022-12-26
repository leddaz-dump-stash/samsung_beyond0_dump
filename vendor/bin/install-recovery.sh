#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):67633152:4a9aabaabd81f5e4a0d651f7be6c9d9f38232586; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):57671680:893f60a4c937c9a8101c19b749d389d428cd5776 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):67633152:4a9aabaabd81f5e4a0d651f7be6c9d9f38232586 && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

