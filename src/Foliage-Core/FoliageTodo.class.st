Class {
	#name : 'FoliageTodo',
	#superclass : 'Object',
	#category : 'Foliage-Core-Todo',
	#package : 'Foliage-Core',
	#tag : 'Todo'
}

{ #category : 'as yet unclassified' }
FoliageTodo >> m002Done [

	' I want to get a FOPillarPage from 
		File @ /Users/ducasse/Test2/pharo-website/site/license.md
		using (aFOMicrodownReader file: file) model (ParserAndGenerateModelEntity) '
		
	+ 
	
	' We should do that for each of the kind of extensions because adfter we will do one for md2'
]

{ #category : 'as yet unclassified' }
FoliageTodo >> m003Done [

	'Define a test case for each entity of the model
	calling directly the reader.
	
	see FOPillarPageTest FOMicrodownPageTest
	
	'
]

{ #category : 'as yet unclassified' }
FoliageTodo >> m004 [

	' Revisit the test of the importer 
	
	in particular
	
	importer readFile: root / ''gsoc.md''.
	"I do not get why we have this path but why not for now. "
	self assert: ( web root / ''..'' / ''..'' / ''..'' / ''..''/ ''..''/ ''..''/ ''..''/ ''gsoc.md'') class equals: FOPillarPage
	
	'
]

{ #category : 'as yet unclassified' }
FoliageTodo >> m005 [

	' Write some tests for the HTML generation of PR just to make sure it works.
	
	'
]

{ #category : 'as yet unclassified' }
FoliageTodo >> m006 [

	' Write some tests for the HTML generation of Microdown.
	We should take the same file as input and make sure we will get the same as the HTML counter part.
	'
]
