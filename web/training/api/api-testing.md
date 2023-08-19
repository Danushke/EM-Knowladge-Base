# API Testing

This guide explains how to test the APIs using **Postman** and automated tests.

## Testing APIs with Postman

Before we start testing the APIs, we need to get familiar with few concepts used in **Postman**. Read the following articles in full to understand the **Collections**, **Variables** and **Environments** in **Postman**.

- [Grouping requests in collections](https://learning.postman.com/docs/sending-requests/intro-to-collections/)
- [Using variables](https://learning.postman.com/docs/sending-requests/variables/)
- [Managing environments](https://learning.postman.com/docs/sending-requests/managing-environments/)

All APIs of **Elegant Media** are developed using `emedia/api` package. It generates few files when you enter the command:

```
php artisan generate:docs
```

You can find these fiels in `public_html\docs\`

- `postman_collection.yml` - Postman Collection (YAML)
- `postman_collection.json` - Postman Collection (JSON)
- `postman_environment_local.json` - Postman Environment (LOCAL)
- `postman_environment_sandbox.json` - Postman Environment (SANDBOX)
- `swagger.html` - Swagger 2.0 Specification (HTML)
- `swagger.json` - Swagger 2.0 Specification (JSON)
- `swagger.yml` - Swagger 2.0 Specification (YAML)

In order to test the APIs on **Postman** we will need to import the **collection** and an **environment** file. Go ahead and import `postman_collection.json`, `postman_environment_local.json` and `postman_environment_sandbox.json` files to your **Postman**.

Read the guide [Importing data into Postman](https://learning.postman.com/docs/getting-started/importing-and-exporting-data/#importing-data-into-postman) to understand how to do this.

Once after you import the files to **Postman** you will see the collection your imported in the **Collections** panel. And two environments are added to your Postman **environment** list on the right top corner, right below the toolbar.

In order to test the APIs locally you need to select the environment marked with **(LOCAL)** and to test API on sandbox (staging) server you need to select the one marked with **(SANDBOX)**.

Select the environment accordingly and open a request from your collection. At this point you can move your mouse over the variables in your API request to make sure they have set to the correct values.

Run the request and check the responses to ensure the response data is correct. Check for following points:

- Make sure no API is accessible without a valid `API KEY`
- Ensure the restricted APIs are not accessible without the `ACCESS TOKEN`
- Input parameters mentioned in the API docs are functioning
- The response is in correct format
- Values are in correct data type


## Automated testing

**Postman** also supports automated testing of APIs. However to keep things more integrated, `emedia\api` package supports generating automated tests for APIs. Use the following command to generate the tests for existing APIs.

```
php artisan generate:api-tests
```

This generates the test classes inside `tests\AutoGen\API\V1` folder in your project.

In case you get the following error when you run this:

```
RuntimeException

PHP CS Fixer not found. This is required to proceed. Check by typing `php-cs-fixer --version` and press enter.
```

You will need to install `php-cs-fixer`. [This](https://github.com/FriendsOfPHP/PHP-CS-Fixer/blob/3.0/doc/installation.rst) give the instructions on how to install it.

After successfully generating the tests, in order to quickly run them, move to the base folder of the project and run:

```
./vendor/bin/phpunit
```

This makes `phpunit` to run all test cases in the `tests` directory. By default these tests only check for a successful response as a result of calling an API endpoint. It checks if the HTTP status code of the response is `200` in order to do this. You can see this by opening one of the test generated.

```php
public function test_api_article_get_get_articles()
{
    $data = $cookies = $files = $headers = $server = [];
    $faker = \Faker\Factory::create('en_AU');
    $content = null;

    // header params
    $headers['Accept'] = 'application/json';
    $headers['x-access-token'] = $this->getAccessToken();
    $headers['x-api-key'] = $this->getApiKey();


    $response = $this->get('/api/v1/articles', $headers);

    $this->saveResponse($response->getContent(), 'article_get_get_articles', $response->getStatusCode());

    $response->assertStatus(200);
}
```

However this is alone is not enough to make sure that the API is functioning as expected. We would need to customise the generated tests to assert the points we checked previously with **Postman**.

For example, let's take a look at an API endpoint created for accessing **articles**. This API allows retrieving a collection of articles using `GET /articles` API endpoint.

The JSON representation of an article should be:

```json
{
    "id": 19,
    "title": "Itaque architecto voluptas rem quisquam at quia.",
    "content": "Velit et ea voluptatum omnis aut. Dolorem nam eaque eum sequi exercitationem. Veritatis eos eos sunt distinctio maxime qui animi reiciendis.",
    "user_id": 129,
    "created_at": "2021-06-22T10:48:04.000000Z",
    "updated_at": "2021-06-22T10:48:04.000000Z"
}
```

Also the `GET /articles` API endpoint supports **pagination** and **searching** by the title. So putting all together a usual request to this API would be in following format:

```
GET /articles?q=qui&page=2&per_page=5
```

If everything goes well, a successful response should be in following format:

```json
{
    "payload": [
        {
            "id": 9,
            "title": "Sequi fuga cum ea fugiat eos dolor.",
            "content": "Laboriosam asperiores assumenda sed neque alias saepe. Doloremque molestiae dolor quia itaque animi. Accusamus et commodi nulla odio et ducimus aut. Voluptatum quo voluptatem ad rerum.",
            "user_id": 119,
            "created_at": "2021-06-22T10:48:04.000000Z",
            "updated_at": "2021-06-22T10:48:04.000000Z"
        },
        {
            "id": 10,
            "title": "Et enim fuga natus magnam voluptatem qui numquam.",
            "content": "Quia fuga qui temporibus perspiciatis aut. Asperiores quasi omnis nihil pariatur. Excepturi repellendus ullam aliquid sit exercitationem ea. Dolorum laborum repudiandae ea vel autem nulla ut.",
            "user_id": 120,
            "created_at": "2021-06-22T10:48:04.000000Z",
            "updated_at": "2021-06-22T10:48:04.000000Z"
        },
        {
            "id": 11,
            "title": "Consequatur tenetur quibusdam accusamus voluptatem nihil.",
            "content": "Dolorem esse alias nesciunt voluptas soluta. Soluta fugit sit nam accusamus velit et. Autem aut unde dolores eum cupiditate dolorum. Libero perspiciatis tenetur aut nihil. Aut voluptas pariatur magni voluptate.",
            "user_id": 121,
            "created_at": "2021-06-22T10:48:04.000000Z",
            "updated_at": "2021-06-22T10:48:04.000000Z"
        },
        {
            "id": 12,
            "title": "Est molestiae quae veritatis aliquid facere soluta inventore omnis.",
            "content": "Beatae tenetur ipsam iure id. Accusantium officiis a omnis quidem blanditiis et. Maiores dolores eum omnis dolores repellat. Culpa rerum reiciendis ea dolore ut libero eligendi.",
            "user_id": 122,
            "created_at": "2021-06-22T10:48:04.000000Z",
            "updated_at": "2021-06-22T10:48:04.000000Z"
        },
        {
            "id": 13,
            "title": "Perferendis placeat aut quaerat facilis sequi corporis.",
            "content": "Nemo fugiat autem qui et excepturi. Sint in temporibus fuga aut libero nobis est est. Amet non et non eius totam quas.",
            "user_id": 123,
            "created_at": "2021-06-22T10:48:04.000000Z",
            "updated_at": "2021-06-22T10:48:04.000000Z"
        }
    ],
    "paginator": {
        "current_page": 2,
        "first_page_url": "http://apiguide.test/api/v1/articles?page=1",
        "from": 6,
        "last_page": 6,
        "last_page_url": "http://apiguide.test/api/v1/articles?page=6",
        "links": [
            {
                "url": "http://apiguide.test/api/v1/articles?page=1",
                "label": "&laquo; Previous",
                "active": false
            },
            {
                "url": "http://apiguide.test/api/v1/articles?page=1",
                "label": "1",
                "active": false
            },
            {
                "url": "http://apiguide.test/api/v1/articles?page=2",
                "label": "2",
                "active": true
            },
            {
                "url": "http://apiguide.test/api/v1/articles?page=3",
                "label": "3",
                "active": false
            },
            {
                "url": "http://apiguide.test/api/v1/articles?page=4",
                "label": "4",
                "active": false
            },
            {
                "url": "http://apiguide.test/api/v1/articles?page=5",
                "label": "5",
                "active": false
            },
            {
                "url": "http://apiguide.test/api/v1/articles?page=6",
                "label": "6",
                "active": false
            },
            {
                "url": "http://apiguide.test/api/v1/articles?page=3",
                "label": "Next &raquo;",
                "active": false
            }
        ],
        "next_page_url": "http://apiguide.test/api/v1/articles?page=3",
        "path": "http://apiguide.test/api/v1/articles",
        "per_page": "5",
        "prev_page_url": "http://apiguide.test/api/v1/articles?page=1",
        "to": 10,
        "total": 29
    },
    "message": "",
    "result": true
}
```

This is our guide for adding more assertions to the test. You can get the success response similar to above one using the **Postman** as we discussed above. Yes, you have to test your API manually using **Postman** at least once after you develop it. The real use of the automation is for **regression testing**, that means ensuring your API endpoints are not broken when you introduce new features down the line.

> However if you are confident on writing the tests before you do the actual implementation of the API, you can do that too. which in fact is called **TDD (Test Driven Development)**.

### Seed some data

Before you run your tests you might need to have some test data in the database. You can use the **model factories** to do this. I would not discuss how to set up the model factories here but you can read more on that [here](https://laravel.com/docs/8.x/database-testing#defining-model-factories).

In order to add some articles add the following code right after where the `$content = null;` line on above test:

```php
\App\Models\Article::factory()->count(50)->create();
```

This will create 50 articles every time you run this test. So be careful with the test data when you work with the sandbox. You may reset the respective table by **truncating** it. Again, use only for testing.

```php
\App\Models\Article::truncate();
```

### Test for availability of data

In order to do this, we need to add some data to the database and see if that is included in the response. Here we add an article with a known title and use that information to check if the particular article is available in the response.

```php
public function test_api_article_get_get_articles()
{
    $data = $cookies = $files = $headers = $server = [];
    $faker = \Faker\Factory::create('en_AU');
    $content = null;

    Article::truncate();
    Article::factory()->create([
        'title' => 'No perfume will stink.'
    ]);

    // header params
    $headers['Accept'] = 'application/json';
    $headers['x-access-token'] = $this->getAccessToken();
    $headers['x-api-key'] = $this->getApiKey();


    $response = $this->get('/api/v1/articles', $headers);

    $this->saveResponse($response->getContent(), 'article_get_get_articles', $response->getStatusCode());

    $response->assertStatus(200);
    $response->assertJson(['payload' => [['title' => 'No perfume will stink.']]]);
}
```

We can use `assertJson()` function to check for **JSON** data in the response. Also note how the PHP arrays are used to resemble the JSON data. You will need to focus on this to get data matched.


### Testing for search result

In order to do this, we need to add multiple data items to the database and see if they appear in search results. Here we add few articles with unknown titles and one article with a known title. We can use that information to check if the particular article is available in the response.

```php
public function test_api_get_articles_search()
{
    $data = $cookies = $files = $headers = $server = [];
    $faker = \Faker\Factory::create('en_AU');
    $content = null;

    Article::truncate();
    Article::factory()->count(10)->create();
    Article::factory()->create([
        'title' => 'No perfume will stink.'
    ]);

    // header params
    $headers['Accept'] = 'application/json';
    $headers['x-access-token'] = $this->getAccessToken();
    $headers['x-api-key'] = $this->getApiKey();


    $response = $this->get('/api/v1/articles?q=perfume', $headers);

    $this->saveResponse($response->getContent(), 'article_get_get_articles', $response->getStatusCode());

    $response->assertStatus(200);
    $response->assertJson(['payload' => [['title' => 'No perfume will stink.']]]);
}
```

### Testing for pagination

Similar to above case, we can add multiple articles to the database and see if they get paginated accordingly.

```php
public function test_api_get_articles_pagination()
{
    $data = $cookies = $files = $headers = $server = [];
    $faker = \Faker\Factory::create('en_AU');
    $content = null;

    Article::truncate();
    Article::factory()->count(50)->create();

    // header params
    $headers['Accept'] = 'application/json';
    $headers['x-access-token'] = $this->getAccessToken();
    $headers['x-api-key'] = $this->getApiKey();


    $response = $this->get('/api/v1/articles?page=3&per_page=10', $headers);

    $this->saveResponse($response->getContent(), 'article_get_get_articles', $response->getStatusCode());

    $response->assertStatus(200);
    $response->assertJsonCount(10, 'payload');
    $response->assertJson(['paginator' => ['current_page' => 3]]);
}
```

We use `assertJsonCount()` function to check the number of items available in the **payload**. Also we check for the pagination details to make sure they match the criteria we request using `page` and `per_page` parameters.


### Testing for data types

There are cases your data needs to be in a particular data type when they are transferred as a response of an API. The reason behind this could be because how they are mapped at client side.

For example, say, the ID of articles should be in `string` format on the response. However the IDs are in `integer` format in the database, if you have used an incremental value for it. You already know that this casting can be done in the **Eloquent Model** using `$casts` property.

Let's write a test for testing this:

```php
public function test_api_get_articles_data_types()
{
    $data = $cookies = $files = $headers = $server = [];
    $faker = \Faker\Factory::create('en_AU');
    $content = null;

    Article::truncate();
    $article = Article::factory()->create([
        'title' => 'No perfume will stink.'
    ]);

    // header params
    $headers['Accept'] = 'application/json';
    $headers['x-access-token'] = $this->getAccessToken();
    $headers['x-api-key'] = $this->getApiKey();


    $response = $this->get('/api/v1/articles', $headers);

    $this->saveResponse($response->getContent(), 'article_get_get_articles', $response->getStatusCode());

    $response->assertStatus(200);
    $response->assertJson(['payload' => [['id' => (string) $article->id]]], true);
}
```

Note that we have to cast the ID of the article to `string` and set `strict` mode to `true` on `assertJson()` function.

Similarly you can modify automatically generated tests to cover many scenarios of the response data. To learn more in HTTP testing and available tools, read [HTTP Tests](https://laravel.com/docs/8.x/http-tests) on official Laravel documentation.

Happy testing!
