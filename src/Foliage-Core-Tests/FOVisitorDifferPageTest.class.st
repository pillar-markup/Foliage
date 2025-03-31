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

{ #category : 'running' }
FOVisitorDifferPageTest >> createAllMDElementTestFiles [

	self createMDTitlesTestFile.
	self createMDCodeTestFile.
	self createMDLinkTestFile.
	self createMDFigureTestFile.
	self createMDListTestFile.
	self createMDListOrderedTestFile.
	self createMDListUnorderedTestFile.
	self createMDTextStyles
]

{ #category : 'running' }
FOVisitorDifferPageTest >> createMDCodeTestFile [

	(root / 'test-code.md')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << '
Here is some code 
```language=Pharo&caption=Beautiful&anchor=Fig1
   1000 factorial / 999 factorial
```
' ]
]

{ #category : 'running' }
FOVisitorDifferPageTest >> createMDFigureTestFile [

	(root / 'test-figure.md')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << '
Here is a figure: ![Pharologo](https://files.pharo.org/media/logo/logo.png size=80&anchor=figLogo.)
' ]
]

{ #category : 'running' }
FOVisitorDifferPageTest >> createMDLinkTestFile [

	(root / 'test-link.md')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << '
[Pharo](http://pharo.org).
' ]
]

{ #category : 'running' }
FOVisitorDifferPageTest >> createMDListOrderedTestFile [

	(root / 'test-list-ordered.md')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << '
Here is a list:
1. item 1
2. item 2
3. item 3
' ]
]

{ #category : 'running' }
FOVisitorDifferPageTest >> createMDListTestFile [

	(root / 'test-list.md')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << '
Here is a list:
- item 1
  1. sub item 1 
  3. sub item 2
- item 2
' ]
]

{ #category : 'running' }
FOVisitorDifferPageTest >> createMDListUnorderedTestFile [

	(root / 'test-list-unordered.md')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << '
Here is a list:
- item 1
- item 2
- item 3
' ]
]

{ #category : 'running' }
FOVisitorDifferPageTest >> createMDTextBoldTestFile [

	(root / 'test-text-bold.md')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << '
**Bold**
' ]
]

{ #category : 'running' }
FOVisitorDifferPageTest >> createMDTextItalicTestFile [

	(root / 'test-text-italic.md')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << '
_italic_
' ]
]

{ #category : 'running' }
FOVisitorDifferPageTest >> createMDTextMonospaceTestFile [

	(root / 'test-text-monospace.md')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << '
`monospace`
' ]
]

{ #category : 'running' }
FOVisitorDifferPageTest >> createMDTextStyles [

	self createMDTextBoldTestFile.
	self createMDTextItalicTestFile.
	self createMDTextMonospaceTestFile.
]

{ #category : 'running' }
FOVisitorDifferPageTest >> createMDTitlesTestFile [

	(root / 'test-titles.md')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << '
#Microdown is quite cool
##Microdown is quite coool x2
###Microdown is quite cooool x3
' ]
]

{ #category : 'running' }
FOVisitorDifferPageTest >> setUp [

	root := FileSystem memory root.
	(root / 'community.md')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << '
# Community & help

## Discord team

We hang out on Discord \(Invitation at [https://discord.gg/QewZMZa](https://discord.gg/QewZMZa)\), where we discuss everything for Pharo users and developers.

You can get an instant invite following this [link](https://discord.gg/QewZMZa).
' ].

	self createAllMDElementTestFiles.
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testBold [

	| aPillarPage aMicrodownPage |
	aPillarPage := (FOMicrodownReader file: root / 'test-text-bold.md') createModelEntity.
	aMicrodownPage := (FOMicrodownV2Reader file: root / 'test-text-bold.md') createModelEntity.

	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: (String streamContents: [ :s | aPillarPage renderOn: s ])
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testCode [

	| aPillarPage aMicrodownPage |
	aPillarPage := (FOMicrodownReader file: root / 'test-code.md') createModelEntity.
	aMicrodownPage := (FOMicrodownV2Reader file: root / 'test-code.md') createModelEntity.

	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: (String streamContents: [ :s | aPillarPage renderOn: s ])
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testFigure [

	| aPillarPage aMicrodownPage |
		self skip.
	aPillarPage := (FOMicrodownReader file: root / 'test-figure.md')
		               createModelEntity.
	aMicrodownPage := (FOMicrodownV2Reader file: root / 'test-figure.md')
		                  createModelEntity.

	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: (String streamContents: [ :s | aPillarPage renderOn: s ])
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testItalic [

	| aPillarPage aMicrodownPage |
	aPillarPage := (FOMicrodownReader file: root / 'test-text-italic.md') createModelEntity.
	aMicrodownPage := (FOMicrodownV2Reader file: root / 'test-text-italic.md') createModelEntity.

	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: (String streamContents: [ :s | aPillarPage renderOn: s ])
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testLink [

	| aPillarPage aMicrodownPage |
		self skip.
	aPillarPage := (FOMicrodownReader file: root / 'test-link.md') createModelEntity.
	aMicrodownPage := (FOMicrodownV2Reader file: root / 'test-link.md') createModelEntity.

	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: (String streamContents: [ :s | aPillarPage renderOn: s ])
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testList [

	| aPillarPage aMicrodownPage |
	aPillarPage := (FOMicrodownReader file: root / 'test-list.md') createModelEntity.
	aMicrodownPage := (FOMicrodownV2Reader file: root / 'test-list.md') createModelEntity.

	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: (String streamContents: [ :s | aPillarPage renderOn: s ])

]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testMonospace [

	| aPillarPage aMicrodownPage |
	aPillarPage := (FOMicrodownReader file: root / 'test-text-monospace.md') createModelEntity.
	aMicrodownPage := (FOMicrodownV2Reader file: root / 'test-text-monospace.md') createModelEntity.

	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: (String streamContents: [ :s | aPillarPage renderOn: s ])

]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testOrderedList [

	| aPillarPage aMicrodownPage |
	aPillarPage := (FOMicrodownReader file: root / 'test-list-ordered.md') createModelEntity.
	aMicrodownPage := (FOMicrodownV2Reader file: root / 'test-list-ordered.md') createModelEntity.

	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: (String streamContents: [ :s | aPillarPage renderOn: s ])

]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testRenderOn [

	| aPillarPage aMicrodownPage |
	self skip.
	aPillarPage := (FOMicrodownReader file: root / 'community.md') createModelEntity.
	aMicrodownPage := (FOMicrodownV2Reader file: root / 'community.md') createModelEntity.

	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: (String streamContents: [ :s | aPillarPage renderOn: s ])

]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testTitles [

	| aPillarPage aMicrodownPage |
	aPillarPage := (FOMicrodownReader file: root / 'test-titles.md') createModelEntity.
	aMicrodownPage := (FOMicrodownV2Reader file: root / 'test-titles.md') createModelEntity.

	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: (String streamContents: [ :s | aPillarPage renderOn: s ])

]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testUnorderedList [

	| aPillarPage aMicrodownPage |
	aPillarPage := (FOMicrodownReader file: root / 'test-list-unordered.md') createModelEntity.
	aMicrodownPage := (FOMicrodownV2Reader file: root / 'test-list-unordered.md') createModelEntity.

	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: (String streamContents: [ :s | aPillarPage renderOn: s ])

]
