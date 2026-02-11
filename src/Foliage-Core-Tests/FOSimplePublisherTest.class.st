Class {
	#name : 'FOSimplePublisherTest',
	#superclass : 'TestCase',
	#category : 'Foliage-Core-Tests-Importer',
	#package : 'Foliage-Core-Tests',
	#tag : 'Importer'
}

{ #category : 'tests' }
FOSimplePublisherTest >> testBasic2 [
	
	| publisher |
	publisher := FOPublisher new
		baseUri: 'http://pharo.org';
		yourself.
	self assert: publisher baseUri equals: 'http://pharo.org'.
	publisher targetPath: '/home/ducasse/Test2/foliage/output'.
	publisher sourcePath: '/home/ducasse/Test2/foliage/test/'.
	

]

{ #category : 'tests' }
FOSimplePublisherTest >> testConfigurateWebSite [

	| publisher ws |
	publisher := FOPublisher new
		             baseUri: 'http://pharo.org';
		             targetPath: '/home/ducasse/Test2/foliage/output';
		             sourcePath: '/home/ducasse/Test2/foliage/test/'.
	self
		assert: publisher sourcePath 
		equals: '/home/ducasse/Test2/foliage/test/'.
	self
		assert: publisher targetPath
		equals: '/home/ducasse/Test2/foliage/output'.
		
	self 
		assert: publisher templatePath 
		equals: 'templates'.

	ws := publisher newWebSite.
	self 
		assert: ws baseUri 
		equals: 'http://pharo.org'.
	self
		assert: ws targetPath fullName
		equals: '/home/ducasse/Test2/foliage/output'.
	self
		assert: ws sourcePath fullName
		equals: '/home/ducasse/Test2/foliage/test'.
	self
		assert: ws templatePath fullName 
		equals: '/home/ducasse/Test2/foliage/test/templates'

	"this is strange that the publisher is not using directly fileReference and only the website is configured so but let us see."
]
