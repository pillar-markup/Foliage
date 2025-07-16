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

{ #category : 'as yet unclassified' }
MicPublication >> citePub: aCZEntry [ 
	pub := aCZEntry
]
