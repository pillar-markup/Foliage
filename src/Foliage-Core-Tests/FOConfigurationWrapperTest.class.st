Class {
	#name : 'FOConfigurationWrapperTest',
	#superclass : 'TestCase',
	#instVars : [
		'site',
		'fileSystem'
	],
	#category : 'Foliage-Core-Tests-Model',
	#package : 'Foliage-Core-Tests',
	#tag : 'Model'
}

{ #category : 'running' }
FOConfigurationWrapperTest >> StonConfigFileContents [
	"this is the same in Ston format and so far it is not supported"
	
	^ 'Foliage {
	#baseUri : ''http://esug.org'',
	#webRootPrefix : ''/ESUGWeb20'',
	#blogs: [ 
		''news'': ''News''
	],
	
		"menus" : [
			{ "title" : "About Us", "url" : "/about_us.html", "has_subfiles" : true,
		  		"submenu" : [ 
					{ "title" : "About","url" : "/about_us.html" },
					{ "title" : "Membership","url" : "/membership.html" },
					{ "title" : "ESUG News","url" : "/about_us.html" }]
				},
			{ "title" : "Conferences", "url" : "/conferences.html", "has_subfiles" : true,
		  		"submenu" : [ 
					{ "title" : "2025", "url" : "/2025-Conference/conf2025.html" },
					{ "title" : "2024", "url" : "/2024-Conference/conf2024.html" }]}
		],
		"site_short_description" : "European Smalltalk User Group"

}'
]

{ #category : 'running' }
FOConfigurationWrapperTest >> setUp [
	
	super setUp.
	fileSystem := FileSystem memory.
	(fileSystem / 'site') createDirectory.
	
	site := FOWebSite new.
	site fileSystem: fileSystem.
	site sourcePath: 'site'.
	(fileSystem / 'site' / 'FoliageConfig.ston')
		 writeStreamDo: [ :st | st nextPutAll: self StonConfigFileContents ]
]

{ #category : 'tests' }
FOConfigurationWrapperTest >> testFoliageStonExists [

	self assert: (fileSystem / 'site'/ 'FoliageConfig.ston') exists.

]

{ #category : 'tests' }
FOConfigurationWrapperTest >> testReadsFromSton [

	| config |
	config := site readConfigFile.
	self assert: config isFromSton
]

{ #category : 'tests' }
FOConfigurationWrapperTest >> testReadsProperties [

	| config menus |
	config := site readConfigFile.
	self assert: config class equals: FOConfiguration.
	menus := (config propertyAt: 'menus').
	self assert: menus first class equals: Dictionary.
	self assert: menus second class equals: Dictionary.
	self 
		assert: (config propertyAt: 'site_short_description') 
		equals: 'European Smalltalk User Group'
]

{ #category : 'tests' }
FOConfigurationWrapperTest >> testReadsValue [

	| config |
	config := site readConfigFile.
	self assert: config class equals: FOConfiguration.
	self assert: config webRootPrefix equals:  '/ESUGWeb20'.
	self assert: config baseUri equals:  'http://esug.org'.
	self assert: config blogs equals: {'news'->'News'}.
]
