Class {
	#name : 'FOPublisherCommandTest',
	#superclass : 'TestCase',
	#category : 'Foliage-Publisher',
	#package : 'Foliage-Publisher'
}

{ #category : 'tests' }
FOPublisherCommandTest >> testArchetype [

	| context  |
	context := FOPublisherCommand commandSpecification 
						activationWith: #(foliage publish 'source' '/home').
	self assert: context command source equals: '/home'.
]
