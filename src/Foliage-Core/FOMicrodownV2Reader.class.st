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
	^ #( md )
]

{ #category : 'reading' }
FOMicrodownV2Reader >> createModelEntity [

	| doc |
	doc := self readDocumentFrom: self stream. 
	^ FOMicrodownPage new
		sourcePath: file asPath;
		meta: doc children first;
		document: doc. 
		
	"may be we could remove the metadata from the document since it is the first element."

]

{ #category : 'reading' }
FOMicrodownV2Reader >> readDocumentFrom: aStream [

	^ (MicrodownParser parse: aStream upToEnd)

]
