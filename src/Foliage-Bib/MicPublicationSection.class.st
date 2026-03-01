"
I represent a list of publications with a title. I will be part of the document tree of a publication page. 
My items are MicPublication instances. 
"
Class {
	#name : 'MicPublicationSection',
	#superclass : 'AnObsoleteMicElement',
	#instVars : [
		'title',
		'items'
	],
	#category : 'Foliage-Bib-MicrodownExtensions',
	#package : 'Foliage-Bib',
	#tag : 'MicrodownExtensions'
}

{ #category : 'visiting' }
MicPublicationSection >> accept: aVisitor [

	aVisitor visitPublicationSection: self
]

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
	aStream nextPutAll: '(', title,  ' - '.
	items do: [ :s | s printOn: aStream ] separatedBy: [ aStream nextPutAll: ', ' ].
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
