Class {
	#name : 'FOFullPublicationPluginHandler',
	#superclass : 'FOPluginHandler',
	#instVars : [
		'webSite'
	],
	#category : 'Foliage-Bib-Core',
	#package : 'Foliage-Bib',
	#tag : 'Core'
}

{ #category : 'description' }
FOFullPublicationPluginHandler class >> kind [

	^ 'publicationList'
]

{ #category : 'as yet unclassified' }
FOFullPublicationPluginHandler >> treat: aFOMicrodownPage [


	| bibFileName author p sections |
	bibFileName := aFOMicrodownPage pluginSpec at: #filename. 
	author := aFOMicrodownPage pluginSpec at: #authorMatchingString.
	self flag: #todo. "handle error"

	p := FOPublicationListBuilder new.
	p onStream: (webSite root / bibFileName) sourcePath asFileReference readStream.
	p authorMatchingString: '*', author, '*'.
	
	p build.
	sections := p sections.
	
	"this is super ugly we should change the import to create correct objects first"
	webSite root items 
		at: aFOMicrodownPage sourcePath basename 
		put: ((aFOMicrodownPage as: FOFullPublicationPage) sections: sections; yourself)
]

{ #category : 'accessing' }
FOFullPublicationPluginHandler >> webSite [

	^ webSite
]

{ #category : 'accessing' }
FOFullPublicationPluginHandler >> webSite: anObject [

	webSite := anObject
]
