# Foliage

Foliage is a static HTML web page renderer. 
It takes some markdown and produces HTML.

Each page can have a different layout and template can be used to share
elements with the pages. 

It offers
- Blog and posts
- Automatic publication generation 
- A simple plugin architecture

## Sample


If you are looking for example. You can have a look at 

- https//www.github.com/Pillar-markup/FoliageSample. It is simple example of a little but not trivial web site with automatic publication list generation. 

- https://www.github.com/stephaneducasse.github.io

Notice that while Foliage 2.0 can generate the full Pharo web site, it is not yet used. 
The Pharo official website https://www.pharo.org is still using an old version of Foliage.
Don't use it (or at your own risk) :)



## File structure

A site has a basic structure

- The folder `files` contains all the CSS and related files
- The folder `templates` contains the template fragment
- At the top level you get index.md and friends such as bibfiles

At the time being the file `Foliage.ston` is mandatory even if you do not declare blogs.


## Files

Here is a typical file. Here we see the main index.md.
A file must have metadata with the title, a layout (corresponding to a template) and a publidate.
More metadata are possible as shown in the subsection chapter in the automatic publication plugin.

```
{
"title" : "Tintin",
"layout": "index",
"publishDate": "2021-02-01"
}

## Current responsibilities

I'm a journalist. I joined several international expeditions with my smart dog Milou. 

## Some Adventures

- L'Oreille cassée
- L'ile Noire
- Le Sceptre d'Ottokar
- Le Crabe aux pinces d'or
```

### Templates

Templates use Mustache partials. Here is the index template where `{{{body}}}` is a variable representing the markdown code of the page using the template and `{{> head }}` is a template partial inclusion. 

```
<!DOCTYPE HTML>
<html>
	{{> head }}
	<body>
	
	{{> headerSite }}
	{{> menu }}

	<div id="mainContent">
		
	{{> persoDetails}}

	{{{body}}}
	
	{{> footer }}
	
	</div>
	
	</body>
	
</html>
```


## Blogs

The file Foliage.ston describes blogs.
The following sample defines two blogs: given their directory and their rendered names. 

```
Foliage {
	#baseUri: 'http://stephaneducasse.github.io',
	#blogs: [ 
		'news': 'News', 
		'topics': 'Some topics' 
	]
}
```
