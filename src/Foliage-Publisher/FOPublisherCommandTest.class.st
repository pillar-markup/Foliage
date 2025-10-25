Class {
	#name : 'FOPublisherCommandTest',
	#superclass : 'TestCase',
	#category : 'Foliage-Publisher',
	#package : 'Foliage-Publisher'
}

{ #category : 'tests' }
FOPublisherCommandTest >> testSourceIsSetIntoCommand [

	| context command |
	context := FOPublisherCommand commandSpecification 
						activationWith: #( publish '--source' '/home').
	command := context command. 
	self assert: command source equals: '/home'.
]

{ #category : 'tests' }
FOPublisherCommandTest >> testSourceSetInPublisher [


	| context command |
	context := FOPublisherCommand commandSpecification 
						activationWith: #( publish '--source' '/home/stef/site').
	command := context command.
	command configure.
	
	self 
		assert: command publisher sourcePath fullName 
		equals: '/home/stef/site'
	
]

{ #category : 'tests' }
FOPublisherCommandTest >> testTargetIsSetIntoCommand [

	| context command |
	context := FOPublisherCommand commandSpecification 
						activationWith: #( publish '--target' '/taraget').
	command := context command.
	self assert: command target equals: '/taraget'.
]

{ #category : 'tests' }
FOPublisherCommandTest >> testTargetSetInPublisher [


	| context command |
	context := FOPublisherCommand commandSpecification 
						activationWith: #( publish '--target' '/taraget').
	command := context command.
	self assert: command target equals: '/taraget'.
 	
	command configure.

	self assert: command publisher targetPath fullName equals: '/taraget'
	
]
