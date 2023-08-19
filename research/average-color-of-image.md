# Get average color,the closest color and gray scale of an image 

## Introduction
 Identify the bellow parameters of the given image
 
   * Average color of the given image
   * Matching color of the color palette for the average color
   * Gray percentage of the image



## Affected Projects

* Hair Color App - Once user upload an image of the hair, it should identify the average color of the hair, matching color form given
                   hair color palette and gray hair percentage.

## Problem 1

Identify average color of the image & matching color from the color palette. 

### Solution

Library found for return average color of a given image 

Src: https://www.the-art-of-web.com/php/extract-image-color/

Note : Library modified to accept all image type 

Function found to get the closest color from given color palette

Src: https://www.geeksforgeeks.org/php-imagecolorclosest-function/#:~:text=The%20imagecolorclosest()%20function%20is,to%20the%20specified%20RGB%20value.

Note : Function modified to pass one color and get the closest color from the palette.

	/**
	* Get closest color from the color palette for the given RGB value
	* @param 	Integer 	$r 	Red value integer
	* @param 	Integer 	$g 	Green value integer
	* @param 	Integer 	$b 	Blue value integer
	*/
	public function nearestColor($r,$g,$b)
	{
	    // Start with an image and convert it to a palette-based image
	    $im = imagecreatefrompng('pallete.png');
	    imagetruecolortopalette($im, false, 255);

	    $result = imagecolorclosest($im, $r, $g, $b);
	    $result = imagecolorsforindex($im, $result);
	    
	    $rgb_arr['red'] 	= $result['red'];
	    $rgb_arr['green'] 	= $result['green'];
	    $rgb_arr['blue'] 	= $result['blue'];
	    imagedestroy($im);
	    return $rgb_arr;
		
	}

### Support Content
* https://www.the-art-of-web.com/php/extract-image-color/
* https://www.geeksforgeeks.org/php-imagecolorclosest-function/#:~:text=The%20imagecolorclosest()%20function%20is,to%20the%20specified%20RGB%20value.



### Issues



## Problem 2

Identify Gray hair scale


### Solution

* Convert image to black and white
https://www.sitepoint.com/community/t/convert-to-black-and-white-not-grayscale-with-gd-library/3793
* Get Color Percentage 
http://www.coolphptools.com/color_extract#demo

### Support Content
* https://www.sitepoint.com/community/t/convert-to-black-and-white-not-grayscale-with-gd-library/3793
* http://www.coolphptools.com/color_extract#demo
### Issues

* If the image contain shine, it'll take as white pixel

## Conclusion

Accuracy will differ if the image contain any shine area.(See the test results) 

Test results

https://docs.google.com/document/d/1uxyHuCy5Zyih9gpK6WeDzSUf8HRz6i814cJa6HWM-h8/edit?usp=sharing


## References

* https://www.php.net/manual/en/function.imagecolorclosest.php
* https://www.php.net/manual/en/ref.image.php

 