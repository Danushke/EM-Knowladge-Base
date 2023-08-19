# Developer Onboarding Guide

Welcome to Elegant Media (EM), Backend Team!

This document will guide you through the process of getting yourself familiar with the technologies, libraries, frameworks, tools, processes, documents, and practices used by the team while developing the software solutions.

Please go through this guide carefully and make sure you understand the content in full. In case you need assistance with understanding any of the parts of this document please discuss in the Skype group chat for `Backend Team`.


## Day 1

### Email, Skype, Trello, Bitbucket & Atlas Accounts

Make sure you have received a valid Email account, Skype account, and Atlas account from the HR manager on the very first day after you join. If you did not receive these details within the first date, please contact the HR manager immediately.

Once you have set your email up for receiving emails, create a new Bitbucket account using the same email address.

Share your email address and Skype ID with the Tech Lead to gain access to the company BitBucket account, Trello account, and Backend Team group chat.

### Setup The Development Environment

Once you receive a computer, set it up for developing PHP web applications using one of the methods mentioned below based on the operating system.

- **Mac:** [Set up Mac for Laravel Development](set-up-mac-for-laravel-development.md)
- **Linux:** [Set up Linux for Laravel Development](set-up-linux-for-laravel-development.md)
- **Windows:** [Set up Windows for Laravel Development](set-up-windows-for-laravel-development.md)

### Recording Daily Time Report

Every team member **must** record a daily report of work carried out and time spent on them.
It is important to do this before 6:30 pm every day from day 1 and should not be forgotten.
Follow the steps below to record your daily report.

* Login to [Atlas](https://atlas.elegant-media.com/)
* Click `Submit My Daily Report` on the dashboard.
* A form will be opened with an empty row for you to add the tasks carried out within the day.
* Check the date at the top to make sure you are recording the report for the correct date.
* Select the relevant project or group from the list in the first column.
* Enter the task you carried out related to the selected project or group. Be descriptive and make sure the text you enter here explains what you did.
* Add the time you spent in hours and minutes in the next two columns.
* If a task requires more than 4 hours, divide the task into a few sub-tasks and record. Be descriptive.
* Use separate rows for different tasks. Use the `Add New Task` button to add more rows.
* Don't forget to `Save Now` button at the top when you are done adding tasks.

### Evaluations

Every team member goes through a thorough evaluation process to make sure continuous improvement of the skills.
As a new member, your performance will be evaluated on 14th and 28th days after joining. There are quarterly evaluations afterward.

Refer to [Performance Review Of Team Members - Colombo](https://atlas.elegant-media.com/playbook/docs/a06e5116-665e-46ac-8068-76f74d0a034d/performance-review-of-team-members-colombo) for more details.

The HR manager will share your 14 days evaluation sheet on the very first date. Please contact the HR manager immediately if you did not receive this on the first day itself.
You need to pay attention to each point mentioned in this sheet and take action to cover them within the first 14 days.    


## Day 2

You should have your development environment set up by now and ready to start Laravel based development.

### Internal Packages

EM uses a set of internally developed private packages to boost up the development.
Most of them are Laravel extensions. They deliver most of the common functions required by mobile application backends.

It is necessary to understand the features of these packages before starting the development to avoid rebuilding the same functions while you are working.
Start studying the packages in the order they presented in this guide. You will require to face a test at the end of the first month based on the knowledge you acquire by studying these packages.

Study the following packages on day 2.
Refer to the `readme.md` of each package for usage instructions.
You will need to check the code to understand the functions they deliver.

* [Oxygen](https://bitbucket.org/elegantmedia/oxygen-laravel/src/master/)
* [Devices - Laravel](https://bitbucket.org/elegantmedia/devices-laravel/src/master/)
* [Laravel App Settings](https://bitbucket.org/elegantmedia/laravel-app-settings/src/master/)
* [Laravel API Helpers](https://bitbucket.org/elegantmedia/laravel-api-helpers/src/master/)
* [Laravel Media Manager](https://bitbucket.org/elegantmedia/laravel-media-manager/src/master/)
* [Formation](https://bitbucket.org/elegantmedia/formation/src/master/)
* [Lotus](https://bitbucket.org/elegantmedia/lotus/src/master/)


### Set Up Oxygen

Set up a new project based on Oxygen following the instructions given package description.
Try setting up the project using both [Oxygen Installer](https://bitbucket.org/elegantmedia/oxygen-installer/src/master/) and [Manual Method](https://bitbucket.org/elegantmedia/oxygen-laravel/src/d08b1141901dccbcaf7ce6cf361a3ea97ba75ac8/INSTALLATION.md).


## Day 3

Today you are going to spend most of your time studying the internal packages. Following are few guidelines to help you get the most out of your time:

- Visit the BitBucket repository of each package and read the `readme.md` file carefully.
- Examine the code of your **Oxygen** project to find out where the package is used and how.
- Create few models, controllers, and view files to try out the functionality of the package.
- Check BitBucket for recently developed projects and examine them for the usage of the particular package.
- If you have questions, discuss them in the **Backend Team** group chat.


## Day 4

Every mobile application has a backend. The API is the connection between the mobile and the backend. Because of that, API development knowledge is crucial for a backend developer. EM has **Laravel API Helpers** to make this easy. Study the following documents to understand the REST APIs and API development process at EM.

- [REST API Basics](https://bitbucket.org/elegantmedia/em-knowledge-base/src/master/web/training/api/rest-api-basics.md)
- [REST API Best Practices](https://bitbucket.org/elegantmedia/em-knowledge-base/src/master/web/training/api/rest-api-best-practices.md)
- [API Development Guide](https://bitbucket.org/elegantmedia/em-knowledge-base/src/master/web/training/api/api-development-guide.md)
- [API Testing Guide](https://bitbucket.org/elegantmedia/em-knowledge-base/src/master/web/training/api/api-testing.md)

Practice the examples mentioned in the **API Development Guide** and **API Testing Guide** to make sure you understand them well.


## Day 5

Keep studying what you learned in the past 4 days and do more practice. You need to take a 20 minutes test to measure your knowledge of the internal packages today. All the best at the test!

Once you are done with the test, please read the following content to understand how the development process of EM. You will be assigned to a team and a project which you will be working on from week 2.

### Development Teams

EM developers are divided into multiple teams. Each team consists of a Team Lead (TL), iOS developers, Android developers, backend developers and designers.
Also, each team has a Project Manager (PM). Each team is assigned a set of projects and team is responsible for the development and delivery of the assigned projects.
PM defines the scope of work and TL makes sure to do a quality release on time.
It is your responsibility within the team to develop, test and deliver the planned features on time, even without the involvement of a Team Lead.

Currently there are 6 teams in EM:

- Gold Team
- Crystal Team
- Green Team
- Red Team
- Purple Team
- Blue Team

### Fortnightly Schedule

EM teams are working on a fortnightly time plan. The time plan starts on a Friday and continues for 2 weeks of time. PM and TL prepare the task list and communicate it to the team members. Team members should check the fortnightly schedule every day to make sure they are working on the right project assigned for that particular date. If the team member is not aware of the tasks to carry out on a day, he or she must immediately contact TL and get the work allocated.

Your team lead will share the fortnightly schedule with you as soon as you are assigned to a team. Do not forget to ask for this if you are not.

### Project Details On Trello

Log in to the [Trello](https://trello.com) account you created on Day 1.
You should have access to [All Projects](https://trello.com/b/Ye0c0HVh/all-projects) board of company Trello account by now.
Contact the Tech Lead if not.

Note that each card on this board represents a project and columns represent different stages that a project can be.
Try to get yourself familiar with the project details, documents, and conversations on a few of the project cards.
Find and start studying the following documents immediately after you are assigned to a project.

* Project Milestone Specification / Functional Requirement Document (FRD)
* Backend and Mobile Application wireframes on the Invision
* Backend and/or Mobile Application designs on the Invision
* Sandbox details, if the project is already started

Study the above documents thoroughly before starting the development.

### Project Related Communications

Use the respective Trello card for communicating all decisions and deliverables.

Each project has its own Skype chat group or Slack channel.
Use the respective Skype group or Slack channel for casual communication related to a particular project.

Proactive communication is important for a better understanding of the requirements and delivering satisfying results.
You are encouraged to communicate proactively and get the issues resolved without waiting to make sure your work is completed within the allocated time with quality.

## Week 2

This week should mostly be dedicated to understanding and starting the development of the projects assigned to you. Parallelly,  improve your knowledge of internal packages and API development until you are confident working with them.

Also, follow the [Sandbox Deployment Guide](deployments/sandbox-deployment-guide.md) to understand how to deploy a project to staging environment. Practice it few times to make sure you can setup a new project and deploy it to sandbox (staging) server within 30 minutes or less.

### 14 Days Evaluation

At the end of the second week, you need to fill the 14 days evaluation document received from the HR department and share it with the Tech Lead. Make sure you fill the **Team Member Score** column as well as the **Team Member Comments** column. If you haven't mentioned anything in the **Team Member Comments** column, it could indicate that you have done nothing related to that particular point. Provide enough details to indicate your commitment.


### 28 Days Evaluation

Similar to 14 days evaluation above. Happen after 28 days from your start date.


### Monthly training

Every month Team Lead communicates a list of training materials for you to study within that month. Also, there will be some training sessions to cover the provided training materials. There is a test based on the month's training materials at the last week of the month. Start studying the training materials as soon as you receive them. That will help you prepare yourself for the test and score more marks. The average of the monthly test marks will go to the quarterly evaluations.
