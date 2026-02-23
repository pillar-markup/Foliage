Class {
	#name : 'FOReaderWebImageTest',
	#superclass : 'TestCase',
	#instVars : [
		'root'
	],
	#category : 'Foliage-Core-Tests-Reader',
	#package : 'Foliage-Core-Tests',
	#tag : 'Reader'
}

{ #category : 'running' }
FOReaderWebImageTest >> setUp [

	root := FileSystem memory root.
	(root / 'community.png')
		ensureCreateFile;
		writeStreamDo: [ :s | s << 
'This should be binary png '].
	
	
]

{ #category : 'running' }
FOReaderWebImageTest >> testGetAnImage [

	| aPage |
	aPage := (FOImageReader file: root / 'community.png') createModelEntity.
	self assert: aPage class equals: FOWebImage.
	self assert: aPage sourcePath basename equals: 'community.png'
]
