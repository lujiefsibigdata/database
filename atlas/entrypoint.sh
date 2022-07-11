#!/bin/bash
/opt/atlas/bin/atlas_start.py & \
    mkdir /opt/atlas/logs/ \
    && touch /opt/atlas/logs/application.log \
    && tail -f /opt/atlas/logs/application.log | sed '/AtlasAuthenticationFilter.init(filterConfig=null)/ q' \
    && sleep 10 \
    && /opt/atlas/bin/atlas_stop.py
