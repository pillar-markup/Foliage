Class {
	#name : 'FOConfigurationWrapper',
	#superclass : 'Object',
	#instVars : [
		'configuration'
	],
	#category : 'Foliage-Core-Model',
	#package : 'Foliage-Core',
	#tag : 'Model'
}

{ #category : 'ston-core' }
FOConfigurationWrapper class >> stonName [ 

	^ 'Foliage'
]

{ #category : 'accessing' }
FOConfigurationWrapper >> configuration [

	^ configuration 
]

{ #category : 'initialization' }
FOConfigurationWrapper >> initialize [

	super initialize.
	configuration := FOConfiguration new.
]

{ #category : 'accessing' }
FOConfigurationWrapper >> instVarNamed: instVarName put: avalue [
	
	configuration propertyAt: instVarName put: avalue
		
]
