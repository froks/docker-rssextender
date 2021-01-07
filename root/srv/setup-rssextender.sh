#!/bin/sh

setup_rssextender()
{
    if [ -z "$RSSEXTENDER_REPO_URL" ]; then
        RSSEXTENDER_REPO_URL=https://github.com/lformella/rss-extender
    fi

    RSSEXTENDER_PATH=/var/www/rss_extender

    if [ ! -d ${RSSEXTENDER_PATH} ]; then
        mkdir -p ${RSSEXTENDER_PATH}
        echo "Setup: Setting up Tiny Tiny RSS (latest revision) ..."
        git clone --depth=1 ${RSSEXTENDER_REPO_URL} ${RSSEXTENDER_PATH}
    fi

    # Export variables for sub shells.
    export RSSEXTENDER_PATH
}

setup_rssextender

echo "Setup: Applying updates ..."
/srv/update-rssextender.sh --no-start

echo "Setup: Done"
