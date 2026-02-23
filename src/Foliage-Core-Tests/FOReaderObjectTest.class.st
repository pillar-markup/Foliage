Class {
	#name : 'FOReaderObjectTest',
	#superclass : 'TestCase',
	#instVars : [
		'root'
	],
	#category : 'Foliage-Core-Tests-Reader',
	#package : 'Foliage-Core-Tests',
	#tag : 'Reader'
}

{ #category : 'running' }
FOReaderObjectTest >> setUp [

	root := FileSystem memory root.
	(root / 'community.css')
		ensureCreateFile;
		writeStreamDo: [ :s | s << 
'This should be CCS contents now we do not parse it so ... '].
	
	
]

{ #category : 'running' }
FOReaderObjectTest >> testGetAFileObject [

	| aPage |
	aPage := (FOFileReader file: root / 'community.css') createModelEntity.
	self assert: aPage class equals: FOFileObject.
	self assert: aPage sourcePath basename equals: 'community.css'
]
