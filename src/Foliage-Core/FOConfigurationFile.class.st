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

{ #category : 'initialization' }
FOConfigurationFile >> initialize [

	super initialize.
	properties := Dictionary new.
	self propertyAt: #webRootPrefix put: ''
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
	^ properties at: #webRootPrefix
]

{ #category : 'accessing' }
FOConfigurationFile >> webRootPrefix: aString [
	properties at: #webRootPrefix put: aString
]
