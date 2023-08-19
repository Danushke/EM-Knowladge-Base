# Set-up Mac For Laravel Development

Laravel development environment needs to have **Apache**, **PHP**, **MySQL** and **Composer** installed mainly. This guide will walk you through setting up and configuring **Apache 2.4**, multiple **PHP** versions, **MySQL** and Apache virtual hosts.

## Install XCode Command Line Tools

If you don't already have XCode installed, it's best to first install the command line tools:

```sh
xcode-select --install
```

## Install Homebrew

This guide uses [Homebrew](https://brew.sh/) for installing required packages. Homebrew is a package manager for Mac OS. Using the `brew` command you can easily add powerful functionality to your mac, but first we have to install it. This is a simple process, but you need to launch your Terminal (`/Applications/Utilities/Terminal`) application and then enter:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Just follow the terminal prompts and enter your password where required. This may take a few minutes, but when complete, a quick way to ensure you have installed `brew` correctly, simply type:

```sh
brew --version
Homebrew 3.1.9 Homebrew/homebrew-core (git revision a8cf30fe79; last commit 2021-06-02)
```

You should probably also run the following command to ensure everything is configured correctly:

```sh
brew doctor
```

It will instruct you if you need to correct anything.

Also install **OpenSSL** if not installed already.

```sh
brew install openssl
```


## Apache Installation

The latest macOS 11.0 Big Sur comes with Apache 2.4 pre-installed, however, it is no longer a simple task to use this version with Homebrew because Apple has removed some required scripts in this release. However, the solution is to install Apache 2.4 via Homebrew and then configure it to run on the standard ports (80/443).

If you already have the built-in Apache running, it will need to be shutdown first, and any auto-loading scripts removed. It really doesn't hurt to just run all these commands in order - even if it's a fresh installation:

```sh
sudo apachectl stop
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null
```

Now we need to install the new version provided by Brew:


```sh
brew install httpd
```

Without options, `httpd` won't need to be built from source, so it installs pretty quickly. Upon completion you should see a message like:


```sh
🍺  /usr/local/Cellar/httpd/2.4.48: 1,660 files, 31.5MB
```

Now we just need to configure things so that our new Apache server is auto-started

```sh
brew services start httpd
```

You now have installed Homebrew's Apache, and configured it to auto-start with a privileged account. It should already be running, so you can try to reach your server in a browser by pointing it at http://localhost:8080, you should see a simple header that says "It works!".

Apache is controlled via the `brew services` command so some useful commands to use are:

```sh
$ brew services stop httpd
$ brew services start httpd
$ brew services restart httpd
```

### Apache Configuration

Now that we have a working web server, we will want to do is make some configuration changes so it works better as a local development server.

In the latest version of Brew, you have to manually set the listen port from the default of `8080` to `80`, so we will need to edit Apache's configuration file `/usr/local/etc/httpd/httpd.conf`.

This guide uses [Visual Studio Code](https://code.visualstudio.com/) to edit the plain text files. You may use your plain text editor in preference (`vi`, `TextEditor`, `nano` etc).

```sh
code /usr/local/etc/httpd/httpd.conf
```

Find the line that says

```
Listen 8080
```

and change it to `80`:

```sh
Listen 80
```

Next we'll configure it to use the to change the **document root** for Apache. This is the folder where Apache looks to serve file from. By default, the document root is configured as `/usr/local/var/www`. As this is a development machine, let's assume we want to change the document root to point to a folder in our own home directory.

Search for the term `DocumentRoot`, and you should see the following line:

```
DocumentRoot "/usr/local/var/www"
```

Change this to point to your user directory where `your_user` is the name of your user account:

```
DocumentRoot /Users/your_user/Sites
```

You also need to change the `<Directory>` tag reference right below the DocumentRoot line. This should also be changed to point to your new document root also:


```
<Directory "/Users/your_user/Sites">
```

In that same `<Directory>` block you will find an `AllowOverride` setting, this should be changed as follows:

```
#
# AllowOverride controls what directives may be placed in .htaccess files.
# It can be "All", "None", or any combination of the keywords:
#   AllowOverride FileInfo AuthConfig Limit
#
AllowOverride All
```

Also we should now enable mod_rewrite which is commented out by default. Search for `mod_rewrite.so` and uncomment the line by removing the leading `#` by pushing `⌘ + /` on the line (this is a quick way to uncomment and comment a single or multiple lines:

```
LoadModule rewrite_module lib/httpd/modules/mod_rewrite.so
```

#### Configure User & Group

Now we have the Apache configuration pointing to a `Sites` folder in our home directory. One problem still exists, however. By default, apache runs as the user `daemon` and group `daemon`. This will cause permission problems when trying to access files in our home directory. About a third of the way down the `httpd.conf` file there are two settings to set the `User` and `Group` Apache will run under. Change these to match your user account (replace `your_user` with your real username), with a group of `staff`:

```
User your_user
Group staff
```

#### Servername

Apache likes to have a server name in the configuration, but this is disabled by default, so search for:

```
#ServerName www.example.com:8080
```

and replace it with:

```
ServerName localhost
```

### Create Sites Folder

Now, you need to create a `Sites` folder in the root of your home directory. You can do this in your terminal, or in Finder. In this new `Sites` folder create a simple `index.html` and put some dummy content in it like: `<h1>My User Web Root</h1>`.


```
mkdir ~/Sites
echo "<h1>My User Web Root</h1>" > ~/Sites/index.html
```

Restart apache to ensure your configuration changes have taken effect:

```
brew services stop httpd
brew services start httpd
```

Pointing your browser to http://localhost should display your new message. If you have that working, we can move on!

Makes sure you remove the `:8080` port we used earlier. Also, you might need to `Shift` + `Reload` to clear the browser cache and pick up the new file.


## Install PHP

Laravel 8.0 requires PHP 7.3 or later version. In this guide we will be installing PHP 7.4.

Only PHP 7.2 through 7.4 are officially supported by `Brew`, but these also have to be built which is pretty slow. For this guide we will use the new tap from @shivammahtur as there are many versions (including PHP 8.0 builds) pre-built.

Run:

```sh
brew tap shivammathur/php
```

Install PHP 7.4

```sh
brew install shivammathur/php/php@7.4
```

Once done, test that we're in the correct version:

```sh
php -v
```


```
PHP 7.4.12 (cli) (built: Oct 30 2020 00:56:27) ( NTS )
Copyright (c) The PHP Group
Zend Engine v3.4.0, Copyright (c) Zend Technologies
    with Zend OPcache v7.4.12, Copyright (c), by Zend Technologies
```


## Apache PHP Setup

You have successfully installed your PHP versions, but we need to tell Apache to use them. You will again need to edit the `/usr/local/etc/httpd/httpd.conf` file scroll to the bottom of the `LoadModule` entries.

If you have been following this guide correctly, the last entry should be your mod_rewrite module:

```
LoadModule rewrite_module lib/httpd/modules/mod_rewrite.so
```

Below this add the following libphp modules:

```
LoadModule php7_module /usr/local/opt/php@7.4/lib/httpd/modules/libphp7.so
```

Also you must set the Directory Indexes for PHP explicitly, so search for this block:

```
<IfModule dir_module>
    DirectoryIndex index.html
</IfModule>
```

and replace it with this:

```
<IfModule dir_module>
    DirectoryIndex index.php index.html
</IfModule>

<FilesMatch \.php$>
    SetHandler application/x-httpd-php
</FilesMatch>
```

Save the file and stop Apache then start again, now that we have installed PHP:

```
brew services stop httpd
brew services start httpd
```

#### Validating PHP Installation

The best way to test if PHP is installed and running as expected is to make use of phpinfo(). This is not something you want to leave on a production machine, but it's invaluable in a development environment.

Simply create a file called `info.php` in your `Sites/` folder you created earlier with this one-liner.

```sh
echo "<?php phpinfo();" > ~/Sites/info.php

```

Point your browser to http://localhost/info.php and you should see a PHP information page.


## Install MariaDB

[MariaDB](https://mariadb.org/) is drop in replacement for MySQL. We will be using MariaDB for development.

Install MariaDB with Brew:

```sh
brew update
brew install mariadb
```

After a successful installation, you can start the server and ensure it auto-starts in the future with:

```sh
brew services start mariadb
```

You should get some positive feedback on that action:

```
==> Successfully started `mariadb` (label: homebrew.mxcl.mariadb)
```

You must change MySQL server password and secure your installation. The simplest way to do this is to use the provided script:

```sh
sudo /usr/local/bin/mysql_secure_installation
```

Just answer the questions and fill them in as is appropriate for your environment. You can just press return when prompted for the current root password.

If you need to stop the server, you can use the simple command:

```sh
brew services stop mariadb
```

## Install Composer

[Composer](https://getcomposer.org/) is a [dependency manager](https://getcomposer.org/doc/00-intro.md#dependency-management) for PHP applications.

Install Composer in your computer using the instructions given [here](https://getcomposer.org/download/).


## Install Sequel Pro

[Sequel Pro](https://www.sequelpro.com/) is a database management application for working with MySQL databases.

Download and install it. You may use it to connect to and manage your databases similar to `phpMyAdmin`


## Common Issues

### Apache

If you get a message that the browser can't connect to the server after setting up Apache, first check to ensure the server is up.


```sh
ps -aef | grep httpd
```

You should see a few httpd processes if Apache is up and running.

```sh
ps -aef | grep httpd
501   437     1   0 Fri07AM ??         0:02.96 /usr/local/opt/httpd/bin/httpd -D FOREGROUND
501   596   437   0 Fri07AM ??         0:00.00 /usr/local/opt/httpd/bin/httpd -D FOREGROUND
501   597   437   0 Fri07AM ??         0:00.00 /usr/local/opt/httpd/bin/httpd -D FOREGROUND
501   598   437   0 Fri07AM ??         0:00.00 /usr/local/opt/httpd/bin/httpd -D FOREGROUND
501   599   437   0 Fri07AM ??         0:00.00 /usr/local/opt/httpd/bin/httpd -D FOREGROUND
501   600   437   0 Fri07AM ??         0:00.00 /usr/local/opt/httpd/bin/httpd -D FOREGROUND
501 12459  2501   0  3:34PM ttys000    0:00.01 grep httpd
```

If not running, try to start Apache with:

```sh
brew services start httpd
```

Or restart with:


```sh
brew services restart httpd
```
