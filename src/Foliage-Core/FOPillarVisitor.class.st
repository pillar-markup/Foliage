Class {
	#name : 'FOPillarVisitor',
	#superclass : 'PRVisitor',
	#instVars : [
		'post'
	],
	#category : 'Foliage-Core-Pillar',
	#package : 'Foliage-Core',
	#tag : 'Pillar'
}

{ #category : 'visiting' }
FOPillarVisitor >> visit: anObject [
	^ anObject accept: self
]
