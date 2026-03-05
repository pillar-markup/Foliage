Class {
	#name : 'FOPublishPathTest',
	#superclass : 'FOAbstractWebSiteTest',
	#instVars : [
		'blog'
	],
	#category : 'Foliage-Core-Tests-Blog',
	#package : 'Foliage-Core-Tests',
	#tag : 'Blog'
}

{ #category : 'tests' }
FOPublishPathTest >> test [

	self 
		assert: (site / 'success') publishPath printString
		equals: 'memory:///generated/success'.
		
	self 
		assert: (site / 'success' / 'gsoc.md') publishPath printString
		equals: 'memory:///generated/success/gsoc.html'
]

{ #category : 'tests' }
FOPublishPathTest >> testRelativePath [ 

	site := FOWebSite new.
	site fileSystem: fileSystem.
	site webRootPrefix: ''.
	
	site sourcePath: 'site'.
	site templatePath: 'site/templates'.
	
	"normally importFiles will do it all together"
	site readConfigFile.
	site importDirectory: fileSystem root / site sourcePath fullName.
	
	
	self 
		assert: (site / 'success') publishPath printString
		equals: 'memory:///generated/success'.
		
	self 
		assert: (site / 'success' / 'gsoc.md') publishPath printString
		equals: 'memory:///generated/success/gsoc.html'
]
