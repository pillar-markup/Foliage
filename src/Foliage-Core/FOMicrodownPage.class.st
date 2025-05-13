Class {
	#name : 'FOMicrodownPage',
	#superclass : 'FOPageWithMetadata',
	#instVars : [
		'document'
	],
	#category : 'Foliage-Core-Model',
	#package : 'Foliage-Core',
	#tag : 'Model'
}

{ #category : 'testing' }
FOMicrodownPage class >> supportedFileExtensions [
	^ { } 
]

{ #category : 'accessing' }
FOMicrodownPage >> abstract [
	
	| abstract |
	self halt.
	abstract := (Character space join: (document children allButFirst collect: [ :each | each text ])).
	
	^ abstract first: (abstract size min: self abstractAmountOfCharacters)
]

{ #category : 'accessing' }
FOMicrodownPage >> abstractAmountOfCharacters [

	^ 400
]

{ #category : 'visiting' }
FOMicrodownPage >> acceptFOVisitor: aFOVisitor [ 
	^ aFOVisitor visitMicrodownPage: self 
]

{ #category : 'accessing' }
FOMicrodownPage >> document [
	^ document
]

{ #category : 'accessing' }
FOMicrodownPage >> document: aMicRootBlock [ 
	document := aMicRootBlock
]

{ #category : 'accessing' }
FOMicrodownPage >> publicationDate [

	^ self meta 
		at: 'publishDate'
		ifPresent: [ :aString | Date readFrom: aString pattern: 'yyyy-mm-dd'  ]
		ifAbsent: [ nil ]
]

{ #category : 'actions' }
FOMicrodownPage >> publish [

	self publishPath
		ensureDelete;
		writeStreamDo: [ :stream | stream << self htmlString ]
]

{ #category : 'accessing' }
FOMicrodownPage >> publishPath [

	^ super publishPath withExtension: 'html'
]

{ #category : 'accessing' }
FOMicrodownPage >> publishPathFor: aString [ 
	^ (aString endsWith: #html)
		ifTrue: [ aString ]
		ifFalse: [ (aString allButLast: 2), #html ]
]

{ #category : 'rendering' }
FOMicrodownPage >> render [ 

	^ self newRenderContext renderTemplate: self template.
]

{ #category : 'rendering' }
FOMicrodownPage >> renderOn: aStream [

	| visitor |
	"here we could set the lline ending convention."
	visitor := MicHTMLVisitor new
		           stream: aStream;
		           yourself.
	visitor visit: document.
	^ visitor contents
]

{ #category : 'accessing' }
FOMicrodownPage >> template [
	^ (self website templatePathForLayout: self layout) asMustacheTemplate.
]
