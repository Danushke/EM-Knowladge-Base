Deploying A Project To cPanel Host
==================================

The [cPanel](https://en.wikipedia.org/wiki/CPanel) is a popular web hosting management software. Elegant Media uses the **cPanel** based servers for deploying projects for staging and production. This guide helps you understand the **cPanel**, it's features and how to deploy a project to **cPanel** based hosting.

**Prerequisite**

Create a Laravel project locally and set up the database for it. Then, upload it to BitBucket. We will deploy this project to a **cPanel** based hosting later in the guide below.

## Domain and sub-domain management

Each **cPanel** based host can have one or more domain name. Please read the following guides to understand how you can manage domains and sub-domains.

- [Manage Domains](https://docs.cpanel.net/cpanel/domains/domains/)
- [Manage Subdomains](https://docs.cpanel.net/cpanel/domains/subdomains/)

**Exercise 1**: Obtain a cPanel hosting from the supervisor. Create a subdomain with your project name. For example, if the domain name of the hosting is `sandbox20.preview.cx` and your project name is `myapp`, your subdomain should be `myapp.sandbox20.preview.cx`.


## Database management

Almost all backend projects use the databases. The **cPanel** provides a convenient interface to manage databases and comes with **phpMyAdmin** to access **MySQL** databases. Please refer to following guides to understand how to manage databases with **cPanel**.

- [MySQL® Database Wizard](https://docs.cpanel.net/cpanel/databases/mysql-database-wizard/)
- [MySQL® Databases](https://docs.cpanel.net/cpanel/databases/mysql-databases/)

**Exercise 2**: Create a database and database user. Name your database similar to the test project you set up. Note down details for later use.


## File management

The **cPanel** has a comprehensive interface to support managing files hosted in the server managed by it. Please refer to following guide to understand the **cPanel File Manager**.

- [File Manager](https://docs.cpanel.net/cpanel/files/file-manager/)

**Exercise 3**: Navigate to the root folder of the subdomain you created in **Exercise 1** and add a new file with name `index.php`. Open the file for editing and add the following content to the file and save it.

```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Coming soon...</title>
    </head>
    <body>
        <div>
            <h1>Welcome to cPanel</h1>
        </div>
    </body>
</html>
```

Visit your subdomain using a browser to see the output.


## Access the server with Terminal


The **cPanel** provides a in-browser **Terminal** to access the server. Visit **Advanced** >> **Terminal** to open it. You can use this terminal to carry out any task you would do with an SSH terminal. We will be using this to deploy our project.


## Set up SSH keys

**SSH Keys** are used to establish an encrypted and secure connection between two serves. Please read the following guide to understand how to manage SSH keys with **cPanel**:

- [SSH Access to cPanel](https://docs.cpanel.net/cpanel/security/ssh-access/)

Also, the guide [Add A Laravel Project To BitBucket](../training/add-a-laravel-project-to-bitbucket.md) guides you on how to add SSH keys and upload your Laravel project to BitBucket.


## Deploy your project to cPanel host

Once you are well familiar with the topics discussed above, it is time to deploy your project to a server managed by **cPanel**.

Login to the **cPanel** with the username and password.

Add server's SSH key to BitBucket repository. Make sure you add it to the repository and not to your account. If the key is added to your account, the server will have access only to the repositories that your account has access to. This will block other developers using the same key for their deployments.

Open the **Terminal** and move to the folder `sites`:

```sh
cd ~/sites
```

If the `sites` folder is not available, create it:

```sh
cd ~
mkdir sites
cd ~/sites
```

Clone your repository using **GIT**:

```sh
git clone git@bitbucket.org:username/myapp.git
```

Replace `username` and `myapp` with your BitBucket username and repository name. If the project your are deploying is a client project of Elegant Media, username must be `elegantmedia`.

Move in to the project folder once the cloning is completed.

```sh
cd myapp
```

If you are deploying to a staging server, and a `dev` (development) branch available, checkout the `dev` branch.

```sh
git checkout dev
```

Install the dependencies with the composer:

```sh
composer install
```

Never run `composer update` on a server. In case you need to make change to the code or dependencies, do them locally and `git pull` from server.

Make a copy of `.env.example` and name it `.env`

```sh
cp .env.example .env
```

Generate the app key:

```sh
php artisan key:generate
```

Configure the database with the details of the database you created in **Exercise 2**.

Run migratrions:

```sh
php artisan migrate
```

Run seeders if required (optional):

```sh
php artisan db:seed
```

## Adjust the subdomain root path

The **Document root** path of the subdomain you created in **Exercise 1** might be linked to a path inside the `public_html` folder. Configure it to point to `/sites/myapp/public`. If you are deploying an **Oxygen** project, your public folder will be `/sites/myapp/public_html`. Make sure you set the path accordingly.

That's all.

Visit the subdomain using a web browser to make sure your deployment is successfull.
