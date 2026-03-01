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
FOTemplatedPageRenderingTest >> setUp [ 

	super setUp.
	site webRootPrefix: 'Tintin'.
	
]

{ #category : 'running' }
FOTemplatedPageRenderingTest >> templateVariableContents [
	
	"
		The template uses different variables: body, site.baseUri....
		
		The value of the variable body is given by a method defined in the context associated to the microdown page.
		
		site returns the site associated to the page.
		
		site.baseUri and webRootPrefix values are given by methods defined in the site class.
		
		the value for site_short_description is not an existing method but it is a key in the configuration.
	
		site.foo is not existing as message nor as key in the configuration so it is ignored""
	"
	
	
	^ 'BODYSTART
{{{body}}}
site.baseUri: {{site.baseUri}}
site.webRootPrefix: {{site.webRootPrefix}}
{{site.foo}}
site.site_short_description: {{site.site_short_description}}
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
	
	"This test is based on the following assumptions: 
	
		The template uses different variables: body, site.baseUri....
		
		The value of the variable body is given by a method defined in the context associated to the microdown page.
		
		site returns the site associated to the page.
		
		site.baseUri and webRootPrefix values are given by methods defined in the site class.
		
		the value for site_short_description is not an existing method but it is a key in the configuration.
	
		site.foo is not existing as message nor as key in the configuration so it is ignored"
	
	
	self 
		assert: ( site / 'templateVariableUser.md') templatedContents
		equals:  'BODYSTART

<h1>Google Summer of Code 2019 Students</h1>
<p>Yes Pharo has been selected for GSOC</p>

site.baseUri: http://esug.org
site.webRootPrefix: Tintin

site.site_short_description: European Smalltalk User Group
BODYEND'
	

]
