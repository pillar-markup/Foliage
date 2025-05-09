Class {
	#name : 'FOBlogRawFileTest',
	#superclass : 'FOBlogTest',
	#category : 'Foliage-Core-Tests-Blog',
	#package : 'Foliage-Core-Tests',
	#tag : 'Blog'
}

{ #category : 'tests' }
FOBlogRawFileTest >> testBlogPostHasMetaData [
	
	| item1 |
	item1 := site / 'success' / self mdOneFileName2.
	self assert: item1 title equals: 'IsLoop'.
	self assert: item1 publicationDate printString equals: '21 May 2025'.
	self assert: item1 layout equals: 'default'
	
	
]
