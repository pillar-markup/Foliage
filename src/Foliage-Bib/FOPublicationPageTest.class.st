Class {
	#name : 'FOPublicationPageTest',
	#superclass : 'FOBlogTest',
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
		writeStreamDo: [ :st | st nextPutAll: FOPublicationListTest new contents ].
	
]

{ #category : 'publications' }
FOPublicationPageTest >> publicationPage [

	^ '{
"title" : "Stef publication",
"layout" : "default",
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
	
	| publications |
	site rawPath: root.
	publications := site buildPublicationPage: self publicationPageName.
	self assert: publications sections isEmpty not.
]
