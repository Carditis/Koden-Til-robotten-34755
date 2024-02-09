#!/bin/bash
# script to start applications after a reboot
#
# run the app to show IP of raspberry on the Teensy display.
mkdir -p /home/local/svn/log
cd /home/local/svn/log
# save the last reboot date
echo "Rebooted" >> /home/local/rebootinfo.txt
date >> /home/local/rebootinfo.txt
../robobot/ip_disp/build/ip_disp &
# save PID for debugging
echo "ip_disp started with PID:" >> /home/local/rebootinfo.txt
pgrep -l ip_disp >> /home/local/rebootinfo.txt
exit 0




