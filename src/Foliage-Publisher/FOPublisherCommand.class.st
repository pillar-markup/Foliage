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
FOPublisherCommand class >> specification [

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
				defaultValue: [ :match | self defaultProjectFileName ] ]
				yourself );
		yourself
]

{ #category : 'clap' }
FOPublisherCommand >> readFile: aName [

	| reference |
	reference := aName asFileReference.
	reference exists ifFalse: [ 
		self error: ('File {1} does not exists' format: { reference fullName }) ].
	
	^ [ (STONReader on: reference readStream) next ]
		on: Error 
		do: [ :e | 
			self error: ('Error reading file {1}: {2}' 
				format: { reference fullName. e messageText }) ]
]
