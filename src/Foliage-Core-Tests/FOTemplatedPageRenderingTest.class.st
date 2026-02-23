Class {
	#name : 'FOTemplatedPageRenderingTest',
	#superclass : 'FOAbstractWebSiteTest',
	#category : 'Foliage-Core-Tests-Rendering',
	#package : 'Foliage-Core-Tests',
	#tag : 'Rendering'
}

{ #category : 'running' }
FOTemplatedPageRenderingTest >> defineFiles [ 
	
	super defineFiles. 
	fileSystem / 'site' / 'templates' / 'main' writeStreamDo: [ :st |
		st nextPutAll: self mainTemplateContents ].
	fileSystem / 'site' / 'usingMainTemplate.md' writeStreamDo: [ :st |
		st nextPutAll: self someContentsMDUsingMainTemplate ].
	
	fileSystem / 'site' / 'templates' / 'templateExtendedVariables' writeStreamDo: [ :st |
		st nextPutAll: self mainTemplateContents ].
	fileSystem / 'site' / 'usingExtendedVariables.md' writeStreamDo: [ :st |
		st nextPutAll: self someContentsMDUsingMainTemplate ].
	
]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> mainTemplateContents [

	^ 'BODYSTART
{{{body}}}
BODYEND'
]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> someContentsMDUsingMainTemplate [

	^ '{
"title" : "Google Summer of Code",
"layout" : "main",
"publishDate" : "2019-05-21"
}

# Google Summer of Code 2019 Students

Yes Pharo has been selected for GSOC
'
]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> testFileExistsAndGetsImported [ 

	self assert: (fileSystem / 'site' / 'usingMainTemplate.md') exists.
	self 
		assert: (site / 'usingMainTemplate.md') class 
		equals: FOMicrodownPage 

]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> testTemplatedContents [
	
	self 
		assert: ( site / 'usingMainTemplate.md') templatedContents
		equals:  'BODYSTART

<h1>Google Summer of Code 2019 Students</h1>
<p>Yes Pharo has been selected for GSOC</p>

BODYEND'
		
]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> testTemplatedContentsWithExtendedVariables [
	
	self 
		assert: ( site / 'usingExtendedVariables.md') templatedContents
		equals:  'BODYSTART

<h1>Google Summer of Code 2019 Students</h1>
<p>Yes Pharo has been selected for GSOC</p>

BODYEND'
		
]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> usingExtendedVariables [

	^ 'BODYSTART
{{{body}}}
site.baseUri:
{{site.baseUri}}
BODYEND'
]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> withExtendedVariables [

	^ 'BODYSTART
{{{body}}}
site.baseUri:
{{site.baseUri}}
BODYEND'
]
