TEMPLATE = subdirs

EXTRAS += \
    asu \
    stand \
    tests

for(dir, EXTRAS) {
    exists($$dir) {
        SUBDIRS += $$dir
    }
}
