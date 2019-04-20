This document is a Markdown quick reference. It is by no means a comprehensive tutorial on Markdown, but rather just some of the most common Markdown tags to serve as a reminder. 

You can view this using one of the Markdown preview tools, just be aware somethings won't work quite right, such as the Image and YouTube sections, as they point to items that do not exist. 

In addition the comments section won't show any output in the preview window because, well they're not supposed to! :-)

Comments
Markdown comments can be done in two ways. First is the markdown syntax:

[//]: # (Here is my comment)

You can also give the comment a name/id

[comment]: # (Here is another comment)

The second method is with HTML
<!---
Block HTML comment here
multiline too
Make sure to use three - after the opening as some markdown viewers fail to recognize the html comment without it. 
-->

Embedding blank linkes
To embed a blank line (extra space) in a document, you have to resort to HTML

&nbsp;

Headers
# H1
## H2
### H3
#### H4
##### H5
###### H6

Italics: _word_  (can also use a single *)
Bold: **word**   (can also use a double underscore __)
Strikethru: ~~word~~

Lists
* Unordered list can use asterisks
- Or minuses
+ Or pluses

Images
You can embed images in one of two ways. The first uses pure markdown, but doesn't allow you to resize the image. (Note the image file names are case sensitive).

![Image Name](Images/myimage.jpg)

If you need to resize the image, you can use the HTML IMG tag.

<img src="Images/myimage.jpg" width=320 height=240 alt="my image goes here">


Links
You can just paste in URL in which case markdown will make it a link

This will display the text in brackets, but link to the URL in parens
[Inline link](http://arcanecode.me)

This will do the same but add a title
[Inline link](http://arcanecode.me "Arcane's Page")

Can also have relative links
[Link to another file](../path/theotherfile.html)

Code
Inline code is surrounded with single backticks
Here the variable `$myVar` is used to do fun things.

Code blocks use three backticks. To enable syntax highlighting put the language name after the last backtick on the first line.
```powershell
$path = '/home/documents/'
Get-ChildItem $path
```

Tables
Use vertical bars to divide columns. Colons can be used to align columns.

| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

Note there must be at least three dashes for each header cell. Also, the opening and closing vertical bar are optional, but look much nicer. 

Block Quotes
Blaock quotes can be used to emulate a side note or what you might see in email. It produces the text in a light font (by default dark gray) on a colored background (default is a light gray). Use > to create a block quote.

> Some text to block quote
> Here's the **second** line

You can also embed markdown inside the block quote, as the above example shows with the word second bolded. 

HTML
You can embed HTML inside markdown, and for the most part it renders well.


Horizontal rule
You can add a horizontal rule in one of three ways. Use three Hyphens, Asterisks, or Underscores
---
***
___

YouTube Videos

They can't be added directly but you can add an image with a link to the video like this:

<a href="http://www.youtube.com/watch?feature=player_embedded&v=YOUTUBE_VIDEO_ID_HERE
" target="_blank"><img src="http://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>

Or, in pure Markdown, but losing the image sizing and border:

[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg)](http://www.youtube.com/watch?v=YOUTUBE_VIDEO_ID_HERE)
