Class {
	#name : 'FOStdoutLogger',
	#superclass : 'SignalLogger',
	#category : 'Foliage-Publisher',
	#package : 'Foliage-Publisher'
}

{ #category : 'accessing' }
FOStdoutLogger >> nextPut: anObject [

	NonInteractiveTranscript stdout crShow: anObject
]
