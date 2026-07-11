#!/bin/sh

HDMI_SINK="alsa_output.pci-0000_01_00.1.hdmi-stereo"
ANALOG_SINK="alsa_output.pci-0000_09_00.6.analog-stereo"

CURRENT=$(pactl get-default-sink)

TARGET="$HDMI_SINK"
if [ "$CURRENT" = "$HDMI_SINK" ]; then
    TARGET="$ANALOG_SINK"
fi

pactl set-default-sink "$TARGET"
