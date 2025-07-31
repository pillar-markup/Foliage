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
		#authorMatchingString : ''Ducasse'',
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
FOPublicationPageTest >> testPluginDeclaration [

	| fileWithPlugin |
	site rawPath: root.
	fileWithPlugin := (site / self publicationPageName).
	self assert: fileWithPlugin hasPlugin.
	self assert: fileWithPlugin pluginKind equals: 'publicationList'.
	self assert: fileWithPlugin pluginSpec class equals: Dictionary.
	self assert: (fileWithPlugin pluginSpec  at: #authorMatchingString) equals: 'Ducasse'.
	
]

{ #category : 'running' }
FOPublicationPageTest >> testPluginHandler [

	| fileWithPlugin handler |
	site rawPath: root.
	fileWithPlugin := site / self publicationPageName.
	handler := site
		pluginHandle: fileWithPlugin plugin
		for: fileWithPlugin.
	self halt.
]
