"
I'm a file written in Microdown. 
I usually have metadata and a body.
In addition a page defines one or more layout.
For example a blog post can be rendered as full page or in an abstract version. 
This is done having different templates (and layouts).  


Here is a typical starts of a microdown page. 
```
{
""title"" : ""An Example"",
""publicationDate"" : '2025-06-01"",
""layout"" : ""default""
}

## A title 

and more .... 
```
"
Class {
	#name : 'FOMicrodownPage',
	#superclass : 'FOPageWithMetadata',
	#instVars : [
		'document'
	],
	#category : 'Foliage-Core-Model',
	#package : 'Foliage-Core',
	#tag : 'Model'
}

{ #category : 'testing' }
FOMicrodownPage class >> supportedFileExtensions [
	^ { } 
]

{ #category : 'accessing' }
FOMicrodownPage >> abstract [
	"Perform a basic text abstract just collecting everything and cutting it off the first: n elments."
	
	| abstract |
	abstract := (Character space join: (document children allButFirst collect: [ :each | each text ])).
	^ abstract first: (abstract size min: self abstractAmountOfCharacters)
]

{ #category : 'accessing' }
FOMicrodownPage >> abstractAmountOfCharacters [

	^ 400
]

{ #category : 'visiting' }
FOMicrodownPage >> acceptFOVisitor: aFOVisitor [
	"All microdown written page will pass here and this has as effect that the method renderOn: is invoked on the 
	page (this page can be instance of subclasses of MicrodownPage)."

	^ aFOVisitor visitMicrodownPage: self 
]

{ #category : 'accessing' }
FOMicrodownPage >> document [
	^ document
]

{ #category : 'accessing' }
FOMicrodownPage >> document: aMicRootBlock [ 
	document := aMicRootBlock
]

{ #category : 'accessing' }
FOMicrodownPage >> publicationDate [

	self deprecated: 'use publishDate'  transformWith: '`@rec publicationDate' -> '`@rec publishDate'.
	^ self publishDate
]

{ #category : 'actions' }
FOMicrodownPage >> publish [

	self publishPath
		ensureDelete;
		writeStreamDo: [ :stream | stream << self htmlString ]
]

{ #category : 'accessing' }
FOMicrodownPage >> publishPath [

	^ super publishPath withExtension: 'html'
]

{ #category : 'rendering' }
FOMicrodownPage >> render [ 

	^ self newRenderContext renderTemplate: self template
]

{ #category : 'rendering' }
FOMicrodownPage >> renderOn: aStream [

	| visitor |
	visitor := MicHTMLVisitor new
		           stream: aStream;
		           crAsNewLine;
		           yourself.
	visitor visit: document.
	^ visitor contents
]

{ #category : 'accessing' }
FOMicrodownPage >> template [
	"Returns the template for the layout as available in for example .../templates/index or templates/blog"
	
	^ (self website templatePathForLayout: self layout) asMustacheTemplate.
]
