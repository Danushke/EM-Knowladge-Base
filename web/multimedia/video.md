# Video

## Hosting
Following is a list of video hosting services which can be integrated with websites.

- [Vimeo](https://vimeo.com)
    - Supports [uploading videos](https://developer.vimeo.com/api/upload/videos) with pause, resume support, form uploads and fetching from remote URL.
    - Supports [tus](https://tus.io/) protocol for pause, resume upload support.
        - [JS SDK](https://github.com/tus/tus-js-client)
        - [Android SDK](https://github.com/tus/tus-android-client)
        - [iOS SDK](https://github.com/tus/TUSKit)
    

## Streaming
- [Facebook Live Streaming](https://www.facebook.com/help/587160588142067)
    - Supports `rmtps` only. Hardware or streaming software should support this.
    - Video needs to be public.
    - Can be [embedded on any website](https://developers.facebook.com/docs/plugins/embedded-video-player/#example) with Facebook Video Player
- [Vimeo](https://vimeo.com)
    - Needs a [Premium account](https://vimeo.com/upgrade) for live streaming
    - Supports private videos to be embedded on websites
    - Supports auto archiving (save as live streaming)
