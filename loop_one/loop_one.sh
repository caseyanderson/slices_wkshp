#!/bin/bash

THE_SCRIPT="/home/pi/slices_wkshp/loop_one/loop_one.scd"
THE_DIR="/home/pi/recordings"
THE_FILE="haiti.wav"

THE_PATH=$THE_DIR/$THE_FILE

./sclang -a -l sclang.yaml $THE_SCRIPT $THE_PATH
