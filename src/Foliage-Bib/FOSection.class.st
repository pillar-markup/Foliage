"
I'm a bib section in a document. I have one title and a list of items.
"
Class {
	#name : 'FOSection',
	#superclass : 'Object',
	#instVars : [
		'title',
		'items'
	],
	#category : 'Foliage-Bib',
	#package : 'Foliage-Bib'
}

{ #category : 'accessing' }
FOSection >> items [

	^ items
]

{ #category : 'accessing' }
FOSection >> items: anObject [

	items := anObject
]

{ #category : 'printing' }
FOSection >> printOn: aStream [

	super printOn: aStream. 
	aStream nextPutAll: '(', title,  '-'.
	items entries do: [ :s | aStream nextPutAll: s key ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ')' 
]

{ #category : 'accessing' }
FOSection >> title [

	^ title
]

{ #category : 'accessing' }
FOSection >> title: anObject [

	title := anObject
]
