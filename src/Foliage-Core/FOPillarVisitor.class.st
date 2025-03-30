Class {
	#name : 'FOPillarVisitor',
	#superclass : 'PRVisitor',
	#category : 'Foliage-Core-Pillar',
	#package : 'Foliage-Core',
	#tag : 'Pillar'
}

{ #category : 'visiting' }
FOPillarVisitor >> visit: anObject [
	^ anObject accept: self
]
