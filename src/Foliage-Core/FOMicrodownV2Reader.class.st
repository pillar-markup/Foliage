"
Once we will have migrated to MicrodownV2 we will see.
"
Class {
	#name : 'FOMicrodownV2Reader',
	#superclass : 'FOAbstractReader',
	#category : 'Foliage-Core-Reader',
	#package : 'Foliage-Core',
	#tag : 'Reader'
}

{ #category : 'testing' }
FOMicrodownV2Reader class >> supportedFileExtensions [
	^ #( md2 )
]

{ #category : 'reading' }
FOMicrodownV2Reader >> model [

	| doc |
	doc := self readDocumentFrom: self stream. 
	^ FOPillarPage new
		sourcePath: file asPath;
		meta: doc children first;
		document: doc. 

]

{ #category : 'reading' }
FOMicrodownV2Reader >> readDocumentFrom: aStream [

	^ (MicrodownParser parse: aStream upToEnd)

]

{ #category : 'generation' }
FOMicrodownV2Reader >> readJsonFrom: aStream [
	^ (NeoJSONReader on: aStream) next
	
]

{ #category : 'generation' }
FOMicrodownV2Reader >> readMetaFrom: aStream [
	^ self readSimpleMetaFrom: aStream
]

{ #category : 'generation' }
FOMicrodownV2Reader >> readSimpleMetaFrom: aStream [
	^ (FOMetaReader on: aStream) next
]
