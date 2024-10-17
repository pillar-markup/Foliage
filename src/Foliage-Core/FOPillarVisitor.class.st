Class {
	#name : 'FOPillarVisitor',
	#superclass : 'PRVisitor',
	#category : 'Foliage-Core-Visitor',
	#package : 'Foliage-Core',
	#tag : 'Visitor'
}

{ #category : 'visiting' }
FOPillarVisitor >> visit: anObject [
	^ anObject accept: self
]
