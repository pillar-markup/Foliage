"
I represent resources with a path.
"
Class {
	#name : 'FOFileBasedWebEntity',
	#superclass : 'FOWebResource',
	#instVars : [
		'sourcePath'
	],
	#category : 'Foliage-Core-Model',
	#package : 'Foliage-Core',
	#tag : 'Model'
}

{ #category : 'testing' }
FOFileBasedWebEntity class >> isAbstract [ 
	^ self == FOFileBasedWebEntity
]

{ #category : 'converting' }
FOFileBasedWebEntity >> emitSlots [

	^ super emitSlots, #(sourcePath)
]

{ #category : 'accessing' }
FOFileBasedWebEntity >> name [
	^ parent nameOf: self
]

{ #category : 'accessing' }
FOFileBasedWebEntity >> sourcePath [
	^ sourcePath
]

{ #category : 'accessing' }
FOFileBasedWebEntity >> sourcePath: anObject [
	sourcePath := anObject
]
