Class {
	#name : 'FoliageTodo',
	#superclass : 'Object',
	#category : 'Foliage-Core-Todo',
	#package : 'Foliage-Core',
	#tag : 'Todo'
}

{ #category : 'list of todos' }
FoliageTodo >> m002Done [

	' I want to get a FOPillarPage from 
		File @ /Users/ducasse/Test2/pharo-website/site/license.md
		using (aFOMicrodownReader file: file) model (ParserAndGenerateModelEntity) '
		
	+ 
	
	' We should do that for each of the kind of extensions because adfter we will do one for md2'
]

{ #category : 'list of todos' }
FoliageTodo >> m003Done [

	'Define a test case for each entity of the model
	calling directly the reader.
	
	see FOPillarPageTest FOMicrodownPageTest
	
	'
]

{ #category : 'list of todos' }
FoliageTodo >> m004 [

	' Revisit the test of the importer 
	
	in particular
	
	importer readFile: root / ''gsoc.md''.
	"I do not get why we have this path but why not for now. "
	self assert: ( web root / ''..'' / ''..'' / ''..'' / ''..''/ ''..''/ ''..''/ ''..''/ ''gsoc.md'') class equals: FOPillarPage
	
	'
]

{ #category : 'list of todos' }
FoliageTodo >> m005 [

	' Write some tests for the HTML generation of PR just to make sure it works.
	
	'
]

{ #category : 'list of todos' }
FoliageTodo >> m006 [

	' Write some tests for the HTML generation of Microdown.
	We should take the same file as input and make sure we will get the same as the HTML counter part.
	'
]

{ #category : 'list of todos' }
FoliageTodo >> m007 [

	'-write a test for blog configuration 
a file -> a blog post	'
]

{ #category : 'list of todos' }
FoliageTodo >> m008 [

	'-Add test to check that the abstract of a blog post is ok
	check ref to MicRawBlock '
]

{ #category : 'list of todos' }
FoliageTodo >> m010 [

	'Rewrite the Pillar truncate visitor in Microdown. 
	Now it is unclear what is the difference to FOPillarPage>>abstract and FOBlogPage>>abstract?
	and buildSummary
	
	
	
	
	
	
	
	
	
	
	'
]
