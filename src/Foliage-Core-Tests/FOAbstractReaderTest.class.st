"
A FORawReaderTest is a test class for testing the behavior of FORawReader
"
Class {
	#name : 'FOAbstractReaderTest',
	#superclass : 'TestCase',
	#category : 'Foliage-Core-Tests-Reader',
	#package : 'Foliage-Core-Tests',
	#tag : 'Reader'
}

{ #category : 'tests' }
FOAbstractReaderTest >> testFactoryIsWorking [ 

	self assert: (FOAbstractReader forFileExtension: 'glop') isNil.
	self assert: (FOAbstractReader forFileExtension: 'md') equals: FOMicrodownReader.
	self assert: (FOAbstractReader forFileExtension: 'css') equals: FOFileReader.
	
]

{ #category : 'tests' }
FOAbstractReaderTest >> testMatchesFileExtensions [

	self assert: (FOFileReader matchesFileExtension: 'css').
	self assert: (FOFileReader matchesFileExtension: 'js').
	self assert: (FOFileReader matchesFileExtension: 'ico').
]
