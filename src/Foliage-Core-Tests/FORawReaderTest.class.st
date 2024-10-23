"
A FORawReaderTest is a test class for testing the behavior of FORawReader
"
Class {
	#name : 'FORawReaderTest',
	#superclass : 'TestCase',
	#category : 'Foliage-Core-Tests-Reader',
	#package : 'Foliage-Core-Tests',
	#tag : 'Reader'
}

{ #category : 'tests' }
FORawReaderTest >> testFactoryIsWorking [ 

	self assert: (FOAbstractReader forFileExtension: 'glop') isNil.
	self assert: (FOAbstractReader forFileExtension: 'md') equals: FOMicrodownReader.
	self assert: (FOAbstractReader forFileExtension: 'css') equals: FOFileReader.
	
]

{ #category : 'tests' }
FORawReaderTest >> testMatchesFileExtensions [

	self assert: (FOFileReader matchesFileExtension: 'css').
	self assert: (FOFileReader matchesFileExtension: 'js').
	self assert: (FOFileReader matchesFileExtension: 'ico').
]
