"
Here we test that the reader is reading well md files and produces a PR document.
At the end we will get rid of the PR document. 

For now the only distinction between md converted in pillar and md are: md2 extension and different metadata.

"
Class {
	#name : 'FOPillarPageTest',
	#superclass : 'TestCase',
	#instVars : [
		'root'
	],
	#category : 'Foliage-Core-Tests-Model',
	#package : 'Foliage-Core-Tests',
	#tag : 'Model'
}

{ #category : 'tests' }
FOPillarPageTest >> setUp [

	root := FileSystem memory root.
	(root / 'community.md')
		ensureCreateFile;
		writeStreamDo: [ :s | s << 'title: Community
layout: default
publishDate: 2021-11-04

# Community & help



## Discord team

We hang out on Discord \(Invitation at [https://discord.gg/QewZMZa](https://discord.gg/QewZMZa)\), where we discuss everything for Pharo users and developers.

You can get an instant invite following this [link](https://discord.gg/QewZMZa).
'].
	
	
]

{ #category : 'tests' }
FOPillarPageTest >> testGetAPageWithAPRDocument [

	| aPage |
	aPage := (FOMicrodownReader file: root / 'community.md') createModelEntity.
	self assert: aPage class equals: FOPillarPage.
	self assert: (aPage meta at: 'layout') equals: 'default'.
	self assert: (aPage meta at: 'publishDate') equals: '2021-11-04'.
	self assert: aPage document class equals: PRDocument
]
