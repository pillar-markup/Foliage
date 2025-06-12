Class {
	#name : 'FOFullPublicationPage',
	#superclass : 'FOMicrodownPage',
	#instVars : [
		'sections'
	],
	#category : 'Foliage-Bib-Core',
	#package : 'Foliage-Bib',
	#tag : 'Core'
}

{ #category : 'visiting' }
FOFullPublicationPage >> acceptFOVisitor: aVisitor [
	"remotely inoke renderOn:"
	
	^ aVisitor visitMicrodownPage: self
]

{ #category : 'instance creation' }
FOFullPublicationPage >> renderContextClass [

	^ FOBlogRenderContext
]

{ #category : 'visiting' }
FOFullPublicationPage >> renderOn: aStream [

	| visitor |
	super renderOn: aStream.
	"another ugly I cannot access the superclass visitor... "
	visitor := MicHTMLVisitor new
		           stream: aStream;
		           crAsNewLine;
		           yourself.
	sections do: [ :s | visitor visit: s ] .
	"This does not work because sections are not Mic but FO objects. I have to think about it."
	^ visitor contents
]

{ #category : 'accessing' }
FOFullPublicationPage >> sections [

	^ sections
]

{ #category : 'accessing' }
FOFullPublicationPage >> sections: anObject [

	sections := anObject
]
