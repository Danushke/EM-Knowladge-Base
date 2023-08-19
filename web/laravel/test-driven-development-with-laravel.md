Test Driven Development With Laravel
====================================

This is a guide to Test Driven Development (TDD) using Laravel. It shows how to start the development of an online support system with TDD. The development of the **Online Support System** from the beginning is explained in following guides.

- [Building A Support System - Part 1](./building-a-support-system-1.md)
- [Building A Support System - Part 2](./building-a-support-system-2.md)
- [Building A Support System - Part 3](./building-a-support-system-3.md)

## Test Driven Development

[Test Driven Development](https://en.wikipedia.org/wiki/Test-driven_development) is the programming practice that code is developed to satisfy the pre-written test cases. That means the test cases are written first to cover a certain feature. They are failing at the first run as the feature is not developed yet. Later on, the code is written to make sure the tests pass. The tests specify the requirement of the applications as well as verifies it.

TDD has 5 main steps:

![TDD Steps](https://raw.githubusercontent.com/nazmulb/cucumber/master/images/tdd.png)

1. **Add** a test
2. Run the tests. The new test should **fail**
3. **Write** the simplest code that passes the new test
4. Run the tests again. All tests should **pass**
5. **Refactor** and ensure all tests pass

This process is repeated for every new feature introduced to the system.

Let's see some TDD in action.


## Getting Started

Let's pick one feature as out starting point. Look at the following requirement:

> **Requirement**: When users need support on an issue, they visit the online support system and open a ticket.

Set up a new Laravel project. Before we write any code, let's create a test. Because that's how the TDD starts.

```sh
php artisan make:test TicketsTest
```

This creates `TicketsTest.php` file inside the `tests/Feature` folder. It includes one sample test named `test_example` that sends a request to the root URL `/` and asserts if the HTTP status code of the response is `200`. At the moment it doesn't test anything related to the above feature. But, we can run it and see if the basics are working.

Run your test suite with:

```sh
php artisan test
```

And, it will output something like this:

```
 PASS  Tests\Unit\ExampleTest
✓ example

 PASS  Tests\Feature\ExampleTest
✓ example

 PASS  Tests\Feature\TicketsTest
✓ example

Tests:  3 passed
Time:   0.18s
```

It runs two other tests with the `TicketsTest`. These tests are there by default when you create a new Laravel project. And they all get executed when we run the test suite. The `php artisan test` is using `phpunit` behind the scene. So, you can also run the test suite with:

```sh
./vendor/bin/phpunit
```

In case you don't need to run the entire test suite, but only the test you are focussing on, you may use:

```sh
php artisan test tests/Feature/TicketsTest.php
```

This time, it runs only the `TicketsTest`.

```
PASS  Tests\Feature\TicketsTest
✓ example

Tests:  1 passed
Time:   0.13s
```

### Writing tests

Let's rename the `test_example` method in `TicketsTest` to `test_user_can_create_ticket` and add following code inside the method.

```php
namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class TicketsTest extends TestCase
{
    use WithFaker, RefreshDatabase;

    /**
     * A basic feature test example.
     *
     * @return void
     */
    public function test_user_can_create_ticket()
    {
        $data = [
            'customer_name' => $this->faker->name(),
            'email' => $this->faker->safeEmail(),
            'phone' => $this->faker->phoneNumber(),
            'description' => $this->faker->paragraph(),
        ];

        $response = $this->post('/tickets', $data);

        $this->assertDatabaseHas('tickets', $data);
    }
}
```
We need some test data to fill in the attributes of the ticket. **Faker** makes it easy to generate fake data for testing purposes. Add `WithFaker` trait to the test class to add **Faker** support. Also, I have used `RefreshDatabase` trait to [refresh the database for every test](https://laravel.com/docs/8.x/database-testing#resetting-the-database-after-each-test). This helps run every test with a fresh database. So, each test is not affected by the residuals of the previous tests.

Inside the test, we send a post request to the `/tickets` route with the ticket data. Then we check the database for the newly created **Ticket** entry using its attributes.

Out test has enough code to test the functionality we are focusing on. Let's go ahead and run it:

```sh
php artisan test tests/Feature/TicketsTest.php
```

And, the output is:

```

   FAIL  Tests\Feature\TicketsTest
  ⨯ user can create ticket

  ---

  • Tests\Feature\TicketsTest > user can create ticket
   Illuminate\Database\QueryException

  SQLSTATE[HY000] [1045] Access denied for user 'root'@'localhost' (using password: NO) (SQL: SHOW FULL TABLES WHERE table_type = 'BASE TABLE')

  at vendor/laravel/framework/src/Illuminate/Database/Connection.php:692
    688▕         // If an exception occurs when attempting to run a query, we'll format the error
    689▕         // message to include the bindings with SQL, which will make this exception a
    690▕         // lot more helpful to the developer instead of just the database's errors.
    691▕         catch (Exception $e) {
  ➜ 692▕             throw new QueryException(
    693▕                 $query, $this->prepareBindings($bindings), $e
    694▕             );
    695▕         }
    696▕     }


  Tests:  1 failed
  Time:   0.18s
```

Yes, it gives an error. This is because our project is still new and we have no database configured. To solve it create a new database using your database management tool and configure `.env` with details of it.

```sh
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=support
DB_USERNAME=root
DB_PASSWORD=
```

My database is named `support`. Also, I use the `root` database user to connect my database without a password. Configure yours accordingly.

Then run tests again.

```

   FAIL  Tests\Feature\TicketsTest
  ⨯ user can create ticket

  ---

  • Tests\Feature\TicketsTest > user can create ticket
   Illuminate\Database\QueryException

  SQLSTATE[42S02]: Base table or view not found: 1146 Table 'support-test.tickets' doesn't exist (SQL: select count(*) as aggregate from `tickets` where (`customer_name` = Arch Yundt and `email` = clare.kling@example.net and `phone` = 260-478-4487 and `description` = Eum quia nam vel iure adipisci mollitia ut. Aut voluptatem voluptate iste in rerum. Rerum autem sit nihil iste voluptatibus et fugiat. Occaecati quo voluptates debitis enim repudiandae consequatur.))

  at vendor/laravel/framework/src/Illuminate/Database/Connection.php:692
    688▕         // If an exception occurs when attempting to run a query, we'll format the error
    689▕         // message to include the bindings with SQL, which will make this exception a
    690▕         // lot more helpful to the developer instead of just the database's errors.
    691▕         catch (Exception $e) {
  ➜ 692▕             throw new QueryException(
    693▕                 $query, $this->prepareBindings($bindings), $e
    694▕             );
    695▕         }
    696▕     }

      +11 vendor frames
  12  tests/Feature/TicketsTest.php:30
      Illuminate\Foundation\Testing\TestCase::assertDatabaseHas("tickets", ["Arch Yundt", "clare.kling@example.net", "260-478-4487", "Eum quia nam vel iure adipisci mollitia ut. Aut voluptatem voluptate iste in rerum. Rerum autem sit nihil iste voluptatibus et fugiat. Occaecati quo voluptates debitis enim repudiandae consequatur."])


  Tests:  1 failed
  Time:   0.47s
```

This time it gives a different error. Obviously, we don't have the `titckets` table created yet. Let's go ahead and create the **model** and **database migration** for the tickets.

```sh
php artisan make:model Ticket -m
```

It creates `app/Models/Ticket.php` and the respective migration file at `database/migrations`. Let's open the migration file and add the fields for `tickets` table.

```php
class CreateTicketsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tickets', function (Blueprint $table) {
            $table->id();
            $table->string('customer_name');
            $table->string('email');
            $table->string('phone')->nullable();
            $table->text('description');
            $table->string('ref')->unique();
            $table->tinyInteger('status')->comment('0=new, 1=attended, 2=resolved, 3=cancelled');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tickets');
    }
}
```
Save it and run the test again:

```

   FAIL  Tests\Feature\TicketsTest
  ⨯ user can create ticket

  ---

  • Tests\Feature\TicketsTest > user can create ticket
  Failed asserting that a row in the table [tickets] matches the attributes {
      "customer_name": "Aida O'Hara",
      "email": "dakota15@example.net",
      "phone": "1-650-410-6327",
      "description": "Nobis doloribus quae dignissimos dicta. Quo quia laboriosam nesciunt quos quam enim a quia. Voluptatem repellat quos asperiores laudantium et dolorum. Odio pariatur explicabo doloremque rerum labore et est."
  }.

  The table is empty..

  at tests/Feature/TicketsTest.php:30
     26▕             'description' => $this->faker->paragraph(),
     27▕         ];
     28▕
     29▕         $response = $this->post('/tickets', $data);
  ➜  30▕         $this->assertDatabaseHas('tickets', $data);
     31▕         // $response->assertSeeText($data['customer_name']);
     32▕     }
     33▕ }
     34▕


  Tests:  1 failed
  Time:   0.52s
```

This time we get another error message. The important thing to notice here is, you didn't have to run the migration you created. The `RefreshDatabase` trait resets the database and run migrations for every test.

Now the `titkets` table is created but still no data is added as we did not write the code to do so. Hence the `The table is empty.` message.

It notifies us that the data is not available in the table. But, we know that there is no `/tickets` route available in our project. Also, no exception issued when we try to send a `POST` request to the `/tickets` route. This is because the Laravel is capturing the exceptions as part of it's exception handling process. We need to disable this as suppressing exceptions is not helping much when testing.

```php
public function test_user_can_create_ticket()
{
    $this->withoutExceptionHandling();

    $data = [
        'customer_name' => $this->faker->name(),
        'email' => $this->faker->safeEmail(),
        'phone' => $this->faker->phoneNumber(),
        'description' => $this->faker->paragraph(),
    ];

    $response = $this->post('/tickets', $data);

    $this->assertDatabaseHas('tickets', $data);
}
```

The `withoutExceptionHandling()` function disables the exception handling and shows them on the command line when we run the tests.

If we run the test now, we get a different error message:

```

   FAIL  Tests\Feature\TicketsTest
  ⨯ user can create ticket

  ---

  • Tests\Feature\TicketsTest > user can create ticket
   Symfony\Component\HttpKernel\Exception\NotFoundHttpException

  POST http://localhost/tickets

  at vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php:426
    422▕      * @return \Symfony\Component\HttpFoundation\Response
    423▕      */
    424▕     protected function renderException($request, Throwable $e)
    425▕     {
  ➜ 426▕         return $this->app[ExceptionHandler::class]->render($request, $e);
    427▕     }
    428▕
    429▕     /**
    430▕      * Get the application's route middleware groups.

      +39 vendor frames
  40  tests/Feature/TicketsTest.php:29
      Illuminate\Foundation\Testing\TestCase::post("/tickets", ["Mariela Goyette V", "jevon84@example.com", "830.520.6830", "Voluptatem et aliquid quasi commodi et pariatur esse. Sunt ut qui laudantium in. Est et minus modi voluptatum quod."])


  Tests:  1 failed
  Time:   0.54s
```

The `NotFoundHttpException` says us that the route we are trying to access is not found. So, it's the time to add it. Open the `routes/web.php` and add following line:

```php
Route::post('tickets', function (Request $request) {
    $data = $request->only([
        'customer_name',
        'email',
        'phone',
        'description',
    ]);

    $data['ref'] = \Illuminate\Support\Str::uuid();
    $data['status'] = 0;

    $ticket = \App\Models\Ticket::create($data);
});
```

Also, don't forget to add the mass assignable attributes to `$fillable` property on `Ticket` model.

Run the test again:

```sh

   PASS  Tests\Feature\TicketsTest
  ✓ user can create ticket

  Tests:  1 passed
  Time:   0.48s
```

**Congratulations!** you implemented your first feature using **TDD**


## Refactoring

Once you are familiar with the process you can [refactor](https://en.wikipedia.org/wiki/Code_refactoring) your code to improve it. We used a closure in our example to handle the request. More elegant way is to move the code to a **controller**.

Create a controller:

```sh
php artisan make:controller TicketController
```

Then add the `store()` function to save details of the new ticket.

```php
namespace App\Http\Controllers;

use Illuminate\Http\Request;

class TicketController extends Controller
{
    public function store(Request $request)
    {
        $data = $request->only([
            'customer_name',
            'email',
            'phone',
            'description',
        ]);

        $data['ref'] = \Illuminate\Support\Str::uuid();
        $data['status'] = 0;

        $ticket = \App\Models\Ticket::create($data);
    }
}
```

Then, edit the route and replace the closure with the controller and action we just added.

```php
Route::post('tickets', 'App\Http\Controllers\TicketController@store');
```

Run the test again:

```sh
php artisan test
```

Output:

```

   PASS  Tests\Unit\ExampleTest
  ✓ example

   PASS  Tests\Feature\ExampleTest
  ✓ example

   PASS  Tests\Feature\TicketsTest
  ✓ user can create ticket

  Tests:  3 passed
  Time:   0.59s

```

Great! You refactored your code to a better version without failing the tests.

Follow the same practice repeatedly for any new function added to the system. You can learn more about [testing and assertions](https://laravel.com/docs/8.x/http-tests) at Laravel Official documentation.
