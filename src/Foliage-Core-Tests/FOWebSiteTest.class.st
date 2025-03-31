Class {
	#name : 'FOWebSiteTest',
	#superclass : 'TestCase',
	#category : 'Foliage-Core-Tests-Importer',
	#package : 'Foliage-Core-Tests',
	#tag : 'Importer'
}

{ #category : 'tests' }
FOWebSiteTest >> testWebsiteHasARawPathWellInitialized [

	| w |
	w := FOWebSite new.
	self assert: w rawPath class equals: FileReference
]

{ #category : 'tests' }
FOWebSiteTest >> testWebsiteHasARoot [

	| w |
	w := FOWebSite new.
	self assert: w root class equals: FOWebsiteRoot.
	self assert: w root parent equals: w
]

{ #category : 'tests' }
FOWebSiteTest >> testWebsiteHasAnImporterPerDefault [

	| w |
	w := FOWebSite new.
	self assert: w importer class equals: FOImporter.
	self assert: w importer website equals: w.
]
