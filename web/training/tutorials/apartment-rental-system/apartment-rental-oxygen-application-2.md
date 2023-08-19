Develop An Apartment Rental Application With Oxygen - Part 2
===================================================

This is the second part of the **Apartment Rental Application (ARA)** tutorial. Please refer to the first part using the link below.

- [Develop An Apartment Rental Application With Oxygen - Part 1](../apartment-rental-oxygen-application-1.md)

The **Apartment Rental Application (ARA)** consists of two parts:

1. The admin panel
2. API

The development of the admin panel functions were discussed in the first part of this tutorial. We will discuss the API development aspects of **Oxygen** in this part.


## Oxygen API

**Oxygen** utilizes an associate package called [emedia/api](https://bitbucket.org/elegantmedia/laravel-api-helpers/src/master/) to generate documentation for the API. You don't need to install this package as it is a dependency of **Oxygen** itself. In case you need to install, the directions can be found in the `README.MD` file of the package.

Please read the following guide carefully to understand how to start **Oxygen** API development with `emedia/api` package.

[API Development Guide](../../api/api-development-guide.md)


**Exercise 1**: Develop an API endpoint for retrieving apartments. API endpoint should support searching apartments by name and filtering by city. Document it properly.

**Exercise 2**: Develop an API endpoint for creating inquiry requests. Document it properly including all details.


## API Testing

There are multiple ways you can test your APIs. At EM, we use two main methods to test the APIs. Please refer to the guide below to learn them.

[API Testing Guide](https://bitbucket.org/elegantmedia/em-knowledge-base/src/master/web/training/api/api-testing.md)

**Exercise 3**: Write test cases for the APIs you developed in **Exercise 1** and **Exercise 2**.
