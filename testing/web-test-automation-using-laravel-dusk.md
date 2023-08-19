# Web Test Automation Using Laravel Dusk

[Laravel Dusk](https://github.com/laravel/dusk) is a feature rich tool created for supporting browser testing on Laravel projects.

It is recommended to read the official documentation of Laravel Dusk to get a proper understanding of how does it work and how to use it.

## What to test?

Laravel Dusk is used for browser testing. Basically this means anything you could test by manually opening a browser and visiting a web application should be able to be tested with Dusk.

**Test page has all required components**

Create a [page](https://laravel.com/docs/6.x/dusk#pages) for every view in the application. For example, there could be a `Services` page for the view accessed by the path `/services`.

```php
namespace Tests\Browser\Pages;

use Laravel\Dusk\Browser;

class Services extends \Tests\Browser\Pages\Page
{
    /**
     * Get the URL for the page.
     *
     * @return string
     */
    public function url()
    {
        return '/services';
    }

    /**
     * Assert that the browser is on the page.
     *
     * @param  Browser  $browser
     * @return void
     */
    public function assert(Browser $browser)
    {
        $browser->assertPathIs($this->url())
            ->assertSee('Services')
            ->assertSee('Add New')
            ->assertVisible('@add-new')
            ->assertVisible('@search-input')
            ->assertVisible('@search-submit');
    }

    /**
     * Get the element shortcuts for the page.
     *
     * @return array
     */
    public function elements()
    {
        return [
            '@add-new' => '.page-main-actions form a.btn.btn-success',
            '@search-input' => '.page-main-actions form input[name="q"]',
            '@search-submit' => '.page-main-actions form button[type="submit"]',
            '@name' => 'input[name="name"]',
            '@logo' => 'input[name="logo_path"]',
            '@submit' => 'button[type="submit"]',
        ];
    }
}
```

Use `assert()` method to verify all important components are available on the page. Try to include as many components as possible in this assertion list. You might need to check them for availability as well as visibility. Do not include the content generated as a result of a user interaction in `assert()` function of the page class. For example validation message generated as a result of a form submission should not be included in this method.

Use `elements()` method to list down all elements that user will interact within the page.

Do not include shared components in every page. Shared sidebar, top navigation bar and footer are such components. Dusk has a separate workaround for [components](https://laravel.com/docs/6.x/dusk#components).

**Test if the path is correct after every page load**

Browser might be reloaded or redirected as a result of a user action. If this is expected while test is running, always make sure to check for the resulting URL. `assertPathIs()` function can be used for this.

```php
public function testViewCategories()
{
    $this->browse(function (Browser $browser) {
        $service = factory(Service::class)->create();

        $browser->loginAs(User::find(2))
            ->visit(new Services())
            ->clickLink('View Categories')
            ->assertPathIs('/services/categories/' . $service->id)
            ->assertSee('Categories')
            ->assertSee('Category Name')
            ->assertSee('Logo')
            ->assertSeeLink('Add New')
            ->assertSeeIn('.breadcrumb', $service->name);
    });
}
```

**Test for every interaction and use case**

One feature might include multiple user interactions and flows. For example Login Feature might need to be tested for following use cases.

* Availability and visibility of form input fields.
* Login with empty email and password fields
* Login with invalid email address (no @ sign, etc)
* Login with invalid password (character length, etc)
* Login with incorrect email and password
* Login with correct email and incorrect password
* Login with correct email and password


## Testing an Oxygen project

[Oxygen](https://bitbucket.org/elegantmedia/oxygen-laravel) comes with a default set of test cases to make is easier to start testing. These test cases can be found inside the `tests/Browser` folder after Oxygen set up is completed.

### Set up

Install and setup [Oxygen](https://bitbucket.org/elegantmedia/oxygen-laravel) following the instructions on `README.MD`.

[Install Dusk](https://laravel.com/docs/6.x/dusk#installation) as instructed in Laravel documentation.

Run tests using:

```
php artisan dusk
```
