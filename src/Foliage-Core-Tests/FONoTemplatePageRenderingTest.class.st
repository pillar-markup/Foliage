"
Here we test that the reader is reading well md files and produces a Mic document.
This is this model that will take over the old one. 

For now the only distinction between md converted in pillar and md are: md2 extension and different metadata.

"
Class {
	#name : 'FONoTemplatePageRenderingTest',
	#superclass : 'TestCase',
	#instVars : [
		'root'
	],
	#category : 'Foliage-Core-Tests-Rendering',
	#package : 'Foliage-Core-Tests',
	#tag : 'Rendering'
}

{ #category : 'running' }
FONoTemplatePageRenderingTest >> community [


^ '{ 
"title" : "Community",
"layout" : "default",
"publishDate" : "2021-11-04"
}

# Community & help

## Discord team

We hang out on Discordwhere.

You can get an instant invite following this [link](https://discord.gg/QewZMZa).
'
]

{ #category : 'running' }
FONoTemplatePageRenderingTest >> gsocContentsMD2 [ 

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

{ #category : 'running' }
FONoTemplatePageRenderingTest >> lineEnding [

	^ Character cr asString
]

{ #category : 'running' }
FONoTemplatePageRenderingTest >> setUp [

	root := FileSystem memory root.
	(root / 'community.md')
		ensureCreateFile;
		writeStreamDo: [ :s | s << self community ].
	(root / 'gsoc.md')
		ensureCreateFile;
		writeStreamDo: [ :s | s << self gsocContentsMD2 ]
	
]

{ #category : 'running' }
FONoTemplatePageRenderingTest >> testAbstractBuilderVisitor [

	| aPage abstract |
	aPage := (FOMicrodownV2Reader file: root / 'community.md') createModelEntity.
	
	abstract := FOAbstractWriterVisitor new
		  amountOfCharacters: 100;
		  post: aPage.
	
	self 
		assert: abstract 
		equals: 'We hang out on Discordwhere.You can get an instant invite following this link.'
]

{ #category : 'running' }
FONoTemplatePageRenderingTest >> testAbstractBuilderVisitorSmallerAbstractThanText [

	| aPage abstract |
	aPage := (FOMicrodownV2Reader file: root / 'community.md') createModelEntity.
	
	abstract := FOAbstractWriterVisitor new
		  amountOfCharacters: 100;
		  post: aPage.
	
	self 
		assert: abstract 
		equals: 'We hang out on Discordwhere.You can get an instant invite following this link.' 
]

{ #category : 'running' }
FONoTemplatePageRenderingTest >> testAbstractBuilderVisitorSmallerTextThanAbstract [

	| aPage abstract |
	aPage := (FOMicrodownV2Reader file: root / 'community.md') createModelEntity.
	
	abstract := FOAbstractWriterVisitor new
		  amountOfCharacters: 400;
		  post: aPage.
	
	self 
		assert: abstract 
		equals: 'We hang out on Discordwhere.You can get an instant invite following this link.'  
]

{ #category : 'running' }
FONoTemplatePageRenderingTest >> testBasicAbstractOnMicrodownPage [

	| aPage |
	aPage := (FOMicrodownV2Reader file: root / 'community.md') createModelEntity.
	self 
		assert: aPage abstract  
		equals: 'Community & help Discord team We hang out on Discordwhere. You can get an instant invite following this [link](https://discord.gg/QewZMZa).'
]

{ #category : 'running' }
FONoTemplatePageRenderingTest >> testGetAMicrodownPageWithAMicrodownTree [

	| aPage |
	aPage := (FOMicrodownV2Reader file: root / 'community.md') createModelEntity.
	self assert: aPage class equals: FOMicrodownPage.
	self assert: (aPage meta atKey: 'layout') equals: 'default'.
	self assert: (aPage meta atKey: 'publishDate') equals: '2021-11-04'.
	self assert: aPage document class equals: MicRootBlock
]

{ #category : 'running' }
FONoTemplatePageRenderingTest >> testPublicationDate [

	| aPage |
	aPage := (FOMicrodownV2Reader file: root / 'community.md')
		         createModelEntity.
	self
		assert: aPage publishDate
		equals: (Date readFrom: '2021-11-04' pattern: 'yyyy-mm-dd')
]

{ #category : 'running' }
FONoTemplatePageRenderingTest >> testRenderOnWithMicrodownV2 [

	self
		assert: (String streamContents: [ :s |
					 (FOMicrodownV2Reader file: root / 'community.md') createModelEntity bodyOn: s ]) equals: '
<h1>Community & help</h1>
<h2>Discord team</h2>
<p>We hang out on Discordwhere.</p>

<p>You can get an instant invite following this <a target="_blank" href="https://discord.gg/QewZMZa">link</a>.</p>
'
	
]
