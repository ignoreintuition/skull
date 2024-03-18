#!/bin/bash

# Build mgs
/Applications/PICO-8.app/Contents/MacOS/pico8 skull.p8 -export dist/skull.p8.png

# Run mgs
/Applications/PICO-8.app/Contents/MacOS/pico8 -windowed 0 -run skull.p8 