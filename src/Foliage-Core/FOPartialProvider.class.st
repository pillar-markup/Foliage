Class {
	#name : 'FOPartialProvider',
	#superclass : 'Object',
	#instVars : [
		'layout',
		'website'
	],
	#category : 'Foliage-Core-Base',
	#package : 'Foliage-Core',
	#tag : 'Base'
}

{ #category : 'accessing' }
FOPartialProvider >> at: key [
	^ (website templatePathForLayout: layout partial: key) asMustacheTemplate 
]

{ #category : 'accessing' }
FOPartialProvider >> layout: aString [ 
	layout := aString
]

{ #category : 'accessing' }
FOPartialProvider >> website: aWebsite [ 
	website := aWebsite 
]
