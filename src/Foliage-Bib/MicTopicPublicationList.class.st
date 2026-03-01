Class {
	#name : 'MicTopicPublicationList',
	#superclass : 'AnObsoleteMicAnnotationBlock',
	#category : 'Foliage-Bib-MicrodownExtensions',
	#package : 'Foliage-Bib',
	#tag : 'MicrodownExtensions'
}

{ #category : 'parsing' }
MicTopicPublicationList class >> tag [

	^ #topicList
]

{ #category : 'accessing' }
MicTopicPublicationList >> description [

	^ self arguments at: #description
]
