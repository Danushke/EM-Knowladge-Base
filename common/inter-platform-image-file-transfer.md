# Inter Platform Image File Sharing

## Problems

Various image formats and sizes cause a lot of issues when sent between iOS, Android, Web and Tablets. Often we only look at size (height and width), but this is not enough to prevent errors. We must have a set of libraries that all images go through before they're sent to another platform. These libraries should handle common issues such as, height, width, proper ratios, file size, image format, excessive memory use, thumbnails, cleaning up the temporary cache, error detection, orientation, embedded Geo data etc.

Upload cancellations should be attempted until the initial upload is in progress. After an upload is successfully completed, the server tries to resize, create thumbnails and send push notifications. An upload cancellation request should not be sent (and will be ignored) after the data is sent to the server.

## Image formatting on mobile device

## Uploading images from mobile to server

## Retrieving images from server
