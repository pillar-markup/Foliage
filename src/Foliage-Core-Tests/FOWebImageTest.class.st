Class {
	#name : 'FOWebImageTest',
	#superclass : 'TestCase',
	#instVars : [
		'root'
	],
	#category : 'Foliage-Core-Tests-Model',
	#package : 'Foliage-Core-Tests',
	#tag : 'Model'
}

{ #category : 'running' }
FOWebImageTest >> setUp [

	root := FileSystem memory root.
	(root / 'community.png')
		ensureCreateFile;
		writeStreamDo: [ :s | s << 
'This should be binary png '].
	
	
]

{ #category : 'running' }
FOWebImageTest >> testGetAnImage [

	| aPage |
	aPage := (FOImageReader file: root / 'community.png') createModelEntity.
	self assert: aPage class equals: FOWebImage.
	self assert: aPage sourcePath basename equals: 'community.png'
]
