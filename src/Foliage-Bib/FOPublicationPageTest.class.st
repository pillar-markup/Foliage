Class {
	#name : 'FOPublicationPageTest',
	#superclass : 'FOAbstractWebSiteTest',
	#category : 'Foliage-Bib-Tests',
	#package : 'Foliage-Bib',
	#tag : 'Tests'
}

{ #category : 'publications' }
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
		#authorMatchingString : ''Ducasse'',
		#keysOfBlackListedEntries : [ ],
		#bibFilename : ''rmod.bib'' ] ],
"publishDate" : "2019-05-21"
}

Welcome to my publication list page.


'
]

{ #category : 'publications' }
FOPublicationPageTest >> publicationPageName [

	^ 'publications.md'
]

{ #category : 'tests - declaration' }
FOPublicationPageTest >> testPluginDeclaration [

	| fileWithPlugin |
	self halt.
	fileWithPlugin := site / self publicationPageName.
	self assert: fileWithPlugin hasPlugin.
	self assert: fileWithPlugin pluginKind equals: 'publicationList'.
	self assert: fileWithPlugin pluginSpec class equals: Dictionary.
	self
		assert: (fileWithPlugin pluginSpec at: #authorMatchingString)
		equals: 'Ducasse'.
	self
		assert: (fileWithPlugin pluginSpec at: #bibFilename)
		equals: 'rmod.bib'
]

{ #category : 'tests - declaration' }
FOPublicationPageTest >> testPluginHandler [

	| fileWithPlugin handler sections |
	fileWithPlugin := site / self publicationPageName.
	handler := site
		           pluginHandle: fileWithPlugin plugin
		           for: fileWithPlugin.
	sections := handler builder sections.
	self assert: sections size equals: 4.
	self
		assert: sections first title
		equals: 'Refereed Articles in International Journals'.
	self assert: sections first items size equals: 2.
	self assert: sections first items first key equals: #Saren24a
]
