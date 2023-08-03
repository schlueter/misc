git clone git://anongit.freedesktop.org/pulseaudio/pulseaudio
cd pulseaudio
gco v9.0
sudo apt install \
    bluetooth \
    bluez-hcidump \
    bluez-tools \
    intltool \
    intltoolize \
    libbluetooth3-dev \
    libcap-dev \
    libdbus-1-dev \
    libjson-c-dev \
    libsbc-dev
    libsndfile1-dev \
    libspeex-dev \
    libspeex1 \
    libspeexdsp-dev \
    libudev-dev \
make
sudo make install
cd workspace/public/pulseaudio
./bootstrap.sh --prefix=/usr
pacmd load-module module-bluez5-device
pacmd set-card-profile 10 a2dp_sink
pacmd load-module module-bluez5-device path=/org/bluez/hci0/dev_44_5E_F3_B5_8A_3F
pacmd list-cards
pacmd set-card-profile 12 a2dp_sink
pacmd set-default-sink 10
