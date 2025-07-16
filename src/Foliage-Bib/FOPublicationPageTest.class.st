Class {
	#name : 'FOPublicationPageTest',
	#superclass : 'FOAbstractWebSiteTest',
	#category : 'Foliage-Bib-Tests',
	#package : 'Foliage-Bib',
	#tag : 'Tests'
}

{ #category : 'running' }
FOPublicationPageTest >> defineFiles [

	super defineFiles.
	root / self publicationPageName
			writeStreamDo: [ :st | st nextPutAll: self publicationPage ].
	root / 'rmod.bib' 
		writeStreamDo: [ :st | st nextPutAll: FOPublicationListBuilderTest new contents ].
	
]

{ #category : 'publications' }
FOPublicationPageTest >> publicationPage [

	^ '{
"title" : "Stef publication",
"layout" : "default",
"plugin" : [ 
	"kind" : "publicationList",
	"pluginSpec" : [ 
		#authorMatchingString : ''*Ducasse*'',
		#keysOfBlackListedEntries : [ ],
		#filename : ''rmod.bib'' ] ],
"publishDate" : "2019-05-21"
}

Welcome to my publication list page.


'
]

{ #category : 'publications' }
FOPublicationPageTest >> publicationPageName [

	^ 'publications.md'
]

{ #category : 'running' }
FOPublicationPageTest >> testBuildPublicationPage [

	| builder |
	self halt.
	"here we are just computing the list of publications. 
	And so far we are not generating a page.
	The renderOn: method is not invoked."
	
	site rawPath: root.
	builder := site buildPublicationPage: self publicationPageName.
	self assert: builder sections isNotEmpty.
	
	self halt.
	
]

{ #category : 'running' }
FOPublicationPageTest >> testHandlePlugins [ 

	site handlePlugins
	self halt. 
	"this is the next place to work"
]

{ #category : 'running' }
FOPublicationPageTest >> testPlugin [

	| fileWithPlugin |
	site rawPath: root.
	fileWithPlugin := (site / self publicationPageName).
	self assert: fileWithPlugin hasPlugin.
	self assert: fileWithPlugin pluginKind equals: 'publicationList'.
	self assert: fileWithPlugin pluginSpec class equals: Dictionary.
	self assert: (fileWithPlugin pluginSpec  at: #authorMatchingString) equals: '*Ducasse*'.
	
]
