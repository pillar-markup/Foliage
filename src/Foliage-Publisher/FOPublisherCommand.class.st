Class {
	#name : 'FOPublisherCommand',
	#superclass : 'ClapApplication',
	#instVars : [
		'baseUri',
		'targetPath',
		'sourcePath',
		'templatePath',
		'blogs',
		'site'
	],
	#category : 'Foliage-Publisher',
	#package : 'Foliage-Publisher'
}

{ #category : 'accessing' }
FOPublisherCommand class >> commandSpecification [

	^ (ClapCommandSpec id: 'foliage')
		description: 'Foliage publisher';
		commandClass: self;
		addHelp;
		add: ((ClapCommandSpec id: 'publish')
				description: 'Publish foliage project';
				addHelp ;
				addFlagWithPositional: 'source' description: 'Site input files location';
				addFlagWithPositional: 'target' description: 'Generated output location';
				
				addPositional: 'project' spec: [ :positional |
						positional
							description: 'STON file describing project (default is Foliage.ston)';
							defaultValue: [ :match | FOPublisher defaultProjectFileName ] ]
				yourself );
		yourself
]

{ #category : 'clap' }
FOPublisherCommand >> execute [ 

	| publisher |
	publisher := FOPublisher new. 
	(self hasFlag: #source)
		ifTrue: [ publisher sourcePath: self source ].
	(self hasFlag: #target)
		ifTrue: [ publisher targetPath: self target ].	
	publisher publish
]

{ #category : 'clap' }
FOPublisherCommand >> source [
	^ self positional: #source
]

{ #category : 'clap' }
FOPublisherCommand >> target [
	^ self positional: #target
]
