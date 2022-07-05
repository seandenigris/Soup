Soup is a simple HTML scraping library, ported from Python's [Beautiful Soup](http://www.crummy.com/software/BeautifulSoup/).
Initial versions by Zulq Alam.

Copied from http://smalltalkhub.com/#!/~PharoExtras/Soup on 7/28/2016

[![Example Usage](http://img.youtube.com/vi/y17pTysVddg/0.jpg)](http://www.youtube.com/watch?v=y17pTysVddg "Example Usage")

## Install

```Smalltalk
Metacello new
	baseline: 'Soup';
	repository: 'github://Ducasse/Soup';
	load
 ```
## If you want to depend on it

Add the following code to your Metacello baseline or configuration

```
spec 
   baseline: 'Soup' 
   with: [ spec repository: 'github://Ducasse/Soup/' ]
```
