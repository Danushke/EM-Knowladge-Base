# NTLM Authenticated HTTP client configuration using Guzzle-Http Laravel (Microsoft Navision Integration)

## Introduction

When integrating Microsoft Navision ERP (Nav360) with Laravel application, they basically support various authentication types.
Among them are:

* OAuth2 (ONly on Azure Nav360 and later versions)
* Kerberos Authentication (Negotiate/Digest)
* NTLM Authentication (Windows Challenge/Response)

OAuth2 is only available on later versions of Navision but all versions above 2009 supports Kerberos and NTLM authentication.
Although Microsoft Kerberos is the protocol of choice, NTLM is still supported. NTLM must also be used for logon authentication on stand-alone systems.

Here explain how to integrate Navision/Nav360 web services/APIs when NTLM authentication is selected on Navision settings.

## Affected Projects

* NAFDA - NAFDA is well-known foodservice distribution company and they wanted to expand business with a web and mobile application to purchase goods online for consumers and they require to integrate sales data of web and mobile application with their ERP system which is Nav360 (Microsoft Navision). While Nav is supported only kerberos and NTLM auth, it required to config Guzzle Http Client with extra specific settings to allow accessing APIs on Navision.

## Problem 1

Microsoft Navision (Nav) is tweaked to use NTLM auth, it required to config Guzzle Http Client with extra specific settings to allow accessing APIs on Nav.

### Solution

Guzzle Http Client - Tweaked to use cURL handler (When time of writing version is Guzzle 7, which was only supported NTLM auth using cURL handler not with HTTP handler)

```php
<?php
namespace App\Helpers;

use GuzzleHttp\Handler\CurlHandler;
use GuzzleHttp\HandlerStack;
use GuzzleHttp\Client as HttpClient;
use Throwable;

class NavClient
{
    protected $navClient;

    /**
     * Initiate Nav360 http client
     */
    public function __construct()
    {
        $_handler = new CurlHandler();
        $_stack = HandlerStack::create($_handler);
        $_baseUrl = config('services.nav360.base_url');

        $this->navClient = new HttpClient([
            'handler' => $_stack,
            'base_uri' => $_baseUrl
        ]);
    }
    
    /**
     * Get default options
     * 
     * @return Array
     */
    public function getDefaultOptions(): Array
    {
        $_username = config('services.nav360.username');
        $_password = config('services.nav360.password');
        $_authentication = config('services.nav360.authentication');
        $_timeout = config('services.nav360.timeout');

        return [
            'auth' => [$_username, $_password, $_authentication],
            'headers' => ['Accept' => 'application/json'],
            'timeout' => $_timeout
        ];
    }

    /**
     * Make nav client request
     * 
     * @param String  $resource Resource Ex: NAFDAAPIItems
     * @param String  $method   Http method [GET] Ex: GET/POST
     * @param Array   $options  Additional Guzzle http options
     * 
     * @return Psr\Http\Message\ResponseInterface
     * 
     * @throws Throwable
     */
    public function request($resource = "", $method = "GET", $options = [])
    {
        $_uri = $resource;
        $_method = strtoupper($method);
        $_options = array_merge($this->getDefaultOptions(), $options);

        try {
            $_result = $this->navClient->request(
                $_method, 
                $_uri,
                $_options
            );
        } catch (Throwable $th) {
            throw $th;
        }
        
        return $_result;
    }
}
```



### Support Content

- https://docs.guzzlephp.org/en/stable/request-options.html#auth
- https://docs.guzzlephp.org/en/stable/handlers-and-middleware.html#handlers

### Issues

Not found


## Conclusion

For <u>NTLM auth</u> use ***Guzzle Http Client*** with tweaked to use ***cURL handler***

## References

- https://bitbucket.org/elegantmedia/em-knowledge-base/src/master/research/average-color-of-image.md
- https://www.crowdstrike.com/cybersecurity-101/ntlm-windows-new-technology-lan-manager/
- https://blog.mayflower.de/125-Accessing-NTLM-secured-resources-with-PHP.html