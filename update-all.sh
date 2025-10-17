test -e ~/katapult && (cd ~/katapult && git pull) || (cd ~ && git clone https://github.com/Arksine/katapult) ; cd ~
sudo service klipper stop
cd ~/klipper
git pull

make clean KCONFIG_CONFIG=config.ebb36
make menuconfig KCONFIG_CONFIG=config.ebb36
make KCONFIG_CONFIG=config.ebb36

read -p "ebb36 firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

python3 ~/katapult/scripts/flashtool.py -i can0 -u 2121a773d031 -r
python3 ~/katapult/scripts/flashtool.py -i can0 -u 2121a773d031 -f ~/klipper/out/klipper.bin

read -p "ebb36 firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

make clean KCONFIG_CONFIG=config.mantam8p
make menuconfig KCONFIG_CONFIG=config.mantam8p

make KCONFIG_CONFIG=config.mantam8p

read -p "Manta M8P firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

python3 ~/katapult/scripts/flashtool.py -i can0 -u 1de864683a51 -r

sleep 1

python3 ~/katapult/scripts/flashtool.py -f ~/klipper/out/klipper.bin -d /dev/serial/by-id/usb-katapult_stm32h723xx_490031001751313433343333-if00

sudo service klipper start
