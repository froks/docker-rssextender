#!/bin/sh

RSSEXTENDER_PATH=/var/www/rss_extender

update_rssextender()
{
    echo "Updating: RSS-Extender"
    ( cd ${RSSEXTENDER_PATH} && git pull origin HEAD )
}

update_common()
{
    # When called initially by setup, it should set the common permissions once, later - when called as www-data,
    # setting them would fail
    CURRENT_UID=$(id -u -n)
    if [ "$CURRENT_UID" != "root" ]; then
      return
    fi

    echo "Updating: Updating permissions"

    echo "Updating common permissions"
    for CUR_DIR in /etc/nginx /etc/php7 /var/lib/nginx /etc/services.d; do
        chown -R root:root ${CUR_DIR}
    done

    chown -R www-data:www-data ${RSSEXTENDER_PATH}

    echo "Updating: Updating permissions done"
}

update_rssextender
update_common

echo "Update: Done"

if [ "$1" != "--no-start" ]; then
    echo "Update: Starting all ..."
fi

if [ "$1" = "--wait-exit" ]; then
    UPDATE_WAIT_TIME=$2
    if [ -z "$UPDATE_WAIT_TIME" ]; then
        UPDATE_WAIT_TIME=24h # Default is to check every day (24 hours).
    fi
    echo "Update: Sleeping for $UPDATE_WAIT_TIME ..."
    sleep ${UPDATE_WAIT_TIME}
fi
