Class {
	#name : 'FOSimpleWebSiteTest',
	#superclass : 'TestCase',
	#category : 'Foliage-Core-Tests-Importer',
	#package : 'Foliage-Core-Tests',
	#tag : 'Importer'
}

{ #category : 'tests' }
FOSimpleWebSiteTest >> testSourcePath [

	"Here I test some values for sourcePath to check because it looks like there are an invariant that 
	the site files should be in a folder that is not root.
	
	"
	| fs |
	fs := FileSystem memory. 
	
	self 
		assert: ((fs / 'site' / 'success') asFileReference relativeTo: (fs / 'site' ) asFileReference) fullName 
		equals: 'success'
]

{ #category : 'tests' }
FOSimpleWebSiteTest >> testSourcePathWithTopFolder [

	"Here I test some values for sourcePath to check because it looks like there are an invariant that 
	the site files should be in a folder that is not root.
	
	"
	| fs |
	fs := FileSystem memory. 
	
	self 
		assert: ((fs / 'site' / 'success') asFileReference relativeTo: (fs / 'site' ) asFileReference) fullName 
		equals: 'success'
]

{ #category : 'tests' }
FOSimpleWebSiteTest >> testSourcePathWithoutTopFolder [

	"Here I test some values for sourcePath to check because it looks like there are an invariant that 
	the site files should be in a folder that is not root.
	
	"
	| fs |
	fs := FileSystem memory. 
	
	self 
		assert: ((fs / 'success') asFileReference relativeTo: fs root ) fullName
		equals: 'success'
]

{ #category : 'tests' }
FOSimpleWebSiteTest >> testWebsiteHasARawPathWellInitialized [

	| w |
	w := FOWebSite new.
	self assert: w sourcePath class equals: FileReference
]

{ #category : 'tests' }
FOSimpleWebSiteTest >> testWebsiteHasARoot [

	| w |
	w := FOWebSite new.
	self assert: w root class equals: FOWebsiteRoot.
	self assert: w root parent equals: w
]

{ #category : 'tests' }
FOSimpleWebSiteTest >> testWebsiteHasAnImporterPerDefault [

	| w |
	w := FOWebSite new.
	self assert: w importer class equals: FOImporter.
	self assert: w importer website equals: w.
]
