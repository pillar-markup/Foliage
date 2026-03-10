Class {
	#name : 'MicTopicPublicationList',
	#superclass : 'MicAnnotationBlock',
	#category : 'Foliage-Bib-MicrodownExtensions',
	#package : 'Foliage-Bib',
	#tag : 'MicrodownExtensions'
}

{ #category : 'parsing' }
MicTopicPublicationList class >> tag [

	^ #topicList
]

{ #category : 'visiting' }
MicTopicPublicationList >> accept: aVisitor [

	aVisitor visitTopicPublicationList: self 
]

{ #category : 'accessing' }
MicTopicPublicationList >> description [ 

	^ self arguments at: #description
]
