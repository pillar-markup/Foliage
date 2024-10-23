Class {
	#name : 'FOAbstractReader',
	#superclass : 'Object',
	#instVars : [
		'file',
		'stream'
	],
	#category : 'Foliage-Core-Reader',
	#package : 'Foliage-Core',
	#tag : 'Reader'
}

{ #category : 'accessing' }
FOAbstractReader class >> file: aFileReference [
	^ self new file: aFileReference 
]

{ #category : 'accessing' }
FOAbstractReader class >> forFileExtension: aString [ 
	^ (self allSubclasses reject: [:each | each isAbstract])
		detect: [ :each | each matchesFileExtension: aString ]
		ifNone: [  nil ]
]

{ #category : 'testing' }
FOAbstractReader class >> matchesFileExtension: aString [ 
	^ self supportedFileExtensions includes: aString
]

{ #category : 'accessing' }
FOAbstractReader >> file: aFileReference [ 
	file := aFileReference 
]

{ #category : 'accessing' }
FOAbstractReader >> stream [ 
	^ stream ifNil: [ 
		stream := file readStream ]
]
