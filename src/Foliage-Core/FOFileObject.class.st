"
I'm a simple file resources, in the same spirit as the webimages. I will be just copy 
to the target by the publisher. 
"
Class {
	#name : 'FOFileObject',
	#superclass : 'FOFileBasedWebEntity',
	#category : 'Foliage-Core-Model',
	#package : 'Foliage-Core',
	#tag : 'Model'
}

{ #category : 'testing' }
FOFileObject class >> supportedFileExtensions [ 
	^ #( css js )
]

{ #category : 'visiting' }
FOFileObject >> acceptFOVisitor: aFOVisitor [ 
	^ aFOVisitor visitFileObject: self 
]
