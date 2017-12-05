# Initial setup

## Build

- docker build -f Dockerfile_web -t nginx-php-drupal:7 .
- docker-compose up

## Drupal / Contrib Modules

- Drupal and contrib modules are maintained with drush make
- Make files are located in /src/make

### Installing new modules

Contrib modules can be downloaded with two methods

```
1) Add module straight to contrib.make.yml file and rebuild docker image and update container
```

```
2) Download module normally with drush and update contrib.make.yml by hand
* drush dl module
* drush make-generate
* copy & paste yml provided to contrib.make.yml
** NOTE ONLY PASTE THE PART CONSIDERING NEWLY DOWNLOADED MODULE
```

## Custom modules
- Custom modules are located in src/modules/custom
- When creating new custom module. Add module files to src/modules/custom normally
- To expose it to container, rebuild docker image and restart container

## New site
* Set web environment variable DRUPAL_INIT: 1 to create new settings.php from default.settings.php.
* Go through Drupal installation steps
* Go to settings.php and copy drupal_hash_salt variable value to DRUPAL_HASH_SALT environment or Docker secret variable.
* Set database variables to docker-compose.yml

### Available Drupal specific variables
```
DRUPAL_DATABASE
DRUPAL_DATABASE_USER
DRUPAL_DATABASE_PASSWORD
DRUPAL_HASH_SALT
```

## Drush
Drush is installed globally to docker container so it can be called from container shell.

## Example

```
 docker-compose run --rm drush status
```

# SQL and Drush Commands needed for tek.fi sql import
- UPDATE registry SET filename = REPLACE(filename, 'tek.fi', 'all');
- drush dl registry_rebuild-7.x
- drush rr
- drush vset service_links_path_icons sites/all/modules/contrib/service_links/images
- drush vset tek_sso_report_url  sites/all/modules/custom/tek_membershipcard/font
- drush vset textimage_images_path sites/default/files/membershipcard

- ALTER DATABASE drupal CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
- SELECT CONCAT('ALTER TABLE `', TABLE_NAME,'` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;') AS mySQL FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA= "drupal" AND TABLE_TYPE="BASE TABLE";

# SOLR
Documentation can be found here https://docker4drupal.readthedocs.io/en/latest/containers/solr/


## Setup new solr core
'''
docker-compose exec solr make core=tek_www -f /usr/local/bin/actions.mk
'''