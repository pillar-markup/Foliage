Class {
	#name : 'FOMicrodownReader',
	#superclass : 'FOAbstractReader',
	#category : 'Foliage-Core-Reader',
	#package : 'Foliage-Core',
	#tag : 'Reader'
}

{ #category : 'testing' }
FOMicrodownReader class >> supportedFileExtensions [
	^ #( md )
]

{ #category : 'reading' }
FOMicrodownReader >> createModelEntity [

	^ FOPillarPage new
		sourcePath: file asPath;
		meta: (self readMetaFrom: self stream);
		document: (self readDocumentFrom: self stream). 

]

{ #category : 'reading' }
FOMicrodownReader >> readDocumentFrom: aStream [

	^ (MicrodownParser parse: aStream upToEnd) asPillar

]

{ #category : 'generation' }
FOMicrodownReader >> readMetaFrom: aStream [
	^ self readSimpleMetaFrom: aStream
]

{ #category : 'generation' }
FOMicrodownReader >> readSimpleMetaFrom: aStream [
	^ (FOMetaReader on: aStream) next
]
