Class {
	#name : 'FOSimpleWebSiteTest',
	#superclass : 'TestCase',
	#category : 'Foliage-Core-Tests-Importer',
	#package : 'Foliage-Core-Tests',
	#tag : 'Importer'
}

{ #category : 'tests' }
FOSimpleWebSiteTest >> testWebsiteHasARawPathWellInitialized [

	| w |
	w := FOWebSite new.
	self assert: w rawPath class equals: FileReference
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
