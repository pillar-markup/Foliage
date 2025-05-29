"
Here are some random notes so that I understand something. 


```
FOPublisher commandLine activateWith: {
    'foliage'.
    'publish'.
    '--source'. '/home/esteban/dev/pharo/foliage/test/pharo-test-master/site'.
    '--target'. '/home/esteban/dev/pharo/foliage/test/'.
    '/home/esteban/dev/pharo/foliage/test/pharo-test-master/site/.foliage.ston' }.
```


Download 

```
http://github.com/pharo-project/pharo-website
```

### About templates and loops 

Here is one way to use loops in template

```
<!DOCTYPE HTML>
<html>
<head>
    <meta charset=""UTF-8"" />
    <meta name=""viewport"" content=""width=device-width, initial-scale=1.0"" />
    <link rel=""stylesheet"" type=""text/css"" href=""files/newstef.css"" /> 
    <title>PLAY</title>
</head>
    <body>
	<pr> Play file template
	<pr> Before the foo variable
	{{{foo}}}
	<pr> After foo variable


	{{# list }}
	Number: {{{ number }}} 
	{{/ list }}'.
    </body>
</html>
```
"
Class {
	#name : 'FOWelcome',
	#superclass : 'Object',
	#instVars : [
		'website'
	],
	#category : 'Foliage-Core-Base',
	#package : 'Foliage-Core',
	#tag : 'Base'
}
