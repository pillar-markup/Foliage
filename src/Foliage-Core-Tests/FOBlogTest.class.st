Class {
	#name : 'FOBlogTest',
	#superclass : 'TestCase',
	#instVars : [
		'root',
		'blog',
		'site'
	],
	#category : 'Foliage-Core-Tests-Blog',
	#package : 'Foliage-Core-Tests',
	#tag : 'Blog'
}

{ #category : 'data' }
FOBlogTest >> blogPostAbstractContents [

	^ 'blog-post-abstract                                                [15:53:12]
<h2><a href="{{pathString}}">{{title}}</a></h2>
{{abstract}}
<div class="date">{{{publicationDate}}}</div>'
]

{ #category : 'data' }
FOBlogTest >> gsocContentsMD [

	^ '{
"title" : "Google Summer of Code",
"layout" : "default",
"publishDate" : "2019-05-21"
}

# Google Summer of Code 2019 Students


On this page, you can find the personal blogs and social media links of the seven students accepted for Google Summer of Code with Pharo Consortium in 2019. Follow their pages to get regular updates on their progress. Don''t hesitate to get in touch with those students - they need your feedback.

## Atharva Khare

- [Personal blog](https://khare.dev/posts/)
- [Twitter](https://twitter.com/code_alchemist)
- [GitHub](https://github.com/AtharvaKhare)


## Dayne Lorena Guerra Calle

- [Personal blog](https://medium.com/@daynestorm)
- [Twitter](https://twitter.com/DayneStorm_)
- [Facebook](https://www.facebook.com/Day.nelo)
- [GitHub](https://github.com/GDayne)


## Evelyn Cusi Lopez

- [Personal blog](https://medium.com/@cusi.evelyn)
- [Twitter](https://twitter.com/Evelyn81435990)
- [Facebook](https://www.facebook.com/evelyn.cusilopez)
- [GitHub](https://github.com/Lin777)


## Myroslava Romaniuk

- [Personal blog](https://medium.com/@myroslavarm)
- [Twitter](https://twitter.com/myroslavarm)
- [GitHub](https://github.com/myroslavarm)


## Nikhil Pinnaparaju

- [Personal blog](https://medium.com/@nikhilpinnaparaju)
- [Twitter](https://twitter.com/NPinnaparaju)
- [Facebook](https://www.facebook.com/nikhil.pinnaparaju.1)
- [GitHub](https://github.com/nikhilpinnaparaju)


## Nina Medic

- [Personal blog](https://pharokeepers.github.io/)
- [Twitter](https://twitter.com/medicka992)
- [GitHub](https://github.com/medicka)


## Smiljana Knezev

- [Personal blog](https://pharokeepers.github.io/)
- [Twitter](https://twitter.com/KnezevSmiljana)
- [GitHub](https://github.com/SmiljanaKnezev)
'
]

{ #category : 'data' }
FOBlogTest >> gsocContentsMD2 [

	^ '{
"title" : "IsLoop",
"layout" : "default",
"publishDate" : "2025-05-21"
}

# IsLoop summer school


We are organizing a summer school on Pharo and advanced design every year. 
The previous editions were held at Split, Montpelllier and Fianarantsoa. 


'
]

{ #category : 'data' }
FOBlogTest >> mdOneFileName [
	self flag: #todo.
	"to rename when we remove md for pillar and keep md (eg. md2 -> md)"
	^ 'gsoc.md2'
]

{ #category : 'data' }
FOBlogTest >> mdOneFileName2 [
	self flag: #todo. 
	"to rename when we remove md for pillar and keep md (eg. md2 -> md)"
	^ 'gsoc2.md2'
]

{ #category : 'running' }
FOBlogTest >> setUp [ 

		root := FileSystem memory root.
		(root / 'success') ensureCreateDirectory.
		root / 'success' / self mdOneFileName
			writeStreamDo: [ :st | st nextPutAll: self gsocContentsMD ].
		root / 'success' / self mdOneFileName2
			writeStreamDo: [ :st | st nextPutAll: self gsocContentsMD2 ].
		(root / 'templates' ) ensureCreateDirectory.
		
		root / 'templates' / 'blog-post-abstract'
			writeStreamDo: [ :st | st nextPutAll: self blogPostAbstractContents ].
			
		site := FOWebSite new.
		site templatePath: (root / 'templates' ).
		site importDirectory: root.
]
