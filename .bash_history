ls
mkdir Documents
mkdir svn
sudo apt update
sudo apt dist-upgrade
sudo apt install ntp ntpdate libreadline-dev subversion libopencv-dev python3-pyqtgraph python3-scipy pyqt5-dev pyqt5-dev-tools festival sox libsox-fmt-all apt-file kate qv4l2 v4l-utils xinit cmake pip
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
ls
cd svn/
ls
svn co svn://repos.gbar.dtu.dk/jcan/robobot
svn co svn://repos.gbar.dtu.dk/jcan/regbot
svn co svn://repos.gbar.dtu.dk/jcan/fejemis
cd robobot/
ls
cd setup/
ls
cd
ln -s svn/robobot/setup/start_bridge.sh 
ln -s svn/regbot/regbot_gui
ln -s svn/fejemis/ROS/catkin_ws
cd catkin_ws
ls
rosws init . /usr/share
ls
echo "source /home/local/svn/fejemis/ROS/catkin_ws/setup.bash" >> ~/.bashrc
catkin_make
ls
crontab -e
ls
crontab -e
cd
less start_bridge.sh 
nano start_bridge.sh 
cd svn/robobot/
svn commit -m "added 'as daemon (-d) in start script' 
svn commit -m "added 'as daemon (-d) in start script'"
less setup/start_bridge.sh 
svn up
cd
date
sudo nano /etc/ntp.conf
sudo reboot now
ls
less rebootinfo.txt 
pgrep bridge
ls
ln -s catkin_ws/devel/lib/bridge/bridge
ls
pgrep roscore
./bridge 
ls
less bridge.ini 
sudo reboot now
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf 
sudo reboot now
ifconfig
iwconfig
ifconfig
hostname -l
hostname -I
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf 
sudo reboot
ifconfig
pgrep bridge
ifconfig
ping ait-pisepsn02.win.dtu.dk
ip r
less /etc/dhcpcd.conf 
ifconfig
pgrep bridge
sudo nano /etc/dhcpcd.conf 
sudo reboot
ifconfig
ip -l
ip -a
ipconfig
ifconfig
ip -l eth0
ifconfig
top
ls
less rename_host.bash 
cd regbot_gui
cd
cd svn/regbot/regbot
ls
ln -s /home/local/Downloads/arduino-1.8.19/hardware/teensy/avr/libraries/
ls
ln -s /home/local/Downloads/arduino-1.8.19/hardware/teensy/avr/cores/teensy3
ln -s /home/local/Downloads/arduino-1.8.19/hardware/teensy/avr/cores/teensy4
ls-l
ls -l
ln -s /home/local/Downloads/arduino-1.8.19/hardware/tools/
ln -s tools/teensy
ls
make
cd 4.1/
make -j2
nano Makefile 
ls -l ../src
nano Makefile 
make
nano Makefile 
make
nano Makefile 
make
cd ..
cd src/
ls
cp -r ~/Arduino/libraries/Adafruit_BusIO .
cp -r ~/Arduino/libraries/Adafruit_GFX_Library .
ls
ls Adafruit_*
mv Adafruit_BusIO ~/Downloads/arduino-1.8.19/hardware/teensy/avr/libraries/
mv Adafruit_GFX_Library ~/Downloads/arduino-1.8.19/hardware/teensy/avr/libraries/
ls
make
cd ..
make
cd 4.1/
make
cd ~/Downloads/arduino-1.8.19/hardware/teensy/avr/libraries/
ls
find splash.h
find * -name splash.h
cd
cd Arduino/
find * -name splash.h
ls
cd libraries/
ls
cd ~/Downloads/arduino-1.8.19/hardware/teensy/avr/libraries/
ls
rm -r Adafruit_BusIO
rm -r Adafruit_GFX_Library
ln -s ~/Arduino/libraries/* 
ls
ln -s ~/Arduino/libraries/Adafruit_*
ls
ln -s ~/Arduino/libraries/Adafruit_BusIO
ls
ln -s ~/Arduino/libraries/Adafruit_GFX_Library
ln -s ~/Arduino/libraries/Adafruit_SSD1306_EMULATOR
ls
cd
cd svn/regbot/regbot/4.1/
make
svn revert Makefile 
make clean
make -j3
cd
cd Downloads/
ls
ls /etc/udev/rules.d/
ls -l
cd 
ls
mkdir git
cd git
git clone https://github.com/adafruit/Adafruit_SSD1306.git
git clone https://github.com/adafruit/Adafruit-GFX-Library.git
git clone https://github.com/adafruit/Adafruit_BusIO.git
ls -l
cd
cd Downloads/
cd arduino-1.8.19/hardware/teensy/avr/libraries/
ls
ln -s Adafruit-GFX-Library Adafruit_GFX_Library
ls Adafruit_GFX_Library
rm Adafruit_GFX_Library
mv Adafruit-GFX-Library Adafruit_GFX_Library
ls
ln -s Adafruit_GFX_Library Adafruit-GFX-Library
cd
ls
./regbot_gui
cd regbot_gui
./regbot.py 
pip install pyserial
./regbot.py 
q
./regbot.py 
sudo nano hostname
sudo nano /etc/hostname
sudo nano /etc/hosts
sudo reboot
w
cd Downloads/arduino-1.8.19/
ls
ls libraries/
find . -name 'AdaFruit*'
./arduino
ifconfig
cd Documents/
ls
cd
ls
mv Downloads arduino-1.8.19-linuxarm.tar.xz
mkdir Downloads
mv arduino-1.8.19-linuxarm.tar.xz Downloads/
cd Downloads/
tar -xf arduino-1.8.19-linuxarm.tar.xz 
ls
sudo cp 00-teensy.rules /etc/udev/rules.d/
ls
chmod +x TeensyduinoInstall.linuxarm 
./TeensyduinoInstall.linuxarm 
cd arduino-1.8.19/
ls
./arduino
cd
find * -name '*AdaFruit*'
find * -name '*adafruit*'
ls
cd Arduino/libraries/
ls
cd
cd Downloads/
cd arduino-1.8.19/hardware/teensy/avr/libraries/
ls
ls -l
rm Adafruit_SSD1306_EMULATOR
rm Adafruit_GFX_Library
rm Adafruit_BusIO
ln -s ~/git/Adafruit-GFX-Library
ln -s ~/git/Adafruit_SSD1306
ln -s ~/git/Adafruit_BusIO/
ls
cd
cd svn/regbot/regbot
ls
ls -l
make
cd 4.1/
make
make clean
make -j3
make upload
make
make clean
make -j3 upload
aptitude 
sudo apt install aptitude
aptitude search libusb
sudo apt install libusb-0.1-4 
make -j3 upload
nano Makefile 
grep Adafruit_GFX Makefile 
grep GFX Makefile 
make upload
make
make clean
make -j3
make
make upload
pip
pip install pyqt5
pip install pyqtgraph
aptitude search pyserial
aptitude search serial
sudo apt install python3-serial
pgrep roscore
less rename_host.bash 
ls
ls -l
less rename_host.sh 
cd svn/robobot/
svn up
cd
ls
less rename_host.sh 
rm rename_host.sh 
rm rename_host.bash 
ln -s svn/robobot/setup/rename_host.sh 
ls
cd svn/robobot/setup/
ls
cd
./rename_host.sh 
less /etc/hostname
less /etc/hosts
sudo reboot
ls
less rebootinfo.txt 
pgrep -l bridge
less rebootinfo.txt 
sudo nano /etc/init.d/robobot_rename_test.sh 
sudo nano /etc/init.d/kmod 
sudo nano /etc/init.d/robobot_rename_test.sh 
ls /etc/rc2.d/
ls /etc/rc2.d/ -l
ls /etc/rc3.d/ -l
cd /etc/rc2.d/
ls
sudo ln -s ../init.d/robobot_rename_test.sh S99robobot
ls
ls -l
sudo reboot
sudo nano /etc/init.d/robobot_rename_test.sh 
ls
sudo ./rename_host.sh 
cat /etc/hostname
cat /etc/hosts
less robotname 
pgrep bridge
nano robotname 
sudo ./rename_host.sh 
cat /etc/hosts
cat /etc/hostname
cate robotname 
cat robotname 
less rename_host.
less rename_host.sh 
nano rename_host.sh 
sudo ./rename_host.sh 
cat /etc/hostname 
nano rename_host.sh 
hostname
sudo reboot
sudo ./rename_host.sh 
hostname
cat /etc/hostname
ls
less rename_host.bash 
dmesg
cd /etc
sudo cp rc2.d/S99robobot rc3.d/
ls rc3.d/
ls rc3.d/ -l
sudo rm rc3.d/S99robobot 
cd rc3.d/
ls
ln -s ../init.d/robobot_rename_test.sh S99robobot_rename_test.sh
sudo ln -s ../init.d/robobot_rename_test.sh S99robobot_rename_test.sh
ls
sudo reboot now
ls
less reboot_as_root.txt 
rm aaa.txt 
rm rename_host.sh 
rm reboot_as_root.txt 
ls
ls -l
rm rename_host.bash 
cd /etc/init.d
ls
sudo mv robobot_rename_test.sh robobot_rename
sudo nano robobot_rename 
cd ../rc2.d/
ls
sudo rm S99robobot 
cd ../rc3.d/
ls
sudo rm S99robobot_rename_test.sh 
sudo ln -s ../init.d/robobot_rename S99robobot_rename
ls
cd
cd catkin_ws
catkin_make
svn up
catkin_make
cd
cd svn/robobot/
svn up
svn status -q
less setup/rename_host.sh 
cat setup/bridge.ini 
svn revert setup/rename_host.sh 
svn status -q
svn diff user_mission/CMakeLists.txt 
svn commit -m "renamed mission and stopper bridge-logging"
svn up
ls
cd
ls
ls -l log_20230121_090947.779/
sudo nano /etc/init.d/robobot_rename 
sudo reboot now
ls
cat robotname 
sudo reboot
mkdir Music
ls
cd Music/
ls
ln -s radetzky-marsch_Schloss-Schoenbrunn-Konzerte_Wien_full-length.mp3 music.mp3
play music.mp3 
cd
play Music/music.mp3 
ls
cd mission
ls
svn up
cd build/
make
cmake ..
rm -r *
cmake ..
make
./mission 
svn up
cd ..
svn up
cd build/
make
./mission 
make
svn up ..
make
./mission 
svn up ..
make
./mission 
svn up ..
make
./mission 
svn up ..
make
./mission 
svn up ..
make
./mission 
svn up ..
make
svn up ..
make
./mission 
svn up ..
make
svn up ..
make
./mission 
svn up ..
make
./mission 
svn up ..
make
./mission 
svn up ..
make
./mission 
svn up ..
make
./mission 
play -v0.01 ~/Music/music.mp3 
svn up ..
make
./mission 
play --help
echo -e "mute 0\n" > /dev/ttyACM0
play -v0.01 ~/Music/music.mp3 
play -v0.02 ~/Music/music.mp3 
play -q -v0.02 ~/Music/music.mp3 
play -q ~/Music/music.mp3 
play -q -v0.020 ~/Music/music.mp3 
nice -n14 play -q -v0.020 ~/Music/music.mp3 
svn up ..
make
./mission 
svn up ..
make
./mission 
svn up ..
make
./mission 
svn up ..
cd
cd svn regbot_gui
cd svn
cd regbot/
svn up
cd
ls
cd svn
cd fejemis/
svn up
cd
cd catkin_ws
catkin_make
cd
ls
ls mission
cd mission
svn up
cd
cd svn
ls
cd robobot/
svn up
cd user_mission/
cd build/
make
cd ..
cd regbot/regbot/4.1/
make
make upload
cd
cd svn/robobot/
svn up
cd
ln -s svn/robobot/setup/start_mission.sh 
ls
ls -l
cat start_mission.sh 
less bridge.ini 
ls
cd svn/robobot/
svn up
cd
sudo reboot
cd svn/regbot/regbot/4.1/
make upload
exit
nano bridge.ini
cd svn/regbot/
svn up
cd
cd svn/regbot/regbot/4.1/
make -j3
make upload
cd 
nano bridge.ini 
ssh exit
ssh --help
xit
exit
cd catkin_ws
svn up
catkin_make clean
catkin_make --only-pkg-with-deps bridge
sudo reboot now
ls /dev
cd svn/robobot/raubase/build/
./raubase 
cd ..
ls
cd ip_disp/
ls
mkdir build
cd build/
cmake ..
make -j3
./ip_disp 
cd svn/robobot/
svn up
cd setup/
ls
cp on_reboot.bash ~/
crontab -e
cd ..
ls
mkdir log
cd log/
ls ~/svn/robobot/setup/
less /hostname
less /etc/hostname
sudo nano /etc/init.d/host_rename.sh
sudo chmod +x /etc/init.d/host_rename.sh
sudo ln -s /etc/init.d/host_rename.sh /etc/rc2.d/S99host_rename
sudo reboot now
cd svn/robobot/raubase/build/
ls
ls ..
ls .. -n
./raubase 
svn up ..
make -j3
./raubase 
nano robot.ini 
exit
cd svn
ls
cd robobot/
cd raubase
cd build/
ls
./raubase 
cd svn
svn up
cd robobot/
svn up
cd ..
cd regbot/
ls
svn up
cd regbot
cd 4.1/
make
make -j3
ls
./upload.sh 
cd
ls
ls -l
less on_reboot.bash 
sudo shutdown now
                                                          cd svn/regbot/regbot_gui
./regbot.py 
exit
cd svn/robobot/raubase/build/
./raubase 
less robot.ini
./raubase 
nano robot.ini
./raubase 
ls
svn up ..
make
./raubase 
svn up ..
make
./raubase 
ls 
./raubase 
ls
svn up ..
make -j3
./raubase 
ls
nano robot.ini
svn up ..
make -j3
./raubase 
ls
svn up ..
make -j3
./raubase 
ls
svn up ..
make -j3
./raubase 
ls
exit
cd svn/regbot/regbot_gui
./regbot.py 
cd 
cd svn/robobot//raubase/build//
ls
cd log_20231219_145852.235/
ls
ls -l
cd ..
cd
cd svn/regbot/regbot_gui
./regbot.py 
sudo shutdown now
cd svn/robobot/
svn up
cd raubase
cd build/
ls
ln -s log_20231219_174652.915 data
ls
ls data
ls data -l
ls data/ -l
mkdir matlab
cd matlab/
matlab
cd ..
rmdir matlab
rm data
ls
cd ..
cd
cd svn/regbot/regbot_gui
./regbot.py 
cd svn/robobot/
cd raubase/build/
ls
./raubase 
ls
./raubase 
ls
svn up ..
make -j3
./raubase 
ls
./raubase 
ls
./raubase 
df
ls
rm -r log_2023121*
ls
df
./raubase 
svn up ..
make -j3
svn up ..
make -j3
./raubase 
ls
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
ls
./raubase 
ls
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
cd ..
cd matlab/
ls
cd ..
svn up
sudo shutdown now
cd svn
cd regbot/regbot_gui
./regbot.py 
cd
ls
less robotname 
less rebootinfo.txt 
less on_reboot.bash 
crontab -e
less on_reboot.bash 
less rebootinfo.txt 
rm rebootinfo.txt 
rm robotname 
cd svn/log
ls
less robotname 
less rebootinfo.txt 
cd
ls
less on_reboot.bash 
cd /etc/
ls
ls -l rc.local
sudo nano rc.local
sudo nano init.d/host_rename.sh 
cd 
cd svn/robobot/setup/
ls
nano rename_host.bash 
cd
cd svn/log/
ls
less log_rename.txt 
cd ..
cd robobot/setup/
ls
cd
ls
less aaa.txt 
cd svn/robobot/setup/
ls
nano rename_host.bash 
cd
ls
rm aaa.txt 
ls -l
less mission_start.bash 
sudo reboot now
ls
less rebootinfo.txt 
sudo reboot now
ls
less rebootinfo.txt 
pgrep ip
pgrep -v ip
pgrep -u ip
top
pgrep ip_disp
ls
nano on_reboot.bash 
less on_reboot.bash 
nano on_reboot.bash 
less on_reboot.bash 
cd svn/robobot/setup/
less rename_host.bash 
nano rename_host.bash 
ls
ls rpi-clone/
cd
ls
less rebootinfo.txt 
sudo reboot now
less rebootinfo.txt 
cd svn/robobot/setup/
nano rename_host.bash 
ls
ls -l
ls ~/
ls ~/ -l
nano rename_host.bash 
cd
ls
sudo rm rebootinfo.txt 
sudo reboot
ls
less rebootinfo.txt 
cd svn/robobot/setup/
ls
cd ..
cd setup/
nano rename_host.bash 
sudo reboot now
cd svn/robobot/setup/
ls -l
cd ..
cd
ls
ls -l
less rebootinfo.txt 
cd svn
find * -name rebootinfo.txt
cd log
ls -l
less log_ip_disp_2023
less log_ip_disp_20231222_104230.787.txt 
rm log_ip_disp_202311*
ls
rm log_ip_disp_202310*
rm log_ip_disp_202309*
ls
rm log_ip_disp_2023121*
ls
ls -l
less log_ip_disp_20231221_131707.655.txt 
man abs
man absf
man fabs
cd ..
cd robobot/
svn status -q
svn commit -m"script update"
ls /
ls /root
sudo ls /root
cd /etc
find * -name rebootinfo.txt
cd
cd svn
cd robobot/
svn up
sudo reboot now
cd svn/log/
ls
ls -l
less log_rename.txt 
less rename_info.txt 
sudo rm log_rename.txt 
rm log_teensy.txt 
cd ..
cd robobot/
svn up
cd raubase/build/
make -j3
./raubase --help
./raubase -w
svn up ..
make -j3
./raubase -w
svn up ..
make -j3
./raubase -w
svn up ..
make -j3
./raubase -w
svn up ..
make -j3
./raubase -w
./raubase -b
make -j3
svn up ..
make -j3
./raubase -b
./raubase -w
svn up ..
make -j3
./raubase -w
sudo apt update
sudo apt dist-upgrade
cd ..
svn status -q
sudo shutdown now
cd svn/log
ls
less rename_info.txt 
less log_teensy.txt 
less rebootinfo.txt 
less robotname 
sudo reboot now
cd svn/robobot/
svn up
cd raubase/build/
make
svn up ..
make -j3
./raubase -h
./raubase -n 103
./raubase --number 103
./raubase -n103
cd svn/regbot/
svn up
cd
cd svn/robobot/
svn up
cd raubase
cd build/
make -j3
ls data
ls
rm -r log_2023122*
ls
rm -r log
sudo reboot now
cd svn/robobot/raubase/build/
ls
./raubase -h
./raubase -b
./raubase -n 103
./raubase -b
svn up ..
make -j3
./raubase -n 103
./raubase -b
svn up ..
make -j3
./raubase -b
./raubase -w
grep heading ../src/*.cpp -n
./raubase -w
sudo shutdown now
sudo apt update
aptitude search ros
sudo apt remove ros-base
sudo apt autoremove
df
aptitude search ros
sudo apt remove python3-roslib
sudo apt autoremove
ls
ls Documents/
ls Downloads/
ls git
ls svn
cd svn
ls
ls fejemis/
rm -r fejemis
rm -r fejemis -f
ls
ls log
ls log -l
rm log/log_ip_disp_2023122*
ls log -l
cd
df
ls .??*
rm -r .ros
ls .local/
du .local
sudo apt update
sudo nano /etc/apt/sources.list
cd /etc
find * -name '*ros*'
aptitude search catkin
sudo apt remove catkin
sudo apt remove python3-catkin-pkg
sudo apt autoremove
find * -name '*ros*'
cd apt/sources.list.d/
ls
less raspi.list 
less ros-latest.list 
rm ros-latest.list 
sudo rm ros-latest.list 
sudo apt update
sudo apt list --upgradable
sudo apt dist-upgrade
cd ..
ls ros
sudo rm -r ros
ls
find * -name '*ros*'
sudo rm -r catkin
find * -name '*ros*'
cd bash_completion.d/
ls
less rosbash 
sudo rm rosbash 
cd
ls
cd /usr
ls
ls bin
cd ..
cd /opt/
ls
cd
cd var
cd /var
ls
find * -name '*ros*'
cd
cd svn/regbot/regbot_gui
./regbot.py 
cd
cd svn/robobot/
ls
cd socket-base-py/
ls
python3 socket-base-py.py 
cd svn/robobot/
cd raubase
cd build/
./raubase 
nano robot.ini
./raubase 
nano robot.ini
./raubase 
cd
cd etc
cd /etc
cd init.d/
ls
cd ..
ls
find * -name '*fejemis*'
find * -name '*ros*'
ls
less rc.local 
sudo nano rc.local
ls rc?.d
ls init.d
cd init.d
less robobot_rename 
less host_rename.sh 
cd
cd svn/robobot/setup/
ls
less /etc/init.d/robobot_rename 
sudo rm /etc/init.d/robobot_rename 
cd /etc/init.d
ls
grep ros *
grep ROS *
grep catkin *
cd
nano .bashrc
sudo reboot now
nano .bashrc
exit
nano .bashrc
exit
nano .bashrc
exit
cd svn/robobot/raubase/build/
ls
./raubase 
make -j3
nano robot.ini
./raubase 
sudo shutdown now
cd svn/robobot/
cd socket-base-py/
ls
python3 socket-base-py.py 
svn up
python3 socket-base-py.py 
pgrep socket-base
pgrep python3
python3 socket-base-py.py 
cd ..
svn up
sudo apt update
sudo shutdown now
cd svn/robobot/build
cd svn/robobot/raubase/build
ls
./raubase --white
./raubase --black
ls ../src
svn status -q
svn status -q ..
svn rm ../src/bplan1.h
svn rm ../src/bplan1.cpp
svn status -q ..
steam
exit
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          cd svn/robobot/raubase/build
svn up ..
make -j3
nano robot.ini
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
./raubase -w
./raubase -b
./raubase 
svn up ..
make -j3
./raubase 
ls
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
svn up ..
./raubase 
make -j3
./raubase 
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
./raubase -h
./raubase -s1 -c13
./raubase -s1 -c50
./raubase 
ls
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
svn up ..
make -j3
./raubase 
sudo apt update
sudo apt dist-upgrade
sudo shutdown now
ifconfig
cd /etc/network/
ls
sudo nano interfaces
sudo nano interfaces.new 
sudo nano interfaces
cd interfaces.d/
ls
exit
ls
ls -l
ls
libcamera-vid -h
libcamera-vid -t 0 --inline --listen -o tcp://0.0.0.0:8554
cd git
git clone https://github.com/TheTridentGuy/opencv-fpv-server.git
ls
cd opencv-fpv-server/
ls
kate server.py 
python3 server.py 
aptitude search opencv
sudo apt install python3-opencv
python3 server.py 
ls /dev
aptitude search websocket
sudo apt install python3-websockets
python3 server.py 
aptitude search gstreamer
sudo apt install libgstreamer-opencv1.0-0
sudo apt install libgstreamer-opencv1.0
python3 server.py 
sudo apt remove libgstreamer-opencv1.0-0
sudo apt remove python3-websockets
sudo apt remove python3-opencv
pip install python3-opencv
pip install opencv
pip install libopencv
pip install websockets
python3 server.py 
pip install libopencv-dev
pip remove libopencv
pip uninstall libopencv
pip uninstall websockets
python3 server.py 
sudo apt install python3-opencv
sudo apt install python3-websockets
python3 server.py 
cd
mkdir aaa
cd aaa
nano cam_stream.py
python3 cam_stream.py 
nano cam_stream.py
ls
cd ..
rm -r aaa
sudo apt install motion
cd git/
ls
cd opencv-fpv-server/
ls
python3 server.py 
cd
sudo nano /etc/motion/motion.conf 
motion
sudo nano /etc/motion/motion.conf 
motion
sudo nano /etc/motion/motion.conf 
ls Video/
ls Video/motion/
sudo nano /etc/motion/motion.conf 
motion
sudo nano /etc/motion/motion.conf 
motion
sudo nano /etc/motion/motion.conf 
ls
cd Video/
ls
cd motion/
ls
motion
sudo nano /etc/motion/motion.conf 
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf 
motion
ifconfig
motion
ls /dev
sudo reboot now
qv4l2 
cd svn/robobot/ls
cd svn/robobot/
ls
cd socket-base-py/
ls
ls -l
python3 socket-base-py.py 
ls
cd
ls
mkdir Video
motion
sudo nano /etc/motion/motion.conf 
motion
sudo nano /etc/motion/motion.conf 
motion
sudo nano /etc/motion/motion.conf 
motion
sudo nano /etc/motion/motion.conf 
motion
ls
cd Video/motion/
ls -l
ls /dev/vid*
sudo nano /etc/motion/motion.conf 
motion
sudo nano /etc/motion/motion.conf 
motion
sudo nano /etc/motion/motion.conf 
ls /dev
sudo modprobe v4l2loopback
aptitude search v4l2loopback
sudo apt install v4l2loopback
sudo apt install v4l2loopback-utils 
sudo apt update
sudo modprobe v4l2loopback
ls /dev/video*
motion
exit
             motion
cd svn/robobot/raubase
svn up
cd build
make -j3
nano robot.ini 
./raubase -i
svn up ..
make -j3
./raubase -i
nano robot.ini 
./raubase -i
ls img/
sudo nano /etc/motion/motion.conf 
motion
./raubase -i
motion
sudo nano /etc/motion/motion.conf 
motion
./raubase -i
motion
./raubase -i
motion
./raubase -i
motion
./raubase -i
motion
sudo nano /etc/motion/motion.conf 
motion
pgrep motion
pkill motion
pgrep motion
pkill -9 motion
pgrep motion
motion
./raubase -i
sudo reboot now
cd svn/robobot/raubase/build
make
./raubase -i
lsof /dev/video*
./raubase -i
sudo reboot now
cd svn/robobot/raubase/build
./raubase -i
pgrep nano
nano robot.ini 
svn up ..
make -j3
./raubase -m
less log_20240111_175558.741/log_camera.txt 
make
svn up ..
make -j3
./raubase -i
top
ls /dev/video*
cd svn/robobot/raubase/build
nano robot.ini
./raubase -i
cat /dev/video1
cat /dev/video0
nano robot.ini
cat /dev/video0
./raubase -i
exit
cd svn/robobot//raubase/build
svn up ..
make -j3
sudo nano /etc/motion/motion.conf 
motion
sudo nano /etc/motion/motion.conf 
motion
sudo nano /etc/motion/motion.conf 
motion
pgrep motion
pkill motion
pgrep motion
pkill motion
pkill -2 motion
pkill -3 motion
pkill -4 motion
pkill -5 motion
pgrep motion
pkill -6 motion
pkill -7 motion
pkill -8 motion
pkill -9 motion
motion
exit
cd svn/robobot/raubase/build
ls
rm -r log_2*
ls log
rm -r log
rm log_*.txt
ls
svn up ..
make -j3
svn up ..
make -j3
nano robot.ini 
./raubase
nano robot.ini 
./raubase
nano robot.ini 
./raubase
nano robot.ini 
./raubase
nano robot.ini 
./raubase
nano robot.ini 
./raubase
nano robot.ini 
./raubase
nano robot.ini 
./raubase
svn up ..
make -j3
./raubase
svn up ..
make -j3
./raubase
svn up ..
make -j3
./raubase
svn up ..
make -j3
./raubase
svn up ..
make -j3
./raubase
svn up ..
make -j3
./raubase
exit
cd svn/robobot/
svn up
ls
ls user_mission/
rm -r user_mission/
ls
cd raubase/
ls
cd build
ls
cd ..
rm -r build
ls
df
cd
ls
ls Downloads/
cd svn/regbot/
svn up
cd regbot
cd 4.1/
make
ls
./upload.sh 
cd
cd svn/robobot/raubase/
ls
less robot.ini 
svn up
ls
sudo shutdown now
df
cd svn/robobot/
svn up
sudo apt update
cd
cd svn
ls
cd robobot/
ls
cd setup/
ls
cd rpi-clone/
ls
ls /dev
ls
./rpi-clone-setup 
sudo ./rpi-clone-setup 
sudo ./rpi-clone
sudo ./rpi-clone sda
top
w
ls /dev
sudo ./rpi-clone sda
cd svn/robobot/setup/
ls
sudo ./rpi-clone sda
cd rpi-clone/
sudo ./rpi-clone sda
sudo reboot
cd svn/robobot/raubase/build-old/
cd ..
ls
ls build-old/
mkdir build
cd build-old/
ls
./raubase --help
./raubase -n 121
sudo reboot
cd svn/robobot/
cd setup/rpi-clone/
sudo ./rpi-clone sda
ls /mnt
ls /mnt/clone
sudo mount /dev/sda2 /mnt/clone
mkdir aaa
sudo mount /dev/sda2 aaa
sudo ./rpi-clone sda
sudo ./rpi-clone --help
sudo ./rpi-clone sda -L robobot
less svn/log/robotname 
sudo reboot
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              ls
