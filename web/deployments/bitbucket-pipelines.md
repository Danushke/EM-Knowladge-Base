# CI/CD With BitBucket Pipelines

## How it works

Bitbucket Pipelines keeps your build config in a YAML file, named ``bitbucket-pipelines.yml``.

The ``bitbucket-pipelines.yml`` file lives in your repo.

When someone pushes to the repo, Pipelines runs the build in a Docker image.

The ``bitbucket-pipelines.yml file`` is where you can specify the dependencies needed by your project.

## Enable Bitbucket Pipelines

In your new repo, click Pipelines, then click PHP.

## Add the ``bitbucket-pipelines.yml`` config file to the repo

This pipeline will:

- Use the 7.2-fpm Docker image
    - Make sure to check what the minimum PHP version required for your current version of Laravel used in the project. It is usually found in the composer.json file.

```json
 "require": {
      "php": "^7.2",
 }
```
       
- Install dependencies (git, curl) from OS packages
- Install PHP extensions for mcrypt and mysql
- Install Composer
- Use Composer to install PHP dependencies
- Set variables to control which cache, session data store, and database we use
- Use Artisan to perform database migrations
- Use curl to ensure everything is hooked up and working.
- Run PHPunit

Here's the config file to do all that:

```yml
image: php:7.2-fpm

pipelines:
  default:
    - step:
        script:
          - apt-get update && apt-get install -y unzip git curl libmcrypt-dev default-mysql-client
          - yes | pecl install mcrypt-1.0.1
          - docker-php-ext-install pdo_mysql
          - curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
          - composer install
          - ln -f -s .env.pipelines .env
          - php artisan migrate
          - ./vendor/bin/phpunit
        services:
          - mysql

definitions:
  services:
    mysql:
      image: mysql:5.7
      environment:
        MYSQL_DATABASE: 'homestead'
        MYSQL_RANDOM_ROOT_PASSWORD: 'yes'
        MYSQL_USER: 'homestead'
        MYSQL_PASSWORD: 'secret'

```

Then create an .env.pipelines file in the root of the reposity, as shown below. The bitbucket-pipelines.yml file copys this into the default .env location in the root of the project.

```env
APP_ENV=local
APP_KEY=ThisIsThe32CharacterKeySecureKey
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_DATABASE=homestead
DB_USERNAME=homestead
DB_PASSWORD=secret
```

Make sure you add the .env.pipelines file before committing to the repo.

## Push to the repository

Before you actually push to the repository make sure you generate an ssh key from your bitbukcet account and add it to the repository you are about to push to.

To generate a ssh key from bitbucket follow the steps from
the bitbucket guide [here](https://confluence.atlassian.com/x/X4FmKw).

When you commit and push to the repo in Bitbucket, Pipelines with automatically run the build.



---

Last updated - **23 April 2020** | Edited by - **Thavarshan** | Laravel version - **6.2** | PHP version - **7.2**
