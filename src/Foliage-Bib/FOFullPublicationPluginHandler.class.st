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
	#category : 'Foliage-Bib-Core',
	#package : 'Foliage-Bib',
	#tag : 'Core'
}

{ #category : 'description' }
FOFullPublicationPluginHandler class >> kind [

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
FOFullPublicationPluginHandler >> treat: aFOMicrodownPage [

	| bibFileName author p sections |
	
	bibFileName := aFOMicrodownPage pluginSpec at: #bibFilename.
	
	author := aFOMicrodownPage pluginSpec at: #authorMatchingString.
	self flag: #todo. "handle error"

	p := FOPublicationListBuilder new.
	p webSite: webSite. 
	p bibFilename: bibFileName.
	p authorMatchingString: author.
	
	p build.
	sections := p sections.
	
	"this is super ugly we should change the import to create correct objects first"
	webSite root items 
		at: aFOMicrodownPage sourcePath basename 
		put: ((aFOMicrodownPage as: FOFullPublicationPage) sections: sections; yourself)
]
