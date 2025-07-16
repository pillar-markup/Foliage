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

{ #category : 'accessing' }
MicPublication >> citePub: aCZEntry [ 
	pub := aCZEntry
]

{ #category : 'accessing' }
MicPublication >> key [

	^ pub key
]

{ #category : 'printing' }
MicPublication >> printOn: aStream [

	aStream nextPutAll: self key asString
]
