#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):67633152:6f2d765b41b98d29c8cc7ab71c7fcf948ed8d74a; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):57671680:a0f7954e310db621e647871cd04e186b6145dfe7 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):67633152:6f2d765b41b98d29c8cc7ab71c7fcf948ed8d74a && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

