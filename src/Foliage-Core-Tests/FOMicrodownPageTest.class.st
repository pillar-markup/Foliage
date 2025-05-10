"
Here we test that the reader is reading well md files and produces a Mic document.
This is this model that will take over the old one. 

For now the only distinction between md converted in pillar and md are: md2 extension and different metadata.

"
Class {
	#name : 'FOMicrodownPageTest',
	#superclass : 'TestCase',
	#instVars : [
		'root'
	],
	#category : 'Foliage-Core-Tests-Model',
	#package : 'Foliage-Core-Tests',
	#tag : 'Model'
}

{ #category : 'running' }
FOMicrodownPageTest >> setUp [

	root := FileSystem memory root.
	(root / 'community.md')
		ensureCreateFile;
		writeStreamDo: [ :s | s << 
'{ "title" : "Community",
"layout" : "default",
"publishDate" : "2021-11-04"
}

# Community & help

## Discord team

We hang out on Discord \(Invitation at [https://discord.gg/QewZMZa](https://discord.gg/QewZMZa)\), where we discuss everything for Pharo users and developers.

You can get an instant invite following this [link](https://discord.gg/QewZMZa).
'].
	
	
]

{ #category : 'running' }
FOMicrodownPageTest >> testGetAMicrodownPageWithAMicrodownTree [

	| aPage |
	aPage := (FOMicrodownV2Reader file: root / 'community.md') createModelEntity.
	self assert: aPage class equals: FOMicrodownPage.
	self assert: (aPage meta atKey: 'layout') equals: 'default'.
	self assert: (aPage meta atKey: 'publishDate') equals: '2021-11-04'.
	self assert: aPage document class equals: MicRootBlock 
]

{ #category : 'running' }
FOMicrodownPageTest >> testPublicationDate [

	| aPage |
	aPage := (FOMicrodownV2Reader file: root / 'community.md') createModelEntity.
	self assert: aPage publicationDate equals: (Date readFrom: '2021-11-04' pattern: 'yyyy-mm-dd').

]

{ #category : 'running' }
FOMicrodownPageTest >> testRenderOnWithMicrodownV2 [

	| aPage |
	aPage := (FOMicrodownV2Reader file: root / 'community.md') createModelEntity.

	self
		assert: (String streamContents: [ :s | aPage renderOn: s ]) equals: '
<h1>Community & help</h1>
<h2>Discord team</h2>
We hang out on Discord (Invitation at <a target="_blank" href="https://discord.gg/QewZMZa"><a target="_blank" href="https://discord.gg/QewZMZa">https://discord.gg/QewZMZa</a></a>), where we discuss everything for Pharo users and developers.
You can get an instant invite following this <a target="_blank" href="https://discord.gg/QewZMZa">link</a>.'
		
]
