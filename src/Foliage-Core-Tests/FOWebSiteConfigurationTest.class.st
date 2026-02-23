Class {
	#name : 'FOWebSiteConfigurationTest',
	#superclass : 'FOAbstractWebSiteTest',
	#category : 'Foliage-Core-Tests-Blog',
	#package : 'Foliage-Core-Tests',
	#tag : 'Blog'
}

{ #category : 'running' }
FOWebSiteConfigurationTest >> foliageStonContents [

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
}
'
]

{ #category : 'running' }
FOWebSiteConfigurationTest >> setUp [ 

	super setUp.
	(fileSystem / 'home'/'Test2'/'foliage'/'test') ensureCreateDirectory.
	fileSystem / 'home'/'Test2'/'foliage'/'test' / 'FoliageConfig.ston'
		writeStreamDo: [ :st | st nextPutAll: self foliageStonContents ].
]

{ #category : 'running' }
FOWebSiteConfigurationTest >> testFoliageStonExists [

	self assert: (root / 'home' / 'Test2' / 'foliage' / 'test' / 'FoliageConfig.ston') exists.

]

{ #category : 'tests' }
FOWebSiteConfigurationTest >> testUninitializedWebSite [
	
	| ws |
	ws := FOWebSite new
		targetPath: '/home/Test2/foliage/output';
		sourcePath: '/home/Test2/foliage/test/'.

	self 
		assert: ws sourcePath fullName 
		equals: '/home/Test2/foliage/test'.		
	self 
		assert: ws targetPath fullName 
		equals: '/home/Test2/foliage/output'.	
]

{ #category : 'tests' }
FOWebSiteConfigurationTest >> testWithFileSystemUninitializedWebSite [
	
	| ws |
	ws := FOWebSite new.
	ws fileSystem: fileSystem.
	ws	targetPath: '/home/Test2/foliage/output'.
	ws	sourcePath: '/home/Test2/foliage/test/'.
		
	self 
		assert: ws sourcePath fullName 
		equals: '/home/Test2/foliage/test'.		
	self 
		assert: ws targetPath fullName 
		equals: '/home/Test2/foliage/output'.	
]
