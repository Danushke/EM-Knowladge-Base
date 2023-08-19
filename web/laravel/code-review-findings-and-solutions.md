# Code Review Findings And Solutions

The content of this document is a list of issues found within the code of the
developers during the code reviews sessions. It is recommended for all
developers to go through them and make sure not to repeat them in own code.

---
## Issue
Using arbitrary code formatting and styling methods or no formatting and styling
method used.

## Solution
Stick to [PSR-2](https://www.php-fig.org/psr/psr-2/) coding style. This is the
same coding style Laravel suggest using in their [contribution guide](https://laravel.com/docs/7.x/contributions#coding-style).
Also use `camelCase` starting with a lower case letter for variable and method
names. Use `CamelCase` starting with a upper case letter for class names.

---
## Issue
Not using the internal packages (company developed private packages) for common
tasks.

## Solution
Reason for this is developers are not spending enough time to understand the
internally developed packages and available functions in them. It is highly
recommended for developers to study the internal packages and understand before
the development. Read the `readme.md` files of the respective packages. Also
group communication channels (backend group chat) can be used to discuss or
find out if some functionality is already available in the existing packages.

---
## Issue
Missing or incorrect database migrations and database seeds.

## Solution
All database schema changes MUST be managed using the database migrations. No
Schema change should be done manually or left without adding to the migrations.
Do not change old migration files to add new changes. Create a new migration
file for new changes. `up` and `down` functions should be completed to apply and
rollback the change.

If the application needs some default data (default user accounts, app settings,
default categories, etc..) after a fresh installation, they should be added as
DB seeds. Use following code inside `DatabaseSeeder` to make sure test data
seeds (test users, test content) are not executed while doing the production
deployment.

```php
// Add development, testing, staging seeders here.
if (!app()->environment('production')) {
    $this->call(UsersTableSeeder::class);
    $this->call(UserRolesTableSeeder::class);
}
```

---
## Issue
Using `empty()` on collections.
```php
$posts = Post::where('type', 'news')->get();

if (!empty($posts)) {
  // do something on posts
}
```
Here `empty($posts)` always resolved to be `false`, though the expectation is it
to be `true` when the collection is empty.

## Solution
No matter if the results set has any items, since `$posts` variable is assigned
a a Collection object suing `empty()` function on this will result `false`. To
avoid this use the `isEmpty()` or `isNotEmpty()` function of the
`Illuminate\Support\Collection` object.

```php
$posts = Post::where('type', 'news')->get();

if ($posts->isNotEmpty()) {
  // do something on posts
}
```

---
## Issue
Using string and number values for entity statuses where constants should be used.

**Example 1:**
Using string value `"news"` as a post type:
```php
$post = Post::create([
    'name' => $request->name,
    'content' => $request->content,
    'type' => 'news'
]);
```

**Example 2:**
Using integer value `1` as article status:
```php
$article = Article::create([
    'title' => $request->title,
    'content' => $request->content,
    'status' => 1
]);
```
In above cases a second developer can easily be confused of the valid values for
the `type` and `status` fields. Also in case of a requirement to change the
value to something else can be troublesome when the value is repeated at
multiple places in the code.

## Solution
Declare valid set of values for those fields as constants in the model and use
then throughout the code. Read article: [Use of constant values for attribute options](best-practices/use-of-constant-values-for-attribute-options.md)

---
## Issue
Not checking for existence of the object before using attribute values.

**Example 1**
Consider a `post` entity which has a relationship called `author` with the user
entity. In controller:
```php
$post = Post::find(2);
```
In view:
```php
Author: {{ $post->author->name }}
```
Intention here is to display the name of the author assuming that author
relationship has successfully loaded the user object. This fails of the relationship
is not loaded.

**Example 2**
```php
$product = Product::find(2);

// Does things with post attributes and relationships
$total = $product->price + $tax;
```
If the product with the id `2` is not available in the database, subsequent
access to properties of `$product` fails. This can be working when testing as
developer mostly tests with the already existing data. But fails in the case if
some product is deleted from database.

## Solution
Use `findOrFail()` or similar methods for loading entities.
```
$product = Product::findOrFail(2);
```
Check for the existence of the related object before using it's attributes.
```php
Author: {{ isset($post->author->name) ? $post->author->name : 'Not Mentioned' }}
```
Or
```php
@if(isset($post->author))
  Author: {{ $post->author->name }}
@endif
```
This applies to every case where an attribute value is accessed of an object
which is not sure the values are loaded. Similarly applies to array indexes.
```php
@if(!empty($settings['facebook_link']))
<a href="{{ $settings['facebook_link'] }}">Facebook</a>
@endif
```

---
## Issue
Using unnecessary database queries. Specially when checking for existence of
some item in DB and retrieving it.

**Example 1**
```php
if (Post::where('published', true)->exists()) {
  $posts = Post::where('published', true)->get();
  // Does things with $posts
}
```

**Example 2**
```php
$post = Post::find($request->id);

if (Post::where('published', true)->exists()) {
  $posts = Post::where('published', true)->get();
  // Does things with $posts
}
```

## Solution

---
## Issue
Less structured, ambiguous or misleading naming of routes and API endpoints.

## Solution
Format the routes and API endpoints as described in this guide.
[Routing & URLs](routing-and-urls.md)
