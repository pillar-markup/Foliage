"
I represent a Citezen publication in Microdown world. 
"
Class {
	#name : 'MicPublication',
	#superclass : 'MicElement',
	#instVars : [
		'pub'
	],
	#category : 'Foliage-Bib-MicrodownExtensions',
	#package : 'Foliage-Bib',
	#tag : 'MicrodownExtensions'
}

{ #category : 'visiting' }
MicPublication >> accept: aVisitor [

	aVisitor visitPublication: self
]

{ #category : 'accessing' }
MicPublication >> key [

	^ pub key
]

{ #category : 'printing' }
MicPublication >> printOn: aStream [

	aStream nextPutAll: self key asString
]

{ #category : 'accessing' }
MicPublication >> pub [ 
	^ pub
]

{ #category : 'accessing' }
MicPublication >> pub: aCZEntry [ 
	pub := aCZEntry
]
