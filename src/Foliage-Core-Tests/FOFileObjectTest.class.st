Class {
	#name : 'FOFileObjectTest',
	#superclass : 'TestCase',
	#instVars : [
		'root'
	],
	#category : 'Foliage-Core-Tests-Model',
	#package : 'Foliage-Core-Tests',
	#tag : 'Model'
}

{ #category : 'running' }
FOFileObjectTest >> setUp [

	root := FileSystem memory root.
	(root / 'community.css')
		ensureCreateFile;
		writeStreamDo: [ :s | s << 
'This should be CCS contents now we do not parse it so ... '].
	
	
]

{ #category : 'running' }
FOFileObjectTest >> testGetAFileObject [

	| aPage |
	aPage := (FOFileReader file: root / 'community.css') createModelEntity.
	self assert: aPage class equals: FOFileObject.
	self assert: aPage sourcePath basename equals: 'community.css'
]
