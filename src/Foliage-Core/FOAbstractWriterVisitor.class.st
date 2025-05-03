Class {
	#name : 'FOAbstractWriterVisitor',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'post',
		'stream',
		'upperLimit',
		'amountOfCharacters'
	],
	#category : 'Foliage-Core-MicrodownVisitor',
	#package : 'Foliage-Core',
	#tag : 'MicrodownVisitor'
}

{ #category : 'accessing' }
FOAbstractWriterVisitor >> amountOfCharacters: aNumber [ 
	upperLimit := aNumber.
	amountOfCharacters := 0.
]

{ #category : 'accessing' }
FOAbstractWriterVisitor >> post: anObject [ 
	
	post := anObject.
	stream := String new writeStream.
	self visit: anObject document copy.
	^ stream contents
]

{ #category : 'accessing' }
FOAbstractWriterVisitor >> visit: anObject [
	(amountOfCharacters >= upperLimit) 
		ifFalse: [ anObject accept: self ]
]

{ #category : 'accessing' }
FOAbstractWriterVisitor >> visitFigure: anObject [
	"ignore figures in the abstract"
	^ self 
]

{ #category : 'accessing' }
FOAbstractWriterVisitor >> visitHeader: aMicHeaderBlock [
	"skip header since we do not want to copy the header text into the abstract"
	^ self
]

{ #category : 'accessing' }
FOAbstractWriterVisitor >> visitText: aMicParagraph [

	| text textSize | 
	textSize := aMicParagraph text size.
	text := (amountOfCharacters + textSize >= upperLimit) 
		ifTrue: [ aMicParagraph text truncateWithElipsisTo: (10 max: (upperLimit - amountOfCharacters)) ]
		ifFalse: [ aMicParagraph text ].
	stream << text.	
	amountOfCharacters := amountOfCharacters + aMicParagraph text size.
]
