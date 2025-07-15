"
I represent a list of publications with a title. 
"
Class {
	#name : 'MicPublicationSection',
	#superclass : 'MicElement',
	#instVars : [
		'title',
		'items'
	],
	#category : 'Foliage-Bib-Core',
	#package : 'Foliage-Bib',
	#tag : 'Core'
}

{ #category : 'accessing' }
MicPublicationSection >> items [

	^ items
]

{ #category : 'accessing' }
MicPublicationSection >> items: anObject [

	items := anObject
]

{ #category : 'printing' }
MicPublicationSection >> printOn: aStream [

	super printOn: aStream. 
	aStream nextPutAll: '(', title,  '-'.
	items entries do: [ :s | aStream nextPutAll: s key ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ')' 
]

{ #category : 'accessing' }
MicPublicationSection >> title [

	^ title
]

{ #category : 'accessing' }
MicPublicationSection >> title: anObject [

	title := anObject
]
