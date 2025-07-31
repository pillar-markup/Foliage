"
I'm responsible of handling full publication list generation


```
{
""title"" : ""Publications"",
""layout"" : ""index"",
""plugin"" : [ ""kind"" : ""publicationList"",
	""pluginSpec"" : [ 
	#authorMatchingString : '*Anquetil*',
	#keysOfBlackListedEntries : [ ],
	#bibFilename : 'rmod.bib' ] ],
""publishDate"" : ""2025-06-01""
}

## Publications

Here is a list of the articles I wrote over the years.


```
"
Class {
	#name : 'FOFullPublicationPluginHandler',
	#superclass : 'FOPluginHandler',
	#instVars : [
		'builder'
	],
	#category : 'Foliage-Bib-Core',
	#package : 'Foliage-Bib',
	#tag : 'Core'
}

{ #category : 'description' }
FOFullPublicationPluginHandler class >> kind [

	^ 'publicationList'
]

{ #category : 'description' }
FOFullPublicationPluginHandler class >> pluginKind [

	^ 'publicationList'
]

{ #category : 'as yet unclassified' }
FOFullPublicationPluginHandler >> api [ 

	^ {
	(#authorMatchingString  
		-> 'Enter an expression that will in addition be surrounded by *. E.g. Ducasse will be *Ducasse*') .
		
	(#bibFilename 
		-> 'The path name of the file containing bib file. E.g. rmod.bib') .
		
	(#fieldOrder 
		-> 'A collection of symbols taken from #(#author #title #chapter #journal #booktitle #volume #pages #publisher #school #year #url #doi)') .
		
	(#keysOfBlackListedEntries 
		-> 'A collection of citation keys as defined in the bib file. E.g. #(Abde10a Chev11a)') .
		
	(#startYear 
		-> 'A year number that defines the beginning of the period to be taken into account. By default this is 1990.') .
		
	(#endYear 
		-> 'A year number that defines the beginning of the period to be taken into account. By default this is the current year') .
		
	(#bodySpecification 
		-> 'A collection of symbols taken from the default configuration:
		 #( #internationalJournal #nationalJournal #topConference #internationalConference #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #toolDemo #vulgarisation #PhDAndHabilitation)')
	}
]

{ #category : 'as yet unclassified' }
FOFullPublicationPluginHandler >> builder [

	^ builder
]

{ #category : 'as yet unclassified' }
FOFullPublicationPluginHandler >> initialize [ 
	
	super initialize. 
	builder := FOPublicationListBuilder new.
	

	
]

{ #category : 'as yet unclassified' }
FOFullPublicationPluginHandler >> treat: aFOMicrodownPage [

	| sections |
	"we will see in the future if this way of managing config values 
	should be moved to all plugins"	
	self api do: [ :each |
		aFOMicrodownPage pluginSpec 
			at: each key asSymbol 
			ifPresent: [ :f | builder perform: (each key, ':') asSymbol with: f ]
		 ].
	self flag: #todo. "handle error"
	
	builder build.
	sections := builder sections.
	
	"this is super ugly we should change the import to create correct objects first"
	webSite root items 
		at: aFOMicrodownPage sourcePath basename 
		put: ((aFOMicrodownPage as: FOFullPublicationPage) sections: sections; yourself).
	^ builder
]

{ #category : 'as yet unclassified' }
FOFullPublicationPluginHandler >> webSite: aWebSite [

	webSite := aWebSite.
	builder webSite: aWebSite
]
