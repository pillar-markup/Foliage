Class {
	#name : 'FOConfigurationFileTest',
	#superclass : 'FOAbstractWebSiteTest',
	#category : 'Foliage-Core-Tests-Model',
	#package : 'Foliage-Core-Tests',
	#tag : 'Model'
}

{ #category : 'running' }
FOConfigurationFileTest >> JSONFoliageConfigFileContents [

	^ '{
	#baseUri : ''http://esug.org'',
	#webRootPrefix : ''/ESUGWeb20'',
	#blogs: [ 
		''news'': ''News''
	],
	#menus : [
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
	#site_short_description : "European Smalltalk User Group"
}'
]

{ #category : 'running' }
FOConfigurationFileTest >> StonConfigFileContents [

	^ 'Foliage {
	#baseUri : ''http://esug.org'',
	#webRootPrefix : ''/ESUGWeb20'',
	#blogs: [ 
		''news'': ''News''
	],
	#properties : {
		"menu" : [
			{ "title" : "About Us",
		 	 "url" : "/about_us.html",
		  	"has_subfiles" : true,
		  	"submenu" : [ { 
				"title" : "About",
				"url" : "/about_us.html" 
				},
				{ 
				"title" : "Membership",
				"url" : "/membership.html" 
				},
				{ 
				"title" : "ESUG News",
				"url" : "/about_us.html" 
				}]
				},
			{ "title" : "Conferences",
		  	"url" : "/conferences.html",
		  	"has_subfiles" : true,
		  	"submenu" : [ { 
				"title" : "2025",
				"url" : "/2025-Conference/conf2025.html" 
				},
				{ 
				"title" : "2024",
				"url" : "/2024-Conference/conf2024.html" 
				}]
		}],
		"site_short_description" : "European Smalltalk User Group"
		}
}'
]

{ #category : 'running' }
FOConfigurationFileTest >> setUp [ 
	
	super setUp.
	site := FOWebSite new.
	site fileSystem: fileSystem.
	site sourcePath: 'site'.
]

{ #category : 'running' }
FOConfigurationFileTest >> testConfigurationFileExists [

	self assert: (fileSystem / 'site' / 'FoliageConfig.ston') exists

]

{ #category : 'running' }
FOConfigurationFileTest >> testConfigurationReads2 [

	| config |
	config := site readConfigFile.
	self assert: config class equals: FOConfigurationFile.
	self assert: (config webRootPrefix) equals:  '/ESUGWeb20'.
	self assert: (config blogs) equals:  {  'news' ->'News'}.
	self assert: (config menus) size equals: 2
]
