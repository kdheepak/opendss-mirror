#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
OFS=$IFS
IFS="
"
/usr/bin/ld /usr/lib/dylib1.o    -lc -lm -lgcc_s -lstdc++  -dynamic -dylib -multiply_defined suppress -L. -o /Users/dkrishna/Documents/GitRepos/opendss-tshort/electricdss-code/Source/LazDSS/units/x86_64-darwin/libopendssdirect.dylib `cat /Users/dkrishna/Documents/GitRepos/opendss-tshort/electricdss-code/Source/LazDSS/units/x86_64-darwin/link.res` -exported_symbols_list /Users/dkrishna/Documents/GitRepos/opendss-tshort/electricdss-code/Source/LazDSS/units/x86_64-darwin/linksyms.fpc
if [ $? != 0 ]; then DoExitLink ; fi
IFS=$OFS
