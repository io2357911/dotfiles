TEMPLATE = subdirs

EXTRAS += \
    #intercom_gui \
    libtoolbox \
    libnetcwmp \
    voipd \
    snmpd \
    cwmpd \
    updated

for(dir, EXTRAS) {
    exists($$dir) {
        SUBDIRS += $$dir
    }
}
