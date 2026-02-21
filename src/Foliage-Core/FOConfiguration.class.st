Class {
	#name : 'FOConfiguration',
	#superclass : 'Object',
	#instVars : [
		'properties'
	],
	#category : 'Foliage-Core-Model',
	#package : 'Foliage-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
FOConfiguration >> baseUri [
	
	^ self propertyAt: #baseUri
]

{ #category : 'accessing' }
FOConfiguration >> baseUri: aString [ 
	self propertyAt: #baseUri put: aString
]

{ #category : 'accessing' }
FOConfiguration >> blogs [
	^ self propertyAt: #blogs ifAbsent: [ #() ]
]

{ #category : 'initialization' }
FOConfiguration >> initialize [

	super initialize.
	properties := Dictionary new.
	self propertyAt: self webRootPrefixSymbol put: ''
]

{ #category : 'accessing' }
FOConfiguration >> menus [

	^ self propertyAt: #menus ifAbsent: [ #() ]
]

{ #category : 'accessing' }
FOConfiguration >> properties: aDictionary [ 
	properties := aDictionary
]

{ #category : 'accessing' }
FOConfiguration >> propertyAt: aString [

	^ properties at: aString
]

{ #category : 'accessing' }
FOConfiguration >> propertyAt: aString ifAbsent: aBlock [

	^ properties at: aString ifAbsent: aBlock
]

{ #category : 'accessing' }
FOConfiguration >> propertyAt: aKey put: aString [

	properties at: aKey put: aString
]

{ #category : 'accessing' }
FOConfiguration >> webRootPrefix [

	^ properties at: self webRootPrefixSymbol
]

{ #category : 'accessing' }
FOConfiguration >> webRootPrefix: aString [

	properties at: self webRootPrefixSymbol put: aString
]

{ #category : 'private' }
FOConfiguration >> webRootPrefixSymbol [

	^ #webRootPrefix
]
