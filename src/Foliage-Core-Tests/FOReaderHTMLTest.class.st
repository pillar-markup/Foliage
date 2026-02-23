Class {
	#name : 'FOReaderHTMLTest',
	#superclass : 'TestCase',
	#instVars : [
		'root'
	],
	#category : 'Foliage-Core-Tests-Reader',
	#package : 'Foliage-Core-Tests',
	#tag : 'Reader'
}

{ #category : 'running' }
FOReaderHTMLTest >> setUp [

	root := FileSystem memory root.
	(root / 'community.html')
		ensureCreateFile;
		writeStreamDo: [ :s | s << 
'This should be HTML contents now we do not parse it so ... '].
	
	
]

{ #category : 'running' }
FOReaderHTMLTest >> testGetAFileObject [

	| aPage |
	aPage := (FOHTMLReader file: root / 'community.html') createModelEntity.
	self assert: aPage class equals: FOHTMLPage.
	self assert: aPage sourcePath basename equals: 'community.html'
]
