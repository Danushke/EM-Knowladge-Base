# Routing & URLs

## Resource Collections Based URLs

### Resource collections

All entities in application should be accessed with respect to a collection of that entity. A collection is represented by the plural form of the name of the entity.
For example consider the following examples for `User` entity. Here, `ROUTE` is the line should be used in `/routes/web.php` or `/routes/api.php` file. `METHOD` is the HTTP method to be used for particular type of requests. `URL` is the format of the URL that should be used for accessing respective page or API endpoint. Controller should use the singular format of the entity name (`UserController`).

**Path for displaying the list of users**

```
URL: https://www.example.com/users
METHOD: get
ROUTE: Route::get('users', 'UserController@index')->name('users.index')
```

* Always use `index` method for displaying the full list of entity
* Use `query` parameters for searching, sorting and pagination
  * `q` - search keywords
  * `page` - number of the page
  * `per_page` - number of items per page
  * `sort_by` - column to sort by
  * `sort_dir` - sort direction ASC/DESC


**Path for displaying the form for creating a new user**

```
URL: https://www.example.com/users/create
METHOD: get
ROUTE: Route::get('users/create', 'UserController@create')->name('users.create')
```

* If some fields should be pre-populated, pass them as [query parameters](https://en.wikipedia.org/wiki/Query_string)

**Path for saving a new user**

```
URL: https://www.example.com/users
METHOD: post
ROUTE: Route::post('users', 'UserController@store')->name('users.store')
```

**Path for displaying the details of user with ID 23**

```
URL: https://www.example.com/users/23
METHOD: get
ROUTE: Route::get('users/{user}', 'UserController@show')->name('users.show')
```

* Use [implicit binding](https://laravel.com/docs/5.8/routing#implicit-binding) for automatically passing an instance of model to the method (note `{user}` in above route syntax)

**Path for displaying the form for editing user with ID 23**

```
URL: https://www.example.com/users/23/edit
METHOD: get
ROUTE: Route::get('users/{user}/edit', 'UserController@edit')->name('users.edit')
```

**Path for updating the user with ID 23**

```
URL: https://www.example.com/users/23
METHOD: put
ROUTE: Route::put('users/{user}', 'UserController@update')->name('users.update')
```

* When updated using an HTML form, use [method spoofing](https://laravel.com/docs/5.8/routing#form-method-spoofing)

**Path for deleting the user with ID 23**

```
URL: https://www.example.com/users/23
METHOD: delete
ROUTE: Route::delete('users/{user}', 'UserController@destroy')->name('users.update')
```

* When deleted using an HTML form, use [method spoofing](https://laravel.com/docs/5.8/routing#form-method-spoofing)


### Sub entities

Some entities could have sub-entities which might not be meaningful when accessed alone. In such cases, path of the main entity should be extended to access these sub-entities.

For example, a user might have multiple contact emails. These emails have no meaning when accessed alone. They can be treated as sub-entities and accessed through an extension to the path of user entity.

**Displaying the list of email of user with ID 23**

```
URL: https://www.example.com/users/23/emails
METHOD: get
ROUTE: Route::get('users/{user}/emails', 'EmailController@index')->name('users.emails.index')
```

* Use [implicit binding](https://laravel.com/docs/5.8/routing#implicit-binding) for automatically passing an instance of model to the method (note `{user}` in above route syntax)

**Adding a new email to email list of user with ID 23**

```
URL: https://www.example.com/users/23/emails/5
METHOD: post
ROUTE: Route::post('users/{user}/emails', 'EmailController@store')->name('users.emails.store')
```

**Displaying email with ID 5 of user with ID 23**

```
URL: https://www.example.com/users/23/emails/5
METHOD: get
ROUTE: Route::get('users/{user}/emails/{email}', 'EmailController@show')->name('users.emails.show')
```

**Deleting email with ID 5 of user with ID 23**

```
URL: https://www.example.com/users/23/emails/5
METHOD: delete
ROUTE: Route::delete('users/{user}/emails/{email}', 'EmailController@destroy')->name('users.emails.destroy')
```

### Naming and Using Routes

Sometimes, We need to use routes in blade file for `links`, `form urls` and `etc`. In that case, we may 
write routes directly.

```
<form action="/auth/login">
    ....
</form>
```

But **DO NOT** follow above way to use your routes. Because, If you change the route for any reason, you will need to 
search for all usages and need to replace it with changes.

So, Instead of writing absolute URLs, You can name your routes and use anywhere. So you don't need to change URLs everywhere,
 Even if you change your routes.

**Naming a route**
```PHP
<?php

// here the auth.login will be the name of your route
Route::post('/auth/login', 'AuthController@login')->name('auth.login');

// here the user.info will be the name of your route
Route::post('/user/{id}', 'UserController@view')->name('user.info');
```

**Using routes with names**
```html
<form action="{{ route('auth.login') }}">
    ....
</form>
```

```html
<!-- passing route parameter -->
<a href="{{ route('user.info', [ 'id' => 2 ]) }}">user 2</a>
```

