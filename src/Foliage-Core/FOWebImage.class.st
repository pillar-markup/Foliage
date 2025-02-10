"
I represent image resources that do not require any treatment and that the publisher will just copy around. 
"
Class {
	#name : 'FOWebImage',
	#superclass : 'FOFileBasedWebEntity',
	#category : 'Foliage-Core-Model',
	#package : 'Foliage-Core',
	#tag : 'Model'
}

{ #category : 'testing' }
FOWebImage class >> supportedFileExtensions [ 
	^ #( gif jpg jpeg png ico  ) 
]

{ #category : 'visiting' }
FOWebImage >> acceptFOVisitor: aFOVisitor [ 
	^ aFOVisitor visitWebImage: self  
]
