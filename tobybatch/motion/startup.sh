#!/bin/bash

set -e
set -x

MOTION_CFG=/core/config_core/motion.conf
MASK_FILE=/data/conf/mask.pgm

# does the video device exist?
if [ -e "/dev/video0" ]; then
  # Add the device to the end of the config file
  echo "videodevice /dev/video0" >> $MOTION_CFG
# elseif does the netcam uri exist
elif [ "$netcam_url" != "false" ]; then
#  Add the netcam stuff to the end of the config file
  echo "netcam_url $netcam_url" >> $MOTION_CFG
  echo "netcam_keepalive on" >> $MOTION_CFG
fi

# Is a mask file present?
if [ -e "$MASK_FILE" ]; then
  # Add it to the rnd of the config file
  echo "mask_file $MASK_FILE" >> $MOTION_CFG
fi

# Add web auth to the end of the config file
echo "webcontrol_authentication admin:motion" >> $MOTION_CFG

# Does an override file (/data/conf/thread1.conf) exist
if [ -e "/data/conf/thread1.conf" ]; then
  # Add it to the end of the conf file
  echo "thread /data/conf/thread1.conf" >> $MOTION_CFG
fi

if [ -e /data/gdrive/token_v2.json ]; then
    if [ "$GDRIVE" != 0 ]; then
        # gdrive upload -p 1ebtXPchANf2J4wHVcWzZcVUgowfLKBxP /data/media/picture/20180408/190032-00.jpg
        sed -i "s/^; on_picture_save.*/on_picture_save gdrive-upload %f/g" $MOTION_CFG
        sed -i "s/^; on_movie_end.*/on_movie_end gdrive-upload %f/g" $MOTION_CFG
    else
        echo "*** You specified a GDIVE tocken but no upload ID ***"
    fi
fi

echo "======================"
cat /core/config_core/README.md
echo "======================"

motion -c $MOTION_CFG
tail -f /var/log/motion/motion.log
