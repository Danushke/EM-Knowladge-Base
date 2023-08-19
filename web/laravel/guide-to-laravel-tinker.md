# Guide To Laravel Tinker


[Laravel Tinker](https://github.com/laravel/tinker) is a powerful REPL (Read-Evaluate-Print-Loop) for the Laravel framework. It allows you to accesses classes in your project, interact with them, executes commands, and check the information related to the output. Tinker is built on [PsySH](https://psysh.org) which is a runtime developer console and interactive debugger for PHP. This guide shows you how to utilize this amazing tool to interact with your project and debug it.


## Install & run

Laravel doesn't install Tinker by default. You need to install it.

```
composer require laravel/tinker
```

Then run it from terminal:

```
php artisan tinker
```

Tinker provides a prompt indicated by `>>>` where you can enter code and commands to execute them.

Use `-v` option if you need more details on the exceptions and error messages that Tinker throws.

```
php artisan tinker -v
```

Use `-v`, `-vv` or `-vvv` to increase the level of details you need to see. `-v` has minimum verbosity while `-vvv` has the maximum verbosity.

## Get Help

Tinker comes with a number of commands. Enter `help` to list the available commands:

```sh
>>> help
  help             Show a list of commands. Type `help [foo]` for information about [foo].      Aliases: ?                     
  ls               List local, instance or class variables, methods and constants.              Aliases: dir                   
  dump             Dump an object or primitive.                                                                                
  doc              Read the documentation for an object, class, constant, method or property.   Aliases: rtfm, man             
  show             Show the code for an object, class, constant, method or property.                                           
  wtf              Show the backtrace of the most recent exception.                             Aliases: last-exception, wtf?  
  whereami         Show where you are in the code.                                                                             
  throw-up         Throw an exception or error out of the Psy Shell.                                                           
  timeit           Profiles with a timer.                                                                                      
  trace            Show the current call stack.                                                                                
  buffer           Show (or clear) the contents of the code input buffer.                       Aliases: buf                   
  clear            Clear the Psy Shell screen.                                                                                 
  edit             Open an external editor. Afterwards, get produced code in input buffer.                                     
  sudo             Evaluate PHP code, bypassing visibility restrictions.                                                       
  history          Show the Psy Shell history.                                                  Aliases: hist                  
  exit             End the current session and return to caller.                                Aliases: quit, q               
  clear-compiled   Remove the compiled class file                                                                              
  down             Put the application into maintenance / demo mode                                                            
  env              Display the current framework environment                                                                   
  optimize         Cache the framework bootstrap files                                                                         
  up               Bring the application out of maintenance mode                                                               
  migrate          Run the database migrations                                                                                 
  inspire          Display an inspiring quote  
```

Also, you can use `help` to get more information on individual commands:

```sh
>>> help dump
Usage:
 dump [--depth DEPTH] [-a|--all] [--] <target>

Arguments:
 target     A target object or primitive to dump.

Options:
 --depth    Depth to parse. (default: 10)
 --all (-a) Include private and protected methods and properties.

Help:
 Dump an object or primitive.

 This is like var_dump but way awesomer.

 e.g.
 >>> dump $_
 >>> dump $someVar
 >>> dump $stuff->getAll()
```

## Evaluating PHP code

You can write PHP code right on the Tinker prompt and see their result immediately after you press **Enter**.

```sh
>>> 4 + 9
=> 13
>>> substr('Girl with a dragon tatoo', 4, 5)
=> " with"
>>> explode(' ', 'The dark night')
=> [
     "The",
     "dark",
     "night",
   ]
```

## Variables

You can define variables in your Tinker session and work with them. Tinker keeps all variables you create until the session is closed with the `exit` command.

### List variables

Use `ls` command to list the variables defined so far in the current session:

```sh
>>> ls
Variables: $newTicket, $ticket, $total
```

There is a set of private variables in the Tinker shell. You can use `ls -a` or `ls -all` command to access them:

```sh
>>> ls -a
Variables: $newTicket, $ticket, $total, $_, $_e, $__out, $__class, $__namespace, $__file, $__line, $__dir
```

The variables starting with `$_` in above result are called **magic variables**.

|    Variable    |        Value         |
|----------------|----------------------|
| `$_`           | Last result          |
| `$_e`          | Last exception       |
| `$__out`       | Last `stdout` output |
| `$__file`      | Last file path       |
| `$__line`      | Last line            |
| `$__dir`       | Last directory path  |
| `$__class`     | Last class name      |
| `$__method`    | Last method name     |
| `$__function`  | Last function name   |
| `$__namespace` | Last namespace name  |



## Access Classes & Objects

You can use Tinker to access and interact with the classes in your project.

### Creating objects

```sh
>>> use \App\Models\Ticket;
>>> $newTicket = new Ticket
=> App\Models\Ticket {#4513}
```

### Access object properties

Display the value of a property:

```sh
>>> $newTicket->comments
=> Illuminate\Database\Eloquent\Collection {#4498
     all: [],
   }
```

Set the value of a property:

```sh
>>> $newTicket->customer_name = "Dan Abermov"
=> "Dan Abermov"
>>> $newTicket
=> App\Models\Ticket {#4513
     customer_name: "Dan Abermov",
     comments: Illuminate\Database\Eloquent\Collection {#4498
       all: [],
     },
   }
```

### Calling object methods

```sh
>>> $newTicket->id
=> null
>>> $newTicket->save()
=> true
>>> $newTicket->id
=> 4
```

### Loading model data

```sh
>>> $ticket = Ticket::find(1)
=> App\Models\Ticket {#4483
   id: 1,
   customer_name: "Baker Bans",
   email: "baker@bans.com",
   phone: "233727327327",
   description: "Nothing is wrong with this",
   ref: "7daf13994fca1c31fe6a6295055933816a6fdc2e",
   status: 0,
   created_at: "2021-07-09 11:58:35",
   updated_at: "2021-07-09 11:58:35"
 }
```

### View the code of a class

You can use `show` command to check the code of a class or a method of a class.


Viewing the code of a class:

```sh
>>> show Ticket
[!] Aliasing 'Ticket' to 'App\Models\Ticket' for this Tinker session.
 8: class Ticket extends Model
 9: {
10:     use HasFactory;
11:
12:     protected $with = ['comments', 'comments.user'];
13:
14:     /**
15:      * A Ticket Has Many Comments
16:      *
17:      */
18:     public function comments()
19:     {
20:         return $this->hasMany(\App\Models\Comment::class);
21:     }
22:
23:     public function getLastCommentedAgentAttribute()
24:     {
25:         return $this->comments->sortByDesc('created_at')
26:             ->whereNotNull('user')->pluck('user')->first();
27:     }
28: }
```

Once you use the `show` command to view the code of a class the `$__class` and `$__file` variables are set to the class name and path of the file respectively.

```sh
>>> $__class
=> "App\Models\Ticket"
>>> $__file
=> "/Users/saranga/Documents/Projects/ElegantMedia/support/app/Models/Ticket.php"
```

You can use them in subsequent code you enter at Tinker:

```sh
>>> $ticket = new $__class
=> App\Models\Ticket {#4508}
```

Viewing the code of a method:

```sh
>>> show Ticket::comments
14:     /**
15:      * A Ticket Has Many Comments
16:      *
17:      */
18:     public function comments()
19:     {
20:         return $this->hasMany(\App\Models\Comment::class);
21:     }
```

Once you use the `show` command to view the code of a method the `$__method` and `$__line` variables are set to the method name and the starting line number of method respectively.

```sh
>>> $__method
=> "App\Models\Ticket::comments"
>>> $__line
=> 18
```

## Debugging code with Laravel Tinker

Tinker is PsySH with some additions. So, you can use it to debug PHP code the same way how PsySH does. To debug your code using PsySH, you need to serve your Laravel project using:

```sh
php artisan serve
```

Then place `eval(\Psy\sh());` anywhere you want to add a debug point in your code. Basically, this is where you would add a `dd()` function call when debugging without any tool.

Once you run the code, the PHP server would stop and handover the terminal to Tinker so that you can examine the application status at that moment.

```sh
php artisan serve
Laravel development server started: http://127.0.0.1:8000
[Thu Jul 22 08:34:48 2021] 127.0.0.1:64290 [200]: /css/dist/app.css?id=cdceb5d4cca73ec15a7d
[Thu Jul 22 08:34:48 2021] 127.0.0.1:64296 [200]: /js/dist/app.js?id=80a07eb2b1c140d70cf0
.
.
.
[Thu Jul 22 08:35:10 2021] 127.0.0.1:64439 [200]: /images/sketches/1x/ic_notification.png
[Thu Jul 22 08:35:10 2021] 127.0.0.1:64441 [200]: /images/sketches/2x/ic_search_search_bar_16x16.png
[Thu Jul 22 08:35:10 2021] 127.0.0.1:64443 [200]: /css/dist/app.css?id=cdceb5d4cca73ec15a7d
[Thu Jul 22 08:35:11 2021] 127.0.0.1:64451 [200]: /favicon.png
Psy Shell v0.9.12 (PHP 7.3.29 — cli-server) by Justin Hileman

From /Users/saranga/Documents/Projects/SportsBlock/sportsblock/app/Http/Controllers/CompetitionController.php:239:

    237|         ], $filter);
    238|
  > 239|         eval(\Psy\sh());
    240|         
    241|         return view('competitions.index', [
ls
Variables: $admins, $ageGroup, $competition, $competitions, $distance, $feeMax, $feeMin, $filter, $filters, $gender, $length, $level, $maxFeeAmount, $organize, $perPage, $prizeType, $q, $request, $sport, $tab, $this, $type, $user, $user_admin, $view
$type
=> "all"
```

You can use `ls` to list the variables defined at the debug point and enter their names to see the values.

  > There was an issue with Laravel 8 which prevents PHP process switching from server to Tinker (PsySH), which can be solved by using the PHP server directly using: `php -S localhost:8000 -t public`

Type `exit` and press `enter` key to exit Tinker and continue with the rest of your program. Also, you can press `Ctrl + D` to exit Tinker.

You may add multiple instances of `eval(\Psy\sh());` in your code. The application would stop all those positions and switch to Tinker allowing you to examine the application status.
