Class {
	#name : 'MicTopicPublicationListTest',
	#superclass : 'TestCase',
	#category : 'Foliage-Bib-Tests',
	#package : 'Foliage-Bib',
	#tag : 'Tests'
}

{ #category : 'tests' }
MicTopicPublicationListTest >> testTopicList [

	| doc |
	self skip.
	doc := Microdown parse: 

'<!topicList|title=This is a cool title&tag=nh5p

- a list of bullet
- bullet 2
- bullet 3
!>'.
	self assert: doc children first class equals: MicSlideBlock
]
