"
.html file to FOHTMLPage object
"
Class {
	#name : 'FOHTMLReader',
	#superclass : 'FOAbstractReader',
	#category : 'Foliage-Core-Reader',
	#package : 'Foliage-Core',
	#tag : 'Reader'
}

{ #category : 'testing' }
FOHTMLReader class >> supportedFileExtensions [
	^ #( html )
]

{ #category : 'instance creation' }
FOHTMLReader >> createModelEntity [

	^ FOHTMLPage new sourcePath: file asPath; yourself
]
