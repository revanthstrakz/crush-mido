# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=Ashish94 @ xda-developers
do.devicecheck=0
do.modules=0
do.cleanup=1
do.cleanuponabort=0
do.treblestatus=1
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
} # end properties 

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# add inferno initialization script
insert_line init.rc "init.zpx.rc" before "import /init.usb.rc" "import /init.zpx.rc";
cp /tmp/init.inferno.sh /tmp/anykernel/ramdisk/init.inferno.sh
chmod 0750 /tmp/anykernel/ramdisk/init.inferno.sh

#move to init.inferno.sh
remove_line init.qcom.rc "    #Reset read ahead for dm-0 and dm-1 to 512kb"
remove_line init.qcom.rc "    write /sys/block/dm-0/queue/read_ahead_kb 512"
remove_line init.qcom.rc "    write /sys/block/dm-1/queue/read_ahead_kb 512"

# end ramdisk changes

write_boot;

## end install

