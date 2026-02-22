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
	"{{{body}}} is used in template to represent the body of the page"
	
	^ String streamContents: [ :s |
			page renderOn: s ].
]

{ #category : 'accessing' }
FOMicrodownPageRenderContext >> layout [

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
FOMicrodownPageRenderContext >> title [

	^ self page title
]

{ #category : 'accessing' }
FOMicrodownPageRenderContext >> webRootPrefix [
	
	^ website webRootPrefix
]
