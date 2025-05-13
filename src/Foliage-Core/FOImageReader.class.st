"
gif jpg jpeg png to corresponding FOImage object
"
Class {
	#name : 'FOImageReader',
	#superclass : 'FOAbstractReader',
	#category : 'Foliage-Core-Reader',
	#package : 'Foliage-Core',
	#tag : 'Reader'
}

{ #category : 'testing' }
FOImageReader class >> supportedFileExtensions [ 
	^ #( gif jpg jpeg png ) 
]

{ #category : 'accessing' }
FOImageReader >> createModelEntity [ 

	^ FOWebImage new 
		sourcePath: file asPath ; yourself
]
