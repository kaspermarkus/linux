#!/bin/bash
#
# GPII Unit Tests for Linux
#
# Copyright 2014 Lucendo Development Ltd.
#
# Licensed under the New BSD license. You may not use this file except in
# compliance with this License.
#
# You may obtain a copy of the License at
# https://github.com/GPII/linux/blob/master/LICENSE.txt
#
# The research leading to these results has received funding from the European Union's
# Seventh Framework Programme (FP7/2007-2013) under grant agreement no. 289016.

declare -i error_code

trap 'error_code=$?' ERR EXIT

pushd .
cd ../gpii/node_modules/alsa/test
node alsaSettingsHandlerTests.js
popd

pushd .
cd ../gpii/node_modules/gsettingsBridge/tests
./runUnitTests.sh
cd ../nodegsettings
node .//nodegsettings_tests.js
popd

pushd .
cd ../gpii/node_modules/orca/test
node orcaSettingsHandlerTests.js
popd

pushd .
cd ../gpii/node_modules/packagekit/test/
node .//all-tests.js
cd ../nodepackagekit
node nodepackagekit_test.js
popd

pushd .
cd ../gpii/node_modules/processReporter/test/
node ./all-tests.js
cd ../nodeprocesses
node nodeprocesses_test.js
popd

# These XRANDR tests crash out on my system (AMB - Fedora 19 64-bit in VMWare Workstation 10.0.1 on Windows 7 64-bit) 
node ../gpii/node_modules/xrandr/nodexrandr/nodexrandr_tests.js
node ../gpii/node_modules/xrandr/test/xrandrSettingsHandlerTests.js

if [ -n "$error_code" ]; then
  exit 1
else
  exit 0
fi
