"
Represent information held in a Foliage.ston file.
The information is about the structure of the web.

I do not capture source, target and template locations.  

The file contents can be two formats: JSON and STON.
When the file contains STON, the reader generates a wrapper that is turned into 
an instance of this class. 

"
Class {
	#name : 'FOConfiguration',
	#superclass : 'Object',
	#instVars : [
		'properties',
		'fromSton'
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

{ #category : 'accessing' }
FOConfiguration >> configuration [
	"to be polymorphic with the wrapper so that we can use the wrapper or the wrappee to the the wrappee"
	
	^ self
]

{ #category : 'instance creation' }
FOConfiguration >> fromJSON [

	fromSton := false
]

{ #category : 'instance creation' }
FOConfiguration >> fromSton [

	fromSton := true
]

{ #category : 'initialization' }
FOConfiguration >> initialize [

	super initialize.
	properties := Dictionary new.
	fromSton := false.
	self propertyAt: self webRootPrefixString put: ''
]

{ #category : 'instance creation' }
FOConfiguration >> isFromSton [

	^ fromSton
]

{ #category : 'accessing' }
FOConfiguration >> menus [

	^ self propertyAt: 'menus' ifAbsent: [ #() ]
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

	^ properties at: self webRootPrefixString
]

{ #category : 'accessing' }
FOConfiguration >> webRootPrefix: aString [

	properties at: self webRootPrefixString put: aString
]

{ #category : 'private' }
FOConfiguration >> webRootPrefixString [

	^ 'webRootPrefix'
]
