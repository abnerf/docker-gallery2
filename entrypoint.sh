#!/bin/bash

chown -cR www-data:www-data /var/www/
chmod 750 /var/www/

exec apache2ctl -D FOREGROUND
