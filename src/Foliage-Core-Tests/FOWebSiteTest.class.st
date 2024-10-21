Class {
	#name : 'FOWebSiteTest',
	#superclass : 'TestCase',
	#category : 'Foliage-Core-Tests-Importer',
	#package : 'Foliage-Core-Tests',
	#tag : 'Importer'
}

{ #category : 'tests' }
FOWebSiteTest >> testWebsiteHasARoot [

	| w |
	w := FOWebSite new.
	self assert: w root class equals: FOWebsiteRoot.
	self assert: w root parent equals: w
]
