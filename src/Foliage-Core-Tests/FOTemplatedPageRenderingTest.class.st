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
	fileSystem / 'site' / 'templates' / 'mainTemplate' writeStreamDo: [ :st |
		st nextPutAll: self mainTemplateContents ].
	fileSystem / 'site' / 'mainTemplateUser.md' writeStreamDo: [ :st |
		st nextPutAll: self mainTemplateUserContents ].
	
	fileSystem / 'site' / 'templates' / 'templateVariable' writeStreamDo: [ :st |
		st nextPutAll: self templateVariableContents ].
	fileSystem / 'site' / 'templateVariableUser.md' writeStreamDo: [ :st |
		st nextPutAll: self templateVariableUserContents ].
	
]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> mainTemplateContents [

	^ 'BODYSTART
{{{body}}}
BODYEND'
]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> mainTemplateUserContents [

	^ '{
"title" : "Google Summer of Code",
"layout" : "mainTemplate",
"publishDate" : "2019-05-21"
}

# Google Summer of Code 2019 Students

Yes Pharo has been selected for GSOC
'
]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> templateVariableContents [

	^ 'BODYSTART
{{{body}}}
site.baseUri:
{{site.baseUri}}
BODYEND'
]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> templateVariableUserContents [

	^ '{
"title" : "Google Summer of Code",
"layout" : "templateVariable",
"publishDate" : "2019-05-21"
}

# Google Summer of Code 2019 Students

Yes Pharo has been selected for GSOC
'
]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> testFileExistsAndGetsImported [ 

	self assert: (fileSystem / 'site' / 'mainTemplateUser.md') exists.
	self 
		assert: (site / 'mainTemplateUser.md') class 
		equals: FOMicrodownPage 

]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> testTemplatedContents [
	
	self 
		assert: ( site / 'mainTemplateUser.md') templatedContents
		equals:  'BODYSTART

<h1>Google Summer of Code 2019 Students</h1>
<p>Yes Pharo has been selected for GSOC</p>

BODYEND'
		
]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> testTemplatedContentsWithExtendedVariables [
	
	self 
		assert: ( site / 'templateVariableUser.md') templatedContents 
		equals:  'BODYSTART

<h1>Google Summer of Code 2019 Students</h1>
<p>Yes Pharo has been selected for GSOC</p>

site.baseUri:
http://esug.org
BODYEND'


		
]
