"
I'm the root of objects reponsible for handling plugins.

Each of my subclass should declare the plugins it can manage by defining a class side method
returning the key `publicationList`.

For example the `FOFullPublicationPluginHandler` manages the following plugin use.

```
{
""title"" : ""Publications"",
""layout"" : ""index"",
""plugin"" : [ ""kind"" : ""publicationList"",
	""pluginSpec"" : [ 
	#authorMatchingString : '*Anquetil*',
	#keysOfBlackListedEntries : [ ],
	#filename : 'rmod.bib' ] ],
""publishDate"" : ""2025-06-01""
}

## Publications

Here is a list of the articles I wrote over the years.

```
"
Class {
	#name : 'FOPluginHandler',
	#superclass : 'Object',
	#instVars : [
		'pub',
		'webSite'
	],
	#category : 'Foliage-Core-Model',
	#package : 'Foliage-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
FOPluginHandler >> webSite [

	^ webSite
]

{ #category : 'accessing' }
FOPluginHandler >> webSite: anObject [

	webSite := anObject
]
