"
I'm a file reader for css
"
Class {
	#name : 'FOFileReader',
	#superclass : 'FORawReader',
	#category : 'Foliage-Core-Reader',
	#package : 'Foliage-Core',
	#tag : 'Reader'
}

{ #category : 'testing' }
FOFileReader class >> supportedFileExtensions [ 
	^ #( css js ico )
]

{ #category : 'accessing' }
FOFileReader >> model [ 
	^ FOFileObject new 
		sourcePath: file asPath
]
