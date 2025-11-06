# By default dropbear doesn't enable x11 forwarding.
# As our customers often use pylonviewer via remote X,
# we enable x11-forwarding when x11 is among the distro features
PACKAGECONFIG_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11-forwarding', '', d)}"

PACKAGECONFIG[x11-forwarding]= ""

do_configure_append() {
    # Check if PACKAGECONFIG includes x11-forwarding
    if echo "${PACKAGECONFIG}" | grep -q "x11-forwarding"; then
        echo "#define DROPBEAR_X11FWD 1" >> ${B}/localoptions.h
    fi
}
