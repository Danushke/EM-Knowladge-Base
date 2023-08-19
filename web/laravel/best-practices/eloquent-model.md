# Eloquent Model

## Accessors

### When using the same name as the table column

If the accessor name is same as the table column below example will not work.

**Don't**

```php
public function getAvatarUrlAttribute()
{
    return !empty($this->avatar_url) ? $this->avatar_url : asset('/path/to/default/image.png');
}
```

**Do**

```php
public function getAvatarUrlAttribute($value)
{
    return !empty($value) ? $value : asset('/path/to/default/image.png');
}
```
