"
This context supports the use of variables such as title, body, publication date...
The layout determines the page level template to be used. 

The body is produced by rendering the page contents with the default HTML visitor. 
In the future this visitor should be a templated one. 
"
Class {
	#name : 'FOMicrodownPageRenderContext',
	#superclass : 'FORenderContext',
	#instVars : [
		'page'
	],
	#category : 'Foliage-Core-Base',
	#package : 'Foliage-Core',
	#tag : 'Base'
}

{ #category : 'accessing' }
FOMicrodownPageRenderContext >> body [
	"{{{body}}} is used in template to represent the body of the page."
	
	^ String streamContents: [ :s |
			page bodyOn: s ].
]

{ #category : 'accessing' }
FOMicrodownPageRenderContext >> layout [
	"Returns the template ID used to template the page."
	
	^ self page layout
]

{ #category : 'accessing' }
FOMicrodownPageRenderContext >> page [

	^ page
]

{ #category : 'accessing' }
FOMicrodownPageRenderContext >> page: anObject [

	page := anObject
]

{ #category : 'accessing' }
FOMicrodownPageRenderContext >> publicationDate [

	^ page publishDate
]

{ #category : 'accessing' }
FOMicrodownPageRenderContext >> site [
	
	^ website
]

{ #category : 'accessing' }
FOMicrodownPageRenderContext >> title [

	^ self page title
]

{ #category : 'accessing' }
FOMicrodownPageRenderContext >> webRootPrefix [
	
	^ website webRootPrefix
]
