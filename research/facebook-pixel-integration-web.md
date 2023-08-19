# Facebook Pixel - Analytics Integration to Web Application/Website

## Affected Projects

[BRIQ](https://briq.com.au) - Bitbucket link: [elegantmedia / pr313-vbl-backend — Bitbucket](https://bitbucket.org/elegantmedia/pr313-vbl-backend/src/master/)

## What/Why Is Facebook Pixel

The Facebook pixel is an analytics tool that allows you to measure the effectiveness of your advertising by understanding the actions people take on your website.

It can use to:

- Make sure that your ads are shown to the right people
- Drive more sales
- Measure the results of your ads.

Once you've set up the Facebook pixel, the pixel will fire when someone takes an action on your website.

Examples of actions include:

- Register new user
- Adding an item to their shopping cart or making a purchase.etc

For read-more: 

- https://www.facebook.com/business/help/742478679120153?id=1205376682832142&helpref=faq_content



## Facebook pixel standard events

[Events](https://www.facebook.com/help/964258670337005) are actions that happen on your website. Standard events are predefined by Facebook and can be used to log conversions, optimise for conversions and build audiences.

Reference and how to use the Facebook pixel's `fbq('track')` function.

- How to use (Clear demonstration): https://www.facebook.com/business/help/402791146561655?id=1205376682832142

- Reference for full standard events: https://developers.facebook.com/docs/facebook-pixel/reference



## Implementation

The Facebook pixel is a snippet of JavaScript code that loads a small library of functions you can use to track Facebook ad-driven visitor activity on your website.

By default, the pixel will track URLs visited, domains visited, and the devices your visitors use.

- For official implementation guide: https://developers.facebook.com/docs/facebook-pixel/implementation

- Beginner instructions: https://www.facebook.com/business/help/952192354843755?id=1205376682832142

**Note**: *As a best practice, you may add manual script inside vendor/oxygen/partials/tracking.blade.php and FACEBOOK_PIXEL_ID may declare in .env.*


## Where you can see results

You can test or view final result of tracking in Facebook Event manager.

1. In events manager: https://business.facebook.com/events_manager