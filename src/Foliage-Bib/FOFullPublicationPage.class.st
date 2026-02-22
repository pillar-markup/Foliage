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

{ #category : 'instance creation' }
FOFullPublicationPage class >> new [ 

	self halt
]

{ #category : 'visiting' }
FOFullPublicationPage >> acceptFOVisitor: aVisitor [
	"remotely invoke renderOn:"
	
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

	"for now we do not use templates but it would make sense to provide a template so 
	section and for citation this way the user could customise it.
	It is unclear to me how I can inject the template.
	So make it work first."
	
	visitor := MicHTMLVisitor new
		           stream: aStream;
		           crAsNewLine;
		           yourself.
	sections do: [ :s | visitor visit: s ] .
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
