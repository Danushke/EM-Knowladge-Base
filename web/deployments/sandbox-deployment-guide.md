# Sandbox Deployment Guide

Sandbox is the staging environment. Every project in development should be deployed to sandbox to be used as the backend for mobile applications and review by relevant parties.

## Prerequisites

You will need following details before you start the deployment. Contact Tech Lead if you do not have these details before starting the deployment.

* Sandbox server domain name
* cPanel username
* cPanel password
* OAuth app consumer client key
* OAuth app consumer client secret

There are two methods of deploying a project to sandbox.

* Sandboxer Deployment
* Manual Deployment 
 
## Sandboxer Deployment

Sandboxer is an automated tool used to deploy a backend project to the staging server in few minutes of time. This makes it easy to setup the sandbox environment for Laravel projects and saves a considerable amount oif time by automating tasks such as creating a subdomain, setting up a new database and database user and preparing configuration files.

Refer to the [Sandboxer package description](https://bitbucket.org/elegantmedia/sandboxer/src/master/) for installation and basic usage details.

### Connect to a sandbox server

Before setting up a project you need to connect the sandboxer with one of the existing sandbox servers using it's cPanel details.
Please contact the Tech Lead for details of the existing sandbox servers.

In your local computer, move into the sandboxer directory and enter:

```
php sandboxer run
```
Follow the on-screen prompts, and enter the sandbox domain name, cPanel username and cPanel password.
If the connections with server is successful, it will offer you following options.

```
   _____                 ____
  / ___/____ _____  ____/ / /_  ____  _  _____  _____
  \__ \/ __ `/ __ \/ __  / __ \/ __ \| |/_/ _ \/ ___/
 ___/ / /_/ / / / / /_/ / /_/ / /_/ />  </  __/ /
/____/\__,_/_/ /_/\__,_/_.___/\____/_/|_|\___/_/


### Press Ctrl+C to exit at any time. ###

What's the sandbox URL? (eg: sandbox1.domain.com) sandbox10.somedomain.com
What's the cPanel username? sandbox17pr235
What's the cPanel password? 
Testing connection...
Connection successful.
Select an Action
  [0] Add a New Project
  [1] Get or Create a New SSH (Deploy) Key on Server
  [2] Reset Database User Password
  [3] Exit
```

### Generate SSH key

Before moving forward you need to make sure the server has a valid SSH key to connect with BitBucket for installing private packages developed by Elegant Media.

Type 1 and press enter at the above prompt (just after connecting to the sandbox server you plan to set up your project).

This will fetch the existing public key or generate a new one and display it on the screen. YOu will see a response similar to following:

```
Here is the remote Public Key. Add it as a deploy key to all private repositories which needs access.
With Oxygen, use the command `php artisan setup:production:connect-deploy-keys` to add keys.
To add them manually, see following links for instructions.
https://support.atlassian.com/bitbucket-cloud/docs/set-up-an-ssh-key/
https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account

PUBLIC KEY
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDD/WYVAE ... JxIIunrF7M2M0wfYZTygXudQ3gWkcfwudnew==

Select an Action
  [0] Add a New Project
  [1] Get or Create a New SSH (Deploy) Key on Server
  [2] Reset Database User Password
  [3] Exit
```

Here, entire text given by `ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDD/WYVAE ... JxIIunrF7M2M0wfYZTygXudQ3gWkcfwudnew==` is the public key you need to use at BitBucket to gain access to the private repositories. This should be added to the repository you are planing to deploy and each of it's dependencies.

Follow the steps below to add SSH key to the deploying repository.

* Login to BitBucket using an admin account (you need get support of an admin user if you are not an admin)
* Go to `Repository Settings` and click `Access Keys`
* Click `Add Key`
* Enter the domain name of the sandbox as the key name
* Copy and paste the public key you received above into the `Key` field
* Click `Add SSH key`

Move into the project folder in your local computer and enter the following command to add the SSH key to depending repositories.

```
php artisan setup:production:connect-deploy-keys
```

Enter the SSH key and domain name of the sandbox server as the name for the key when promted.
You will need an app consumer key and a secret for adding keys using this command. Obtain this from the Tech Lead.

```
john@Johns-MacBook-Pro webapp % php artisan setup:production:connect-deploy-keys

 What is the PUBLIC KEY to be used?:
 > [ENTER THE PUBLIC KEY HERE]

 Enter a label for the key [mo_c_a_Johns-MacBook-Pro.local]:
 > sandbox10.somedomain.com

 Add all keys with a label `sandbox10.somedomain.com`? (yes/no) [no]:
 > yes

Adding keys requires a BitBucket app consumer.

 Enter Client Key:
 > [OAUTH CONSUMER KEY]

 Enter Client Secret:
 > [OAUTH CONSUMER SECRET]

Adding key to: elegantmedia/oxygen-laravel
Key successfully added to: elegantmedia/oxygen-laravel
Adding key to: elegantmedia/devices-laravel
Key successfully added to: elegantmedia/devices-laravel
Adding key to: elegantmedia/multitenant-laravel
Key successfully added to: elegantmedia/multitenant-laravel
Adding key to: elegantmedia/file-control-laravel
Key successfully added to: elegantmedia/file-control-laravel
Adding key to: elegantmedia/mediamanager-laravel
Key successfully added to: elegantmedia/mediamanager-laravel
Adding key to: elegantmedia/laravel-api-helpers
Key successfully added to: elegantmedia/laravel-api-helpers
Adding key to: elegantmedia/lotus
Key successfully added to: elegantmedia/lotus
Adding key to: elegantmedia/formation
Key successfully added to: elegantmedia/formation
Adding key to: elegantmedia/laravel-app-settings
Key successfully added to: elegantmedia/laravel-app-settings
Adding key to: elegantmedia/laravel-generators
Key successfully added to: elegantmedia/laravel-generators
Adding key to: elegantmedia/quickdata-laravel
Key successfully added to: elegantmedia/quickdata-laravel
Adding key to: elegantmedia/laravel-helpers
Key successfully added to: elegantmedia/laravel-helpers
Adding key to: elegantmedia/php-helpers
Key successfully added to: elegantmedia/php-helpers
Adding key to: elegantmedia/oxygen-push-notifications
Key successfully added to: elegantmedia/oxygen-push-notifications
```

Make sure SSH Key is added to all the depending repositories.

### Deploy the project

Once you have completed the above steps, now you are ready to deploy the project to sandbox server.

Connect to the server using Sandboxer if you have closed it.

Enter `0` while you are at following prompt.

```
Select an Action
  [0] Add a New Project
  [1] Get or Create a New SSH (Deploy) Key on Server
  [2] Reset Database User Password
  [3] Exit
```

Then follow the on-screen instructions.

```
What's the project's name? myproject

What's the git repository URL (eg: git@bitbucket....git)? git@bitbucket.org:elegantmedia/myproject.git
Adding subdomain `myproject.sandbox10.somedomain.com`...
Creating DB User `sandbox10user_myproject_user` with password `$@JSDHSsdhsh`...
Writing to /home/sandbox10user/sites/myproject/bin/first-run.sh...
Writing to /home/sandbox10user/sites/myproject/bin/.htaccess.sandbox...
Writing to /home/sandbox10user/sites/myproject/bin/merge-env.php...
Writing to /home/sandbox10user/sites/myproject/.env.cpanel...
Done.
Login to server and run `sh /home/sandbox10user/sites/myproject/bin/first-run.sh` to complete installation.
```

Once this is done, login to cPanel of the sandbox server using web browser.

Open the `Terminal` from cPanel and enter the following command to switch to the `dev` branch of the repository.

```
cd /home/sandbox10user/sites/myproject
git pull origin dev
```

Then run the following script to finalize the deployment.

```
sh /home/sandbox10user/sites/myproject/bin/first-run.sh
```

This will install composer packages and finalize the deployment.

## Remove a project from sandbox

You might need to remove a project from sandbox server either when the development is over or to free up space.
Follow the steps below to remove a project from the sandbox server. You will need cPanel details to login to the server for performing this.

### Backup data if required

Make sure to take a backup of the database and any uploaded files before removing the project if you are planing to transfer the site to another server.
Also back up the .env file and any other configuration files which are not added to the git repository (Google credentianls .json file etc).

### Remove the domain name

* Visit `Subdomains` under the `Domains` section in cPanel.
* Find the subdomain you wish to remove.
* Note the document root folder connected to the subdomain. This will usually be in format `/sites/myproject/public_html`
* Click `Remove` button next to the subdomain to remove it.
* Click "Delete Subdomain" in next sreen to confirm removal.

### Delete the files

* Open `File Manager` of cPanel
* Locate the document root you noted in the previous step. Most probably this will be inside the `sites` folder.
* Find the `.env` file in the parent folder of the document root.
* Note the database name and database user.
* Delete the parent folder of the document root permanently. This will usually be in format `/sites/myproject`

### Delete the database and database user

* Open `MySQL® Databases` in cPanel.
* Find the database you noted down in the previous step under `Current Databases`.
* Click `Remove` button next to it to delete the database.
* Similarly, find the database username under `Current Users`.
* Make sure this database user not linked with any other database in `Current Databases` list.
* If not linked with any other database, click `Remove` button to remove the database user.

### Delete the GIT URL

* Open **Git™ Version Control**
* Find and remove the GIT URL related to the repository you are deleting.

### Delete log files (optional)
* If there are any log files under the `/logs` directory related to the removed subdomain. Select and delete them too.