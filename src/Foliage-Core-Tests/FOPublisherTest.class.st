Class {
	#name : 'FOPublisherTest',
	#superclass : 'TestCase',
	#category : 'Foliage-Core-Tests-Importer',
	#package : 'Foliage-Core-Tests',
	#tag : 'Importer'
}

{ #category : 'tests' }
FOPublisherTest >> testBasic2 [
	
	| publisher |
	publisher := FOPublisher new
		baseUri: 'http://pharo.org';
		blogs: { 'news' -> 'Pharo News' . 'success' -> 'Pharo Success Stories' };
		yourself.
	self assert: publisher baseUri equals: 'http://pharo.org'.
	publisher targetPath: '/home/ducasse/Test2/foliage/output'.
	publisher sourcePath: '/home/ducasse/Test2/foliage/test/'.
	

]

{ #category : 'tests' }
FOPublisherTest >> testBasicPublisherConfiguration [
	
	| publisher |
	publisher := FOPublisher new
		baseUri: 'http://pharo.org';
		blogs: { 'news' -> 'Pharo News' . 'success' -> 'Pharo Success Stories' };
		yourself.
	self assert: publisher baseUri equals: 'http://pharo.org'

]

{ #category : 'tests' }
FOPublisherTest >> testConfigurateWebSite [
	
	| publisher ws |
	publisher := FOPublisher new
		baseUri: 'http://pharo.org';
		blogs: { 'news' -> 'Pharo News' . 'success' -> 'Pharo Success Stories' };
		targetPath: '/home/ducasse/Test2/foliage/output';
		sourcePath: '/home/ducasse/Test2/foliage/test/'.
	ws := publisher configureNewWebSite.
	self assert: ws baseUri equals: 'http://pharo.org'.
	self assert: ws targetPath fullName equals: '/home/ducasse/Test2/foliage/output'.
	self assert: ws rawPath fullName equals: '/home/ducasse/Test2/foliage/test'.
	self assert: ws templatePath fullName equals: '/home/ducasse/Test2/foliage/test/templates'
	
	"this is strange that the publisher is not using directly fileReference and only the website is configured so but let us see."
	
	

]
