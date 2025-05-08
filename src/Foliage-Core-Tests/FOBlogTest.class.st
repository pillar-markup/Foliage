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
FOBlogTest >> gsocContentsMD [

	^ '{"title" : "Google Summer of Code",
"layout" : "default",
"publishDate" : "2019-05-21"}

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

	^ '{"title" : "IsLoop",
"layout" : "default",
"publishDate" : "2025-05-21"}

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
	
		super setUp.
		root := FileSystem memory root.
		(root / 'success') ensureCreateDirectory.
		root / 'success' / self mdOneFileName
			writeStreamDo: [ :st | st nextPutAll: self gsocContentsMD ].
		root / 'success' / self mdOneFileName2
			writeStreamDo: [ :st | st nextPutAll: self gsocContentsMD2 ].
		site := FOWebSite new.
		site importDirectory: root.
		
		"we sbould be able to write
		blog := site convertToBlog: 'success' "

		blog := (site / 'success') convertToBlog.
		"	blog at: #'index.html' put: blog overviewPage."
	
]

{ #category : 'failing tests' }
FOBlogTest >> testBlogAfterOverviewBuildingNowContainsIndex [ 

	site buildOverviewFor: 'success'.
	self assert: blog items size equals: 3.
	self assert: (blog items at: #'index.html') class equals: FOMicrodownBlogPage 
	
]

{ #category : 'running' }
FOBlogTest >> testBlogBeforeOverviewBuildingOnlyContainsChildren [ 

	self assert: blog items size equals: 2.
	blog items keys do: [ :each | self assert: (#( 'gsoc.md2' 'gsoc2.md2') includes: each) ].
	self assert: blog publishedPosts size equals: 2.
]

{ #category : 'failing tests' }
FOBlogTest >> testBlogGeneration [

	| p |
	self halt. 
	"we should call the publisher!"
	p := FOPublisher new. 
	p baseUri: 'http://pharo.org'.
	p targetPath: root / 'generated'.
	
	self assert: blog items size equals: 3.
	self assert: (blog items at: #'index.html') class equals: FOMicrodownBlogPage.
	
	
]

{ #category : 'running' }
FOBlogTest >> testBlogIsNowInFileModel [
	
	self assert: (site / 'success') equals: blog.
	self assert: (site / 'success') class equals: FOBlog
]

{ #category : 'failing tests' }
FOBlogTest >> testBlogOverviewHasAbstracts [

	| summaryPageObject |
	summaryPageObject := blog items at: #'index.html'.
	self assert: summaryPageObject document children size equals: 2
	
]

{ #category : 'failing tests' }
FOBlogTest >> testBlogOverviewRender [

	| summaryPageObject |
	self skip. 
	"we should has template in the fileSystem too."
	
	summaryPageObject := blog items at: #'index.html'.
	self halt.
	self assert: summaryPageObject html
	
]
