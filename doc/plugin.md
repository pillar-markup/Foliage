# Plugin 

Foliage offers a basic plugin architecture.
At the time being there is only one plugin: an automatic publication list generators. 

More plugins will be developed as needs emerge.

## Basic structure

A plugin 
- is identified by a plugin kind.
- is composed of a pluginSpec. It is the parameters that the plugin can handle. 


## Automatic publication generation
Here is an example that show how to declare a publication plugin.
 
A plugin 
- is identified by a plugin kind. Here it is 'publicationList'.
- is composed of a pluginSpec. It is the parameters that the plugin can handle. 

```
{
"title" : "Publications",
"layout" : "index",
"plugin" : [ "kind" : "publicationList",
	"pluginSpec" : [ 
	#authorMatchingString : 'S*Ducasse',
	#bibFilename : 'rmod.bib' ] ],
"publishDate" : "2025-06-01"
}

## Publications

Here is a list of the articles I wrote over the years. Not all my books may be listed here. 

```

Based on this, Foliage will automatically generate a full list of publication based on the name and the bib file. 


## Publication list possible parameters

Here is the list of the supported parameters of the plugin

- authorMatchingString. Expect a string that will identify the author. The expression that will in addition be surrounded by `*`. E.g. `Ducasse` will be `*Ducasse*`.
- bibFilename. The path name of the file containing bib file. E.g. 'rmod.bib'.
- keysOfBlackListedEntries. A collection of citation keys as defined in the bib file. E.g. #(Abde10a Chev11a).
- startYear. A year number that defines the beginning of the period to be taken into account. By default this is 1990.
- endYear. A year number that defines the beginning of the period to be taken into account. By default this is the current year.
- bodySpecification. Expects a collection of Symbols. With it you can control the order of the publication kinds (journal, conference,...) or if a subsection should appear at all. A collection of symbols taken from the default configuration:	 #( #internationalJournal #nationalJournal #topConference #internationalConference #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #toolDemo #vulgarisation #PhDAndHabilitation). 
- fieldOrder. Expects a collection of Symbols. With it you can change the information displayed in a given publication entry. The collection of symbols should be taken from #(#author #title #chapter #journal #booktitle #volume #pages #publisher #school #year #url #doi).










