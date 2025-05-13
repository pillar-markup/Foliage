"
I'm the root of a little hierarchy of reader objects. 
Their job is to convert a file into a domain object (e.g., an image, an html or a microdown page object)
"
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
FOAbstractReader >> createModelEntity [
	"Each of my subclass should return an adequate object of the site metamodel."
	
	^ self subclassResponsibility 
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
