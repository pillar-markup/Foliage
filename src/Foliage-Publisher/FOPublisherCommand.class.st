"
Here is an example of how to use me in Pharo 13. 

```
/Users/ducasse/Documents/Pharo/vms/130-x64/Pharo.app/Contents/MacOS/Pharo /Users/ducasse/Documents/Pharo/images/P13-Foliage-3/P13-Foliage-3.image clap publish --source /Users/ducasse/Test2/ESUGWeb20/site --target /Users/ducasse/Test2/ESUGWeb20/generated
```
"
Class {
	#name : 'FOPublisherCommand',
	#superclass : 'ClapApplication',
	#instVars : [
		'publisher'
	],
	#category : 'Foliage-Publisher',
	#package : 'Foliage-Publisher'
}

{ #category : 'accessing' }
FOPublisherCommand class >> commandSpecification [
	<commandline>
	^(ClapCommandSpec id: 'publish')
				description: 'Publish foliage project';
				addHelp ;
				commandClass: self;
				addFlagWithPositional: 'source' description: 'Site input files location';
				addFlagWithPositional: 'target' description: 'Generated output location';
				
				addPositional: 'project' spec: [ :positional |
						positional
							description: 'STON file describing project (default is Foliage.ston)';
							defaultValue: [ :match | FOPublisher defaultProjectFileName ] ];
				yourself
]

{ #category : 'clap' }
FOPublisherCommand >> configure [

	(self hasFlag: #source)
		ifTrue: [ publisher sourcePath: self source ].
	(self hasFlag: #target)
		ifTrue: [ publisher targetPath: self target ].	
	
]

{ #category : 'clap' }
FOPublisherCommand >> execute [ 

	self configure.
	publisher publish
]

{ #category : 'initialize' }
FOPublisherCommand >> initialize [

	super initialize.
	publisher := FOPublisher new. 
	
]

{ #category : 'accessing' }
FOPublisherCommand >> publisher [ 

	^ publisher
]

{ #category : 'accessing' }
FOPublisherCommand >> source [
	^ self positional: #source
]

{ #category : 'accessing' }
FOPublisherCommand >> target [
	^ self positional: #target
]
