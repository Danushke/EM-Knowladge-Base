## Picture, Vedio and Audio Selector

   ![](../assets/images/picture_selector.gif)

Download Sample APK from [here](../assets/apks/PictureSelector_2.0.0.apk)

### Permisions

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.CAMERA" />
```

### File provider shared file path

Add `res/xml/image_picker_provider_paths.xml` to root project

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <paths>
        <external-path
            name="camera_photos"
            path="" />
        <root-path
            name="camera_photos"
            path="" />
    </paths>
</resources>
```

### Functional configuration

```java
PictureSelector.create(MainActivity.this)
    .openGallery()//All.PictureMimeType.ofAll(), Picture.ofImage(), Video.ofVideo(), Audio.ofAudio()
    .theme() // theme style (not set to default style) See also demo values/styles for example: R.style.picture.white.style
    .maxSelectNum()// Maximum number of pictures selected int
    .minSelectNum()// Minimum number of choices int
    .imageSpanCount(4)// number of displays per line int
    .selectionMode()// Multiple Select or Single Select PictureConfig.MULTIPLE or PictureConfig.SINGLE
    .previewImage()// Is it possible to preview the image true or false
    .previewVideo()// Whether to preview the video true or false
    .enablePreviewAudio() // Whether the audio can be played true or false
    .isCamera()// Whether to display the photo button true or false
    .imageFormat(PictureMimeType.PNG)// Photo save image format suffix, default jpeg
    .isZoomAnim(true)// Picture list click Zoom effect Default true
    .sizeMultiplier(0.5f)// glide Load image size between 0~1 If .glideOverride() is invalid
    .setOutputCameraPath("/CustomPath")// Custom photo save path, no need to fill
    .enableCrop()// Whether to crop true or false
    .compress()// Whether to compress true or false
    .glideOverride()// int glide Load width and height, the smaller the picture list, the smoother it will affect the clarity of the list image browsing
    .withAspectRatio()// int Crop ratio such as 16:9 3:2 3:4 1:1 Customizable
    .hideBottomControls()// Whether to display the uCrop toolbar, it does not display true or false by default.
    .isGif()// Whether to display gif image true or false
    .compressSavePath(getPath())//Compressed image save address
    .freeStyleCropEnabled()// Whether the crop box can be dragged and dropped true or false
    .circleDimmedLayer()// Whether circular cropping true or false
    .showCropFrame()// Whether to display the crop rectangle border It is recommended to set it to false true or false when round cropping
    .showCropGrid()// Whether to display a cropped rectangle grid It is recommended to set to false true or false for circular cropping
    .openClickSound()// Whether to enable the click sound true or false
    .selectionMedia()// Whether to pass the selected image List<LocalMedia> list
    .previewEggs()// When previewing an image, whether to enhance the left and right sliding image experience (half the image to see if the previous one is selected) true or false
    .cropCompressQuality()// Crop compression quality Default 90 int
    .minimumCompressSize(100)// Images smaller than 100kb are not compressed
    .synOrAsy(true)//sync true or asynchronous false compression default sync
    .cropWH()// Crop the aspect ratio, if the setting is greater than the width and height of the image itself, invalid int
    .rotateEnabled() // Trimming whether to rotate the image true or false
    .scaleEnabled()// Trimming whether to zoom in or out the picture true or false
    .videoQuality()// Video Recording Quality 0 or 1 int
    .videoMaxSecond(15)// Display how many seconds of video or audio is also available int
    .videoMinSecond(10)// Display how many seconds of video or audio is also available int
    .recordVideoSecond()//Video seconds recording Default 60s int
    .isDragFrame(false)// Whether to drag the crop box (fixed)
    .forResult(PictureConfig.CHOOSE_REQUEST);//Result callback onActivityResult code
```

!!! note ""
    It is recommended to add the following code to the activity that the fragment depends on
```java
if (savedInstanceState == null) {
    fragment = new PhotoFragment();
    getSupportFragmentManager().beginTransaction()
    .add(R.id.tab_content, fragment,
        PictureConfig.FC_TAG).show(fragment)
        .commit();
} else {
    fragment = (PhotoFragment) getSupportFragmentManager()
        .findFragmentByTag(PictureConfig.FC_TAG);
}
```

### Result Callback

```java
@Override
    Protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        If (resultCode == RESULT_OK) {
            Switch (requestCode) {
                Case PictureConfig.CHOOSE_REQUEST:
                    // Image, video, audio selection result callback
                    List<LocalMedia> selectList = PictureSelector.obtainMultipleResult(data);
                    // For example, LocalMedia returns three paths
                    // 1.media.getPath(); is the original path
                    // 2.media.getCutPath(); is the path after cropping, you need to determine whether media.isCut(); is true. Note: except for audio and video
                    // 3.media.getCompressPath(); is the compressed path, you need to determine whether media.isCompressed(); is true. Note: except for audio and video
                    // If the crop and compression, take the compression path as the first, because it is first compressed and then compressed

                    // TODO selectList

                    brreak;
            }
        }
    }
```

### Clear Cache

```java
PictureFileUtils.deleteCacheDirFile(MainActivity.this);
```
