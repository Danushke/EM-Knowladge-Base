# Use Of Constant Values For Attribute Options

## Problem: Attribute options

It is a frequent requirement of entity attributes to have a value from a pre-defined set of values. For example, an `Advertisement` can only be assigned to one of the following slots:

* header
* footer
* sidebar
* post-footer

The slot names are constant values since you have already programmed them into your website template. Once an advertisement is assigned to any of these, it will be visible inside that slot.

When designing the database for this scenario, it is a common practice to map this kind of data to integers and use them throughout the application.

* 1 = header
* 2 = footer
* 3 = sidebar
* 4 = post-footer

```php
$ad = Advertisement::create([
  'name' => 'Coke after every meal',
  'slot' => 1,
  'status' => 1,
])
```

When filtering advertisements for for a particular slot:

```php
$headerAds = Advertisement::where('slot', 1)->get()
```

But this easily can go out of hand when your code is complex and you have to check for the attribute value in several places in your code. Also it make the job harder of a second developer when he tries to understand the code. You/he might have to cross check to understand which value stands for which slot.


## The solution: Named Constants

To solve the above mentioned issue, most common practice is to use named constants in model. Taking the same example above, slot numbers could be named with human readable names.

```php
<?php

namespace App\Entities\Advertisements;

use Illuminate\Database\Eloquent\Model;

class Advertisement extends Model
{
    const SLOT_HEADER = 1;
    const SLOT_FOOTER = 2;
    const SLOT_SIDEBAR = 3;
    const SLOT_POST_FOOTER = 4;

    const STATUS_UNPUBLISHED = 0;
    const STATUS_PUBLISHED = 1;

    protected $table = 'advertisements';

    protected $fillable = [
        'name',
        'description',
        'image_path',
        'slot',
        'status',
    ];
}
```

Note that the name of the constant is composed by combining the attribute name and value name.

With that, when creating the entity:

```php
$ad = Advertisement::create([
  'name' => 'Coke after every meal',
  'slot' => Advertisement::SLOT_HEADER,
  'status' => Advertisement::STATUS_PUBLISHED,
])
```

And accessing the data:

```php
$headerAds = Advertisement::where('slot', Advertisement::SLOT_HEADER)->get()
```

This is more readable and understandable. Also it gives the freedom to developer to replace the value of a constant without finding and replacing all occurrences throughout the codebase.
