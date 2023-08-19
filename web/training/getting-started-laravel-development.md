# Getting Started Laravel Development

Laravel development requires **Apache**, **PHP**, **MySQL/MariaDB** and **Composer** set up on your computer. If you do not have these already set up please refer to following guides on setting them up based on your operating system.

- **Mac:** [Set up Mac for Laravel Development](set-up-mac-for-laravel-development.md)
- **Linux:** [Set up Linux for Laravel Development](set-up-linux-for-laravel-development.md)
- **Windows:** [Set up Windows for Laravel Development](set-up-windows-for-laravel-development.md)


## Create a new Laravel project

Once you have successfully set up your environment including composer, you may use it to start a new Laravel project.

Open the terminal and run:

```
cd ~/Sites
composer create-project laravel/laravel my-app
```

This will create a new Laravel project called `my-app` inside the `~/Sites` folder. More more information and methods of creating a new Laravel project refer to [official documentation](https://laravel.com/docs/8.x/installation#installation-via-composer).

Then move into your new Laravel project folder:

```
cd my-app
```

There are two methods you can run your Laravel project for development.

- Using a web server such as Apache, Nginx
- Using built in server of PHP

To take a quick look of your new project, serve it using the built in web server of PHP.

Run

```
php artisan serve
```

Now when you visit `http://localhost:8000` using your browser, it should show the landing page of your new Laravel project.

This method should be good enough for development. However if you have multiple Laravel projects, running this command in multiple terminals will incrementally assign port numbers such as `8000`, `8001`, `8002` and so on.

## Configure Laravel Project

All of the configuration files for the Laravel framework are stored in the `config` directory. Each option is documented, so feel free to look through the files and get familiar with the options available to you.

Laravel needs almost no additional configuration out of the box. You are free to get started developing! However, you may wish to review the `config/app.php` file and its documentation. It contains several options such as `timezone` and `locale` that you may wish to change according to your application.

### Environment Based Configuration

Since many of Laravel's configuration option values may vary depending on whether your application is running on your local computer or on a production web server, many important configuration values are defined using the `.env` file that exists at the root of your application.

Read the [configuration guide of Laravel](https://laravel.com/docs/8.x/configuration) to understand the options available for configuring and information related to them.

### Configure Database

Laravel natively supports following database management systems.

- MySQL/MariaDB
- PostgreSQL
- SQLite
- SQL Server

For this tutorial, we will be using MySQL/MariaDB.

Login to `mysql` client using the terminal. Use the `root` account or the database user you created while setting up MariaDB.

```
mysql -u root -p
```

Enter the password when prompted.

Create a new database:

```
CREATE DATABASE myapp;
```

Open the `.env` file and look for:

```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=
```

Change the values for `DB_DATABASE`, `DB_USERNAME` and `DB_PASSWORD` with the details related to your database, database username and password.

Save the file. This will enable your Laravel application to work with your database.

Read [Database: Getting Started](https://laravel.com/docs/8.x/database) guide on Laravel official documentation for more details on working with database.
