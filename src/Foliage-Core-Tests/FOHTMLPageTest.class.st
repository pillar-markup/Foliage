Class {
	#name : 'FOHTMLPageTest',
	#superclass : 'TestCase',
	#instVars : [
		'root'
	],
	#category : 'Foliage-Core-Tests-Model',
	#package : 'Foliage-Core-Tests',
	#tag : 'Model'
}

{ #category : 'running' }
FOHTMLPageTest >> setUp [

	root := FileSystem memory root.
	(root / 'community.html')
		ensureCreateFile;
		writeStreamDo: [ :s | s << 
'This should be HTML contents now we do not parse it so ... '].
	
	
]

{ #category : 'running' }
FOHTMLPageTest >> testGetAFileObject [

	| aPage |
	aPage := (FOHTMLReader file: root / 'community.html') createModelEntity.
	self assert: aPage class equals: FOHTMLPage.
	self assert: aPage sourcePath basename equals: 'community.html'
]
