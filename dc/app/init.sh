#!/bin/bash

# Start afresh, make sure there is nothing compiled, because if the project was
# by error compiled in the host, crc32cer might not load. The project has to be
# compiled in the container.
rm -rf deps _build

trap "exit 0" SIGTERM
sleep infinity &
wait $!
