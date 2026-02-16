Class {
	#name : 'FOConfigurationFile',
	#superclass : 'Object',
	#instVars : [
		'properties'
	],
	#category : 'Foliage-Core',
	#package : 'Foliage-Core'
}

{ #category : 'ston-core' }
FOConfigurationFile class >> stonName [

	^ #Foliage
]

{ #category : 'accessing' }
FOConfigurationFile >> baseUri [
	
	^ self propertyAt: #baseUri
]

{ #category : 'accessing' }
FOConfigurationFile >> baseUri: aString [ 
	self propertyAt: #baseUri put: aString
]

{ #category : 'initialization' }
FOConfigurationFile >> initialize [

	super initialize.
	properties := Dictionary new.
	self propertyAt: self webRootPrefixSymbol put: ''
]

{ #category : 'accessing' }
FOConfigurationFile >> properties: aDictionary [ 
	properties := aDictionary
]

{ #category : 'accessing' }
FOConfigurationFile >> propertyAt: aString [

	^ properties at: aString
]

{ #category : 'accessing' }
FOConfigurationFile >> propertyAt: aKey put: aString [

	properties at: aKey put: aString
]

{ #category : 'accessing' }
FOConfigurationFile >> webRootPrefix [

	^ properties at: self webRootPrefixSymbol
]

{ #category : 'accessing' }
FOConfigurationFile >> webRootPrefix: aString [

	properties at: self webRootPrefixSymbol put: aString
]

{ #category : 'private' }
FOConfigurationFile >> webRootPrefixSymbol [

	^ #webRootPrefix
]
