Class {
	#name : 'FOHTMLReader',
	#superclass : 'FORawReader',
	#category : 'Foliage-Core-Reader',
	#package : 'Foliage-Core',
	#tag : 'Reader'
}

{ #category : 'testing' }
FOHTMLReader class >> supportedFileExtensions [
	^ #( html )
]

{ #category : 'instance creation' }
FOHTMLReader >> model [
	^ FOHTMLPage new
		sourcePath: file asPath
]
