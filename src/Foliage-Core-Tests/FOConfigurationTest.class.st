Class {
	#name : 'FOConfigurationTest',
	#superclass : 'TestCase',
	#instVars : [
		'site',
		'fileSystem'
	],
	#category : 'Foliage-Core-Tests-Configuration',
	#package : 'Foliage-Core-Tests',
	#tag : 'Configuration'
}

{ #category : 'running' }
FOConfigurationTest >> JSONFoliageConfigFileContentsReal [
	"Here we redefine the file to include a webrootprefix"
	
	^ '{
	"baseUri" : "http://esug.org",
	"webRootPrefix" : "/ESUGWeb20",
	"blogs" : [ "news" : "News" ],
	"menus" : [
			{ "title" : "About Us",
		 	 "url" : "/about_us.html",
		  	"has_subfiles" : true,
		  	"submenu" : [ { "title" : "About","url" : "/about_us.html" },
							{ "title" : "Membership", "url" : "/membership.html" },
				{ "title" : "ESUG News","url" : "/about_us.html"	}] 
				},
			{ "title" : "Conferences",
		  	"url" : "/conferences.html",
		  	"has_subfiles" : true,
		  	"submenu" : [ { "title" : "2025", "url" : "/2025-Conference/conf2025.html" },
				{ "title" : "2024", "url" : "/2024-Conference/conf2024.html" }]
		}],
	"site_short_description" : "22European Smalltalk User Group"
}'
]

{ #category : 'running' }
FOConfigurationTest >> setUp [ 
	
	
	fileSystem := FileSystem memory.
	(fileSystem / 'site') ensureCreateDirectory.
	
	(fileSystem / 'site' / 'FoliageConfig.json')
		 writeStreamDo: [ :st | st nextPutAll: self JSONFoliageConfigFileContentsReal ].
		
	site := FOWebSite new.
	site fileSystem: fileSystem.
	site sourcePath: 'site'
]

{ #category : 'running' }
FOConfigurationTest >> testConfigurationAccessToProperties [

	site readConfigFile.
	self 
		assert: (site configuration propertyAt: 'site_short_description')
		equals: '22European Smalltalk User Group'
]

{ #category : 'running' }
FOConfigurationTest >> testConfigurationAccessToUnknowProperties [

	| config unk |
	site readConfigFile.
	config := site configuration.
	unk := false.
	config propertyAt: 'doesNotExists' ifAbsent: [ unk := true ].
	self assert: unk
]

{ #category : 'running' }
FOConfigurationTest >> testConfigurationAccessViaSite [

	site readConfigFile.
	self 
		assert: (site configuration propertyAt: 'site_short_description')
		equals: '22European Smalltalk User Group'
]

{ #category : 'running' }
FOConfigurationTest >> testConfigurationFileExists [

	self assert: (fileSystem / 'site' / 'FoliageConfig.json') exists


]

{ #category : 'running' }
FOConfigurationTest >> testConfigurationReads2 [

	| config |
	site readConfigFile.
	config := site configuration.
	self assert: config class equals: FOConfiguration.
	self assert: config webRootPrefix equals:  '/ESUGWeb20'.
	self assert: config blogs equals:  { 'news' ->'News' }.
	self assert: config menus size equals: 2
]

{ #category : 'running' }
FOConfigurationTest >> testConfigurationReadsFromJSON [

	| config |
	site readConfigFile.
	config := site configuration.
	self assert: (config propertyAt: 'site_short_description')
		equals: '22European Smalltalk User Group'
]
