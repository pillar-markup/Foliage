Class {
	#name : 'FOPublisherTest',
	#superclass : 'TestCase',
	#category : 'Foliage-Core-Tests-Importer',
	#package : 'Foliage-Core-Tests',
	#tag : 'Importer'
}

{ #category : 'tests' }
FOPublisherTest >> testBasic [
	
	| publisher |
	publisher := FOPublisher new
		baseUri: 'http://pharo.org';
		blogs: { 'news' -> 'Pharo News' . 'success' -> 'Pharo Success Stories' };
		yourself.
	self assert: publisher baseUri equals: 'http://pharo.org'

]

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
