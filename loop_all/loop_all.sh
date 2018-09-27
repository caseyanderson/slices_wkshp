#!/bin/bash

THE_SCRIPT="/home/pi/slices_wkshp/loop_all/loop_all.scd"
THE_DIR="/home/pi/recordings"

./sclang -a -l sclang.yaml $THE_SCRIPT $THE_DIR
