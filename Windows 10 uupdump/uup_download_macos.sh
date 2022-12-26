#!/bin/bash
#Generated on 2022-12-26 12:24:18 GMT

# Proxy configuration
# If you need to configure a proxy to be able to connect to the internet,
# then you can do this by configuring the all_proxy environment variable.
# By default this variable is empty, configuring aria2c to not use any proxy.
#
# Usage: export all_proxy="proxy_address"
# For example: export all_proxy="127.0.0.1:8888"
#
# More information how to use this can be found at:
# https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-all-proxy
# https://aria2.github.io/manual/en/html/aria2c.html#environment

export all_proxy=""

# End of proxy configuration

for prog in aria2c cabextract wimlib-imagex chntpw; do
  which $prog &>/dev/null 2>&1 && continue;

  echo "$prog does not seem to be installed"
  echo "Check the readme.unix.md for details"
  exit 1
done

mkiso_present=0
which genisoimage &>/dev/null && mkiso_present=1
which mkisofs &>/dev/null && mkiso_present=1

if [ $mkiso_present -eq 0 ]; then
  echo "genisoimage nor mkisofs does seem to be installed"
  echo "Check the readme.unix.md for details"
  exit 1
fi

destDir="UUPs"
tempScript="aria2_script.$RANDOM.txt"

echo "Downloading converters..."
aria2c --no-conf --log-level=info --log="aria2_download.log" -x16 -s16 -j5 --allow-overwrite=true --auto-file-renaming=false -d"files" -i"files/converter_multi"
if [ $? != 0 ]; then
  echo "We have encountered an error while downloading files."
  exit 1
fi

echo ""
echo "Retrieving aria2 script..."
aria2c --no-conf --log-level=info --log="aria2_download.log" -o"$tempScript" --allow-overwrite=true --auto-file-renaming=false "https://uupdump.net/get.php?id=3adc13dd-3158-47b2-bbbc-ddc3a1e20663&pack=en-us&edition=core;professional&aria2=2"
if [ $? != 0 ]; then
  echo "Failed to retrieve aria2 script"
  exit 1
fi

detectedError=`grep '#UUPDUMP_ERROR:' "$tempScript" | sed 's/#UUPDUMP_ERROR://g'`
if [ ! -z $detectedError ]; then
    echo "Unable to retrieve data from Windows Update servers. Reason: $detectedError"
    echo "If this problem persists, most likely the set you are attempting to download was removed from Windows Update servers."
    exit 1
fi

echo ""
echo "Attempting to download files..."
aria2c --no-conf --log-level=info --log="aria2_download.log" -x16 -s16 -j5 -c -R -d"$destDir" -i"$tempScript"
if [ $? != 0 ]; then
  echo "We have encountered an error while downloading files."
  exit 1
fi

echo ""
if [ -e ./files/convert.sh ]; then
  chmod +x ./files/convert.sh
  ./files/convert.sh wim "$destDir" 0
fi
