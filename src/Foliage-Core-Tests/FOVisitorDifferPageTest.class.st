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

{ #category : 'as yet unclassified' }
FOVisitorDifferPageTest >> lineEnding [

	^ Character cr asString
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

We hang out on Discord (Invitation at [https://discord.gg/QewZMZa](https://discord.gg/QewZMZa)), where we discuss everything for Pharo users and developers.

You can get an instant invite following this [link](https://discord.gg/QewZMZa).
' ].

	self createAllMDElementTestFiles.
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testBold [

	self
		assert: (String streamContents: [ :s |
					 (FOMicrodownV2Reader file: root / 'test-text-bold.md')
						 createModelEntity renderOn: s ])
		equals: self lineEnding , '<strong>Bold</strong>'
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testCode [

	self
		assert: (String streamContents: [ :s |
					 (FOMicrodownV2Reader file: root / 'test-code.md')
						 createModelEntity renderOn: s ])
		equals:
			self lineEnding , 'Here is some code' , self lineEnding
			, '<pre><code>   1000 factorial / 999 factorial</code></pre>'
			, self lineEnding
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testFigure [

	| aMicrodownPage |
	aMicrodownPage := (FOMicrodownV2Reader file: root / 'test-figure.md')
		                  createModelEntity.
	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: self lineEnding
			,
			'Here is a figure: <figure><img src="/media/logo/logo.png" alt="Pharologo"><figcaption>Pharologo</figcaption></img></figure>'
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testItalic [

	self
		assert: (String streamContents: [ :s |
					 (FOMicrodownV2Reader file: root / 'test-text-italic.md')
						 createModelEntity renderOn: s ])
		equals: self lineEnding , '<i>italic</i>'
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testLink [

	self
		assert: (String streamContents: [ :s |
					 (FOMicrodownV2Reader file: root / 'test-link.md')
						 createModelEntity renderOn: s ])
		equals: self lineEnding
			, '<a target="_blank" href="http://pharo.org/">Pharo</a>.'
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testList [

	self
		assert: (String streamContents: [ :s |
					 (FOMicrodownV2Reader file: root / 'test-list.md')
						 createModelEntity renderOn: s ])
		equals: self lineEnding , 'Here is a list:' , self lineEnding , '<ul>' , self lineEnding , '<li>item 1' , self lineEnding , '<ol>' , self lineEnding , '<li>sub item 1</li>'
			, self lineEnding
			, '<li>sub item 2</li>' , self lineEnding , '</ol></li>' , self lineEnding , '<li>item 2</li>' , self lineEnding , '</ul>'
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testMonospace [

	self
		assert: (String streamContents: [ :s |
					 (FOMicrodownV2Reader file: root / 'test-text-monospace.md')
						 createModelEntity renderOn: s ])
		equals: self lineEnding , '<code>monospace</code>'
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testOrderedList [

	self
		assert: (String streamContents: [ :s |
					 (FOMicrodownV2Reader file: root / 'test-list-ordered.md')
						 createModelEntity renderOn: s ])
		equals: self lineEnding , 'Here is a list:' , self lineEnding , '<ol>' , self lineEnding , '<li>item 1</li>' , self lineEnding , '<li>item 2</li>' , self lineEnding , '<li>item 3</li>' , self lineEnding , '</ol>'
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testRenderOn [

	self
		assert: (String streamContents: [ :s |
					 (FOMicrodownV2Reader file: root / 'community.md')
						 createModelEntity renderOn: s ])
		equals:
			self lineEnding , '<h1>Community & help</h1>'
			, self lineEnding
			, '<h2>Discord team</h2>' , self lineEnding
			,
			'We hang out on Discord (Invitation at <a target="_blank" href="https://discord.gg/QewZMZa"><a target="_blank" href="https://discord.gg/QewZMZa">https://discord.gg/QewZMZa</a></a>), where we discuss everything for Pharo users and developers.'
			, self lineEnding
			,
			'You can get an instant invite following this <a target="_blank" href="https://discord.gg/QewZMZa">link</a>.'
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testTitles [

	self
		assert: (String streamContents: [ :s |
					 (FOMicrodownV2Reader file: root / 'test-titles.md')
						 createModelEntity renderOn: s ])
		equals: self lineEnding , '<h1>Microdown is quite cool</h1>'
			, self lineEnding
			, '<h2>Microdown is quite coool x2</h2>' , self lineEnding , '<h3>Microdown is quite cooool x3</h3>'
]

{ #category : 'tests' }
FOVisitorDifferPageTest >> testUnorderedList [

	| aMicrodownPage |
	aMicrodownPage := (FOMicrodownV2Reader file:
		                   root / 'test-list-unordered.md')
		                  createModelEntity.

	self
		assert: (String streamContents: [ :s | aMicrodownPage renderOn: s ])
		equals: self lineEnding , 'Here is a list:' , self lineEnding , '<ul>' , self lineEnding , '<li>item 1</li>' , self lineEnding , '<li>item 2</li>' , self lineEnding , '<li>item 3</li>' , self lineEnding , '</ul>'
]
