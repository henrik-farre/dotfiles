#!/bin/bash

function localdev-ez-cache-clear() {
  local SITE=$1
  local NAME=$(localdev-get-running-container-name)
  notice "Clearing cache in site $SITE in $NAME container\n"
  # FIXME:
  #docker exec $NAME su - www-data -c php "/var/www/$SITE/public_html/bin/php/ezcache.php --clear-tag=template"
}

function localdev-drupal-cache-clear() {
  local SITE=$1
  local NAME=$(localdev-get-running-container-name)
  notice "Clearing cache in site $SITE in $NAME container\n"
  docker exec $NAME /usr/bin/drush -r "/var/www/$SITE/public_html" cc all
}

function localdev-drupal-set-temp() {
  local SITE=$1
  local NAME=$(localdev-get-running-container-name)
  notice "Setting file_temporary_path for $SITE in $NAME container\n"
  # TODO: Check if tmp exists
  #       Get sitename from path
  docker exec $NAME /usr/bin/drush -r "/var/www/$SITE/public_html" vset file_temporary_path "/var/www/$SITE/tmp"
}

function localdev-prestashop-set-testmode() {
  local SITE=$1
  local NAME=$(localdev-get-running-container-name)
  notice "Setting domains for $SITE in $NAME container\n"
  # TODO: Get sitename from path
  #docker exec "$NAME" bash -c "mysql -e \"CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWD}'; GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost'; FLUSH PRIVILEGES;\""
  local DOMAIN=jvshop.hf
  docker exec "$NAME" bash -c "mysql -e \"UPDATE 'ps_configuration' SET 'value' = '${DOMAIN}' WHERE 'name' = 'PS_SHOP_DOMAIN'; UPDATE 'ps_configuration' SET 'value' = '${DOMAIN}' WHERE 'name' = 'PS_SHOP_DOMAIN_SSL'; UPDATE 'ps_configuration' SET 'value' = 0 WHERE 'name' = 'PS_SSL_ENABLED'; UPDATE 'ps_configuration' SET 'value' = 'hf+test@bellcom.dk' WHERE 'name' = 'PS_SHOP_EMAIL'; UPDATE 'ps_configuration' SET 'value' = 'TEST SHOP' WHERE 'name' = 'PS_SHOP_NAME'; UPDATE 'ps_shop_url' SET 'domain' = '${DOMAIN}', 'domain_ssl' = '${DOMAIN}' WHERE 'ps_shop_url'.'id_shop_url' =1;\""
}

function localdev-site-get-database-value-from-config() {
  local SETTINGS_FILE=$1
  local FIELD=$2
  local VALUE

  if [[ ! -f $SETTINGS_FILE ]]; then
    error "Settings file $SETTINGS_FILE not found"
    return 1
  fi

  case ${SETTINGS_FILE##*/} in
    "settings.php" )
      VALUE=$(php -r "include '${SETTINGS_FILE}'; echo \$databases['default']['default']['${FIELD}'];")
      ;;
    *)
      error "Unknown settings file ${SETTINGS_FILE##*/}"
      return 1
      ;;
  esac

  echo "$VALUE"
}

function localdev-database-export() {
  local DB_NAME=$1
  local NAME=$(localdev-get-running-container-name)
  docker exec "$NAME" bash -c "mysqldump -f --opt -u root -c $DB_NAME | gzip > /var/www/dbdumps/$DB_NAME.sql.gz"
}

function symfony-cache-clear() {
  notice "Clearing cache\n"
  local SYM_ENV=dev_dk
  local COMMAND=cache:clear
  execute-in-docker $COMMAND $SYM_ENV
}

function symfony-redis-clear() {
  notice "Clearing redis cache\n"
  local SYM_ENV=dev_dk
  local COMMAND=hanzo:redis:cache:clear
  execute-in-docker $COMMAND $SYM_ENV
}

function symfony-command() {
  local SYM_ENV=dev_dk
  local COMMAND=$1
  notice "Running command $COMMAND\n"
  execute-in-docker $COMMAND $SYM_ENV
}
