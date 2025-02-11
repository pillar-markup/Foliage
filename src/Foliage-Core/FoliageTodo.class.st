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
FoliageTodo >> m003 [

	'Define a test case for each entity of the model
	calling directly the reader.
	
	see FOPillarPageTest FOMicrodownPageTest
	
	'
]
