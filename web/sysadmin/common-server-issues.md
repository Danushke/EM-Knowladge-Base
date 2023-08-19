# Common Server Issues

## fatal: Could not read from remote repository. Please make sure you have the correct access rights and the repository exists.

This is often noticed when trying to update the server (sandbox/live) using `git pull` command. Reason for this issue could be, the server is setup to communicate with `BitBucket` using SSH connection with the use of a `private key` and private key is not added to the `ssh-agent` of current user session.

Run agent
```
eval `ssh-agent -s`
```

Add private key

```
ssh-add ~/.ssh/KEYNAME
```

You might need to enter the pass phrase for the key if there is one.


## Parse error: syntax error, unexpected '?' in /home/mywd3242py/vendor/laravel/framework/src/Illuminate/Foundation/helpers.php on line 500

This error is noticed when trying to run artisan command, console command or load a page with PHP version 5.x on a Laravel instance which require PHP 7.x.

On terminal, using the correct version of PHP can be selected from one of the available PHP installations on cPanel based server.

```
alias php=/opt/cpanel/ea-php71/root/usr/bin/php
```

If the above error is noticed on a web browser while trying to load a web page, PHP version could be changed with cPanel.
```
1. Login to cPanel
2. Go to `MultiPHP Manager` unser 'Software' section
3. Select the chekbox next to the domain name you want to change the PHP version for
4. Change the PHP version to `PHP 7.1 (ea-php71)`
5. Click Apply
```

## Warning: `exec()` has been disabled for security reasons
This issue was noticed when running Laravel task scheduler and Laravel Tinker. Quick solution would be to disable `disable_functions` options on command line.

```
php -d "disable_functions=" artisan tinker
```
