Laravel & Oxygen CLI
====================

The Laravel framework comes with the `artisan` Command Line Interface (CLI). `artisan` provides a fluent interface to the Laravel project. The Oxygen extends the functionality of the `artisan` by adding a number of commands. This guide discusses the `artisan` commands provided by Oxygen.

## Available Commands

Use following command to list the available commands in the `artisan`:

```sh
php artisan list
```

This shows the entire list of commands available in `artisan`. On an **Oxygen** project, it also lists the commands added by **Oxygen**.

```
Laravel Framework 8.42.1

Usage:
  command [options] [arguments]

Options:
  -h, --help            Display help for the given command. When no command is given display help for the list command
  -q, --quiet           Do not output any message
  -V, --version         Display this application version
      --ansi            Force ANSI output
      --no-ansi         Disable ANSI output
  -n, --no-interaction  Do not ask any interactive question
      --env[=ENV]       The environment the command should run under
  -v|vv|vvv, --verbose  Increase the verbosity of messages: 1 for normal output, 2 for more verbose output and 3 for debug

Available commands:
  clear-compiled                 Remove the compiled class file
  db                             Start a new database CLI session
  down                           Put the application into maintenance / demo mode
  dusk                           Run the Dusk tests for the application
  env                            Display the current framework environment
  help                           Display help for a command
  inspire                        Display an inspiring quote
  list                           List commands
  migrate                        Run the database migrations
  optimize                       Cache the framework bootstrap files
  serve                          Serve the application on the PHP development server
  test                           Run the application tests
  tinker                         Interact with your application
  up                             Bring the application out of maintenance mode
 auth
  auth:clear-resets              Flush expired password reset tokens
 bouncer
  bouncer:clean                  Delete abilities that are no longer in use
 cache
  cache:clear                    Flush the application cache
  cache:forget                   Remove an item from the cache
  cache:table                    Create a migration for the cache database table
 config
  config:cache                   Create a cache file for faster configuration loading
  config:clear                   Remove the configuration cache file
 db
  db:refresh                     Wipe all tables, migrate and seed all data
  db:seed                        Seed the database with records
  db:wipe                        Drop all tables, views, and types
 debugbar
  debugbar:clear                 Clear the Debugbar Storage
 dusk
  dusk:chrome-driver             Install the ChromeDriver binary
  dusk:component                 Create a new Dusk component class
  dusk:fails                     Run the failing Dusk tests from the last run and stop on failure
  dusk:install                   Install Dusk into the application
  dusk:make                      Create a new Dusk test class
  dusk:page                      Create a new Dusk page class
  dusk:purge                     Purge dusk test debugging files
 event
  event:cache                    Discover and cache the application's events and listeners
  event:clear                    Clear all cached events and listeners
  event:generate                 Generate the missing events and listeners based on registration
  event:list                     List the application's events and listeners
 generate
  generate:api-tests             Generate API Tests
  generate:docs                  Generate API Documentation
  generate:docs-tests            Generate API Documentation, API Tests, Run Tests
 key
  key:generate                   Set the application key
 make
  make:cast                      Create a new custom Eloquent cast class
  make:channel                   Create a new channel class
  make:command                   Create a new Artisan command
  make:component                 Create a new view component class
  make:controller                Create a new controller class
  make:event                     Create a new event class
  make:exception                 Create a new custom exception class
  make:factory                   Create a new model factory
  make:job                       Create a new job class
  make:listener                  Create a new event listener class
  make:mail                      Create a new email class
  make:middleware                Create a new middleware class
  make:migration                 Create a new migration file
  make:model                     Create a new Eloquent model class
  make:notification              Create a new notification class
  make:observer                  Create a new observer class
  make:oxygen:admin-controller   Scaffold an oxygen admin controller
  make:oxygen:api-controller     Scaffold an oxygen API controller
  make:oxygen:model              Scaffold an oxygen model
  make:oxygen:repository         Scaffold an oxygen repository
  make:policy                    Create a new policy class
  make:provider                  Create a new service provider class
  make:repository                Create a new repository class
  make:request                   Create a new form request class
  make:resource                  Create a new resource
  make:rule                      Create a new validation rule
  make:seeder                    Create a new seeder class
  make:test                      Create a new test class
 migrate
  migrate:fresh                  Drop all tables and re-run all migrations
  migrate:install                Create the migration repository
  migrate:refresh                Reset and re-run all migrations
  migrate:reset                  Rollback all database migrations
  migrate:rollback               Rollback the last database migration
  migrate:status                 Show the status of each migration
 notifications
  notifications:table            Create a migration for the notifications table
 optimize
  optimize:clear                 Remove the cached bootstrap files
 oxygen
  oxygen:app-settings:install    Setup the App Settings Extension
  oxygen:dashboard:install       Run Oxygen Admin Installer
  oxygen:devices:install         Setup the Devices Extension
  oxygen:foundation:install      Run Oxygen Foundation Installer
  oxygen:foundation:move-public  Move public folder to another folder
  oxygen:seed                    Seed the database with records
 package
  package:discover               Rebuild the cached package manifest
 queue
  queue:batches-table            Create a migration for the batches database table
  queue:clear                    Delete all of the jobs from the specified queue
  queue:failed                   List all of the failed queue jobs
  queue:failed-table             Create a migration for the failed queue jobs database table
  queue:flush                    Flush all of the failed queue jobs
  queue:forget                   Delete a failed queue job
  queue:listen                   Listen to a given queue
  queue:prune-batches            Prune stale entries from the batches database
  queue:restart                  Restart queue worker daemons after their current job
  queue:retry                    Retry a failed queue job
  queue:retry-batch              Retry the failed jobs for a batch
  queue:table                    Create a migration for the queue jobs database table
  queue:work                     Start processing jobs on the queue as a daemon
 route
  route:cache                    Create a route cache file for faster route registration
  route:clear                    Remove the route cache file
  route:list                     List all registered routes
 sail
  sail:install                   Install Laravel Sail's default Docker Compose file
  sail:publish                   Publish the Laravel Sail Docker files
 scaffold
  scaffold:views                 Scaffold the default views for a resource
 schedule
  schedule:list                  List the scheduled commands
  schedule:run                   Run the scheduled commands
  schedule:test                  Run a scheduled command
  schedule:work                  Start the schedule worker
 schema
  schema:dump                    Dump the given database schema
 scout
  scout:flush                    Flush all of the model's records from the index
  scout:import                   Import the given model into the search index
 session
  session:table                  Create a migration for the session database table
 setup
  setup:create-user              Create a new user for Oxygen backend
 storage
  storage:link                   Create the symbolic links configured for the application
 stub
  stub:publish                   Publish all stubs that are available for customization
 vendor
  vendor:publish                 Publish any publishable assets from vendor packages
 view
  view:cache                     Compile all of the application's Blade templates
  view:clear                     Clear all compiled view files
```

In order to get more information on a particular command, use:

```sh
php artisan help COMMAND_NAME
```

Replace `COMMAND_NAME` with any `artisan` command you see on the list to get details.

```sh
php artisan help view:clear
```

The output:

```sh
Description:
  Clear all compiled view files

Usage:
  view:clear

Options:
  -h, --help            Display help for the given command. When no command is given display help for the list command
  -q, --quiet           Do not output any message
  -V, --version         Display this application version
      --ansi            Force ANSI output
      --no-ansi         Disable ANSI output
  -n, --no-interaction  Do not ask any interactive question
      --env[=ENV]       The environment the command should run under
  -v|vv|vvv, --verbose  Increase the verbosity of messages: 1 for normal output, 2 for more verbose output and 3 for debug
```

We wont discuss all commands in the list. But, we will discuss a few that are most important while development.


##  Generating Code

Laravel comes with many commands to generate common classes such as models, controllers, middleware etc.

### Generate Models

You may use the following command to create a new model:

```sh
php artisan make:model Product
```

This creates `Product.php` file with `Product` model class in `app/Models` folder. You may pass `-m` option to this command to generate the respective migration file with it.

```sh
php artisan make:model Product -m
```

Also, the `make:model` command supports following options to generate additional files in one go.

```
-a, --all             Generate a migration, seeder, factory, and resource controller for the model
-c, --controller      Create a new controller for the model
-f, --factory         Create a new factory for the model
    --force           Create the class even if the model already exists
-m, --migration       Create a new migration file for the model
-s, --seed            Create a new seeder file for the model
-p, --pivot           Indicates if the generated model should be a custom intermediate table model
-r, --resource        Indicates if the generated controller should be a resource controller
    --api             Indicates if the generated controller should be an API controller
```

**Exercise**: Try each of the above options with `make:model` command to understand their behaviour.

Since this is one of the default artisan command, it uses the Laravel default standard to generate the code. If you are working with an **Oxygen** project, you need to use following command instead to generate an **Oxygen** compatible model:

```sh
php artisan make:oxygen:model Product
```

This creates `Product.php` file inside `app/Entities/Products` folder. In case the `Entities` and `Products` folders do not exist, it creates them first. The **Oxygen** standard of managing models is placing them inside a folder with the plural name of the model inside `app/Entities` folder.

Also, the `make:oxygen:model` command does not support the options mentioned above for generating additional files.

> If you use the `app/Models` for placing your **Model** classes, `emedia/api` package would not add them to the model definitions list of `swagger.json` while generating API documents.


### Genrate Repositories

**Oxygen** uses the repository pattern. Hence, generating the **reposiltories**. Use following command to generate a new repository:

```sh
php artisan make:oxygen:repository Product
```

This creates `ProductRepository.php` inside the `app/Entities/Products` folder. Note that we mention only the name of the model to create the respective repository. Both the `Product` model and `ProductRepository` are created inside the same folder.


### Generate Controllers

Laravel `artisan` comes with the `make:controller` command to generate controllers.

```sh
php artisan make:controller ProductController
```

This creates `ProductController.php` file inside the `app/Http/Controllers` folder. The same command can be used to generate a [resource controller](https://laravel.com/docs/8.x/controllers#resource-controllers) using `-r` or `--resource` option.


```sh
php artisan make:controller ProductController -r
```

This adds the methods related to the CRUD of a model to the controller. `index`, `create`, `store`, `edit`, `update`, `destroy`.


**Oxygen Admin Controllers**

**Oxygen** projects have two main components, the `admin` and `api`. Due to this reason, it provides two commands for generating controllers. To create an **admin controller**, run:

```sh
php artisan make:oxygen:admin-controller Product
```

It creates `ProductsController.php` file inside the `app/Http/Controllers/Manage` folder. Note that we provided the model name to the command as an argument. **Oxygen** takes the model name and generates a boilerplate resource controller for the **Product** model.

If you open `ProductsController.php` file, you can see that it uses a trait called `FollowsConventions` to add all the code required to manage the **Product** entity inside the **Oxygen** admin panel. Please go through [the code of](https://github.com/elegantmedia/Oxygen-Foundation/blob/master/src/Http/Traits/Web/FollowsConventions.php) `FollowsConventions` trait to understand how it works.


**Oxygen API Controllers**

To generate an **Oxygen** API controller for the **Product** model, run:

```sh
php artisan make:oxygen:api-controller Product
```

It creates `ProductsAPIController.php` file inside the `app/Http/Controllers/API/V1` folder. Similar to **admin** controller, it generates a controller to manage **Product** model. However, it only adds the `index` function, which returns a list of products. Please refer to [API development Guide](../training/api/api-development-guide.md) to learn more about API development using **Oxygen**.


## Generate Database Migrations

It i a good practice to use database migrations for database schema changes. We discussed generating respective database migration along with the model above in **Generate Models** section. For other schema changes, use following `artisan` command to generate the migration:

```sh
php artisan make:migration add_status_column_to_products_table
```

This will generate a new migration file inside `database/migrations` folder. You need to add the migration code to the file after it is generated. The `make:migration` command picks the related table name from the migration name you provide. In this case, it identifies the table name as `products` as the migration name ends with `products_table`.

In case your migration name is not ending with the table name, you can use `--table=TABLE_NAME` to mention the table that the migration applies. Use `--create=TABLE_NAME` option when your migration suppose to create a new table.

Use `php artisan help make:migration` command to get more details on the `make:migration` command.

Use following commands to manage migrations:

Apply all pending migrations:

```sh
php artisan migrate
```

Rollback last applied batch of migrations:

```sh
php artisan migrate:rollback
```

Also, you can use the `--step` option to limit the number of migrations to rollback. For example, to rollback 3 migrations starting from the last one:

```sh
php artisan migrate:rollback --step=3
```

Drop all tables and re-run all migrations:

```sh
php artisan migrate:fresh
```

Reset and re-run all migrations. This does not drop tables first. It rollbacks all migrations before running them again.

```sh
php artisan migrate:refresh
```

To rollback all migrations:

```sh
php artisan migrate:reset
```

To check the current migration status:

```sh
php artisan migrate:status
```

Read more about [Database Migrations](https://laravel.com/docs/8.x/migrations#introduction) on Laravel documentation.


## Generate Database Seeders


Database seeding is useful when you want to fill the tables with dummy data for testing or demonstration purposes. Also they can be useful to populate the database with the default data. For example, if your project utilizes a list of countries, currencies or any other data required for proper functioning, you should use database seeders to seed them.

To create a seeder, run:

```sh
php artisan make:seeder ProductTableSeeder
```

This creates `ProductTableSeeder.php` file inside the `database/seeders` folder. Add code required to insert the data to the `run()` method in this file. Read [Database Seeding](*https://laravel.com/docs/8.x/seeding) guide for more details on seeding database.

Also, you can generate the seeder for a model while you are generating it with the `make:model` command. Use `-s` or `--seed` options to do so. However, these options do not work with the `make:oxygen:model` command.


## Database Migration and Seeding in Oxygen

**Oxygen** comes with a command to reset the database, run all migrations and seed the database in on go. To run it:

```sh
php artisan db:refresh
```

Use the following command to seed the **Oxygen** default data:

```sh
php artisan oxygen:seed
```

## Customize Stubs

The `artisan` commands use **stub** file when generating code. For example, to generate a controller it uses the content of a file called `controller.stub` and replaces some placeholders with values. Take a look at the code of `controller.stub`:

```php
namespace {{ namespace }};

use {{ rootNamespace }}Http\Controllers\Controller;
use Illuminate\Http\Request;

class {{ class }} extends Controller
{
    //
}
```

When generating a new controller, the `{{ class }}`, `{{ namespace }}`, and `{{ rootNamespace }}` placeholder tests are replaced.

In case you need to customize these stub files, you can add them to your project. To do that, run:

```sh
php artisan stub:publish
```

This will copy all stub files to `stubs` folder in your project. Change them accordingly to match your need.


## Creating Oxygen Users

Oxygen uses a Role Based Access Control (RBAC) system called [Bouncer](https://github.com/JosephSilber/bouncer). Also, it comes with a set of pre-defined roles. You can find these default roles in `database/seeders/Auth/RolesTableSeeder.php` file. 

- users
- admins
- super-admins
- developers
- managers

```
php artisan setup:create-user

 What's the email? [info@elegantmedia.com.au]:
 > saranga@elegantmedia.lk

 What's the first name?:
 > Saranga

 Enter a password for this user:
 > 12345678

 Enter the password again to confirm:
 > 12345678

 Add this user to a role? (yes/no) [no]:
 > yes

users
admins
super-admins
developers
managers

 What's the slug of the role to attach?:
 > admins

Role attached.
```

## Routing

You can list the routes available in the application using:

```sh
php artisan route:list
```

And, output would be similar to:

```
+--------+-----------+--------------------------------+------------------+-------------------------------------------------------------+------------------------------------------+
| Domain | Method    | URI                            | Name             | Action                                                      | Middleware                               |
+--------+-----------+--------------------------------+------------------+-------------------------------------------------------------+------------------------------------------+
|        | GET|HEAD  | /                              |                  | Closure                                                     | web                                      |
|        | POST      | api/v1/auth/login              |                  | App\Http\Controllers\API\V1\AuthController@login            | api                                      |
|        | GET|HEAD  | api/v1/auth/refresh            |                  | App\Http\Controllers\API\V1\AuthController@user             | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | POST      | api/v1/auth/register           |                  | App\Http\Controllers\API\V1\AuthController@register         | api                                      |
|        | GET|HEAD  | api/v1/auth/user               |                  | App\Http\Controllers\API\V1\AuthController@user             | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | GET|HEAD  | api/v1/comments/create         | comments.create  | App\Http\Controllers\API\V1\CommentsController@create       | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | DELETE    | api/v1/comments/{comment}      | comments.destroy | App\Http\Controllers\API\V1\CommentsController@destroy      | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | PUT|PATCH | api/v1/comments/{comment}      | comments.update  | App\Http\Controllers\API\V1\CommentsController@update       | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | GET|HEAD  | api/v1/comments/{comment}      | comments.show    | App\Http\Controllers\API\V1\CommentsController@show         | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | GET|HEAD  | api/v1/comments/{comment}/edit | comments.edit    | App\Http\Controllers\API\V1\CommentsController@edit         | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | GET|HEAD  | api/v1/posts                   | posts.index      | App\Http\Controllers\API\V1\PostsController@index           | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | POST      | api/v1/posts                   | posts.store      | App\Http\Controllers\API\V1\PostsController@store           | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | GET|HEAD  | api/v1/posts/create            | posts.create     | App\Http\Controllers\API\V1\PostsController@create          | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | PUT|PATCH | api/v1/posts/{post}            | posts.update     | App\Http\Controllers\API\V1\PostsController@update          | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | DELETE    | api/v1/posts/{post}            | posts.destroy    | App\Http\Controllers\API\V1\PostsController@destroy         | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | GET|HEAD  | api/v1/posts/{post}            | posts.show       | App\Http\Controllers\API\V1\PostsController@show            | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | POST      | api/v1/posts/{post}/comments   | comments.store   | App\Http\Controllers\API\V1\CommentsController@store        | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | GET|HEAD  | api/v1/posts/{post}/comments   | posts.comments   | App\Http\Controllers\API\V1\CommentsController@postComments | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | GET|HEAD  | api/v1/posts/{post}/edit       | posts.edit       | App\Http\Controllers\API\V1\PostsController@edit            | api                                      |
|        |           |                                |                  |                                                             | App\Http\Middleware\Authenticate:sanctum |
|        | GET|HEAD  | sanctum/csrf-cookie            |                  | Laravel\Sanctum\Http\Controllers\CsrfCookieController@show  | web                                      |
+--------+-----------+--------------------------------+------------------+-------------------------------------------------------------+------------------------------------------+
```

Try following options for `route:list` command and get yourself familiar with them.

```
--columns[=COLUMNS]          Columns to include in the route table (multiple values allowed)
-c, --compact                Only show method, URI and action columns
--json                       Output the route list as JSON
--method[=METHOD]            Filter the routes by method
--name[=NAME]                Filter the routes by name
--path[=PATH]                Only show routes matching the given path pattern
--except-path[=EXCEPT-PATH]  Do not display the routes matching the given path pattern
-r, --reverse                Reverse the ordering of the routes
--sort[=SORT]                The column (domain, method, uri, name, action, middleware) to sort by [default: "uri"]
```

For example, only the `POST` routes in compact mode:

```sh
php artisan route:list --method=POST -c
```

Output:

```
+--------+------------------------------+------------------------------------------------------+
| Method | URI                          | Action                                               |
+--------+------------------------------+------------------------------------------------------+
| POST   | api/v1/auth/login            | App\Http\Controllers\API\V1\AuthController@login     |
| POST   | api/v1/auth/register         | App\Http\Controllers\API\V1\AuthController@register  |
| POST   | api/v1/posts                 | App\Http\Controllers\API\V1\PostsController@store    |
| POST   | api/v1/posts/{post}/comments | App\Http\Controllers\API\V1\CommentsController@store |
+--------+------------------------------+------------------------------------------------------+
```

Also when you deploy the project to production, caching the routes would make it faster to load them. To create the route cache file, run:

```sh
php artisan route:cache
```

You can clear the route cache with:

```sh
php artisan route:clear
```

## Working with Cache

Laravel uses cache to speed up the application execution at production. Following commands help you to cache and clear cache on different items in your application.

```
clear-compiled                 Remove the compiled class file
auth:clear-resets              Flush expired password reset tokens

cache
cache:clear                    Flush the application cache

config
config:cache                   Create a cache file for faster configuration loading
config:clear                   Remove the configuration cache file

event
event:cache                    Discover and cache the application's events and listeners
event:clear                    Clear all cached events and listeners

route
route:cache                    Create a route cache file for faster route registration
route:clear                    Remove the route cache file

view
view:cache                     Compile all of the application's Blade templates
view:clear                     Clear all compiled view files
```

## Creating and Running Tests

Laravel uses phpunit based tests. You can generate a test using:

```sh
php artisan make:test TicketTest
```

This creates `TicketTest.php` file inside the `tests/Feature` folder.

To run the tests you can use either:

```sh
php artisan test
```
 Or,

 ```sh
 ./vendor/bin/phpunit
 ```

These commands will run all tests in the test suite. To run a single test, use:

```sh
php artisan test ./tests/Feature/TicketTest.php
```

Or,

```sh
./vendor/bin/phpunit ./tests/Feature/TicketTest.php
```

The `php artisan test` command is running tests sequentially (one after other). You can use `-p` or `--parallel` options in order to run tests parallelly.

Read [Test Driven Development With Laravel](https://bitbucket.org/elegantmedia/em-knowledge-base/src/master/web/laravel/test-driven-development-with-laravel.md) to understand the testing more.
