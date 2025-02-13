Class {
	#name : 'FOVisitorDifferPageTest',
	#superclass : 'TestCase',
	#instVars : [
		'root'
	],
	#category : 'Foliage-Core-Tests-Model',
	#package : 'Foliage-Core-Tests',
	#tag : 'Model'
}

{ #category : 'tests' }
FOVisitorDifferPageTest >> setUp [

	root := FileSystem memory root.
	(root / 'community.md')
		ensureCreateFile;
		writeStreamDo: [ :s | s <<
'
# Community & help

## Discord team

We hang out on Discord \(Invitation at [https://discord.gg/QewZMZa](https://discord.gg/QewZMZa)\), where we discuss everything for Pharo users and developers.

You can get an instant invite following this [link](https://discord.gg/QewZMZa).
'].
	
	
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testRenderOn [

	| aPillarPage aMicrodownPage |
	aPillarPage := (FOMicrodownReader file: root / 'community.md')  createModelEntity.
	aMicrodownPage := (FOMicrodownV2Reader file: root / 'community.md') createModelEntity.

	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: (String streamContents: [ :s | aPillarPage renderOn: s ])
		
]
