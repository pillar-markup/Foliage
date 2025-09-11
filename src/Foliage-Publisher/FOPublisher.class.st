"
I'm a simple object responsible of configuring the system and launch the publishing process. 
Check the implementations of the publish methods - each kind of objects has its own way.

Here are some random notes so that I understand something. 

### Download 

```
http://github.com/pharo-project/pharo-website
then 
> co WithFoliage20
```


```
| l p |
Transcript open. 
l := TranscriptLogger new.
p := FOPublisher new. 
p baseUri: 'http://pharo.org'.
p sourcePath: '/Users/ducasse/Test2/pharo-website/site'.
l runDuring: [ p publish ].
```


### On the command line
```
pharo-ui /Users/ducasse/Documents/Pharo/images/P13Foliage3/P13Foliage3.image clap foliage publish --source /Users/ducasse/Test2/pharo-website/site --target /home/ducasse/Test2/foliage/test/ /Users/ducasse/Test2/pharo-website/site/.foliage.ston
```


### Should investigate more

```
FOPublisher commandLine activateWith: {
    'foliage'.
    'publish'.
    '--source'. '/Users/ducasse/Test2/pharo-website/site'.
    '--target'. '/home/ducasse/Test2/foliage/test/'.
    '/Users/ducasse/Test2/pharo-website/site/.foliage.ston' }.
```

Apparently the configuration file .foliage.ston defines the blogs,

```

Foliage {
	#baseUri: 'http://pharo.org',
	#blogs: [ 
		'news': 'Pharo News', 
		'success': 'Pharo Success Stories' 
	]
}
```

## Example to generate my website

```
p := FOPublisher new. 
p baseUri: 'StephaneDucasse.github.io'.
p sourcePath: '/Users/ducasse/Test2/MySite/StephaneDucasse.github.io/site'.
p targetPath: '/Users/ducasse/Test2/MySite/StephaneDucasse.github.io/generated'.
p publish.
```
"
Class {
	#name : 'FOPublisher',
	#superclass : 'Object',
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

{ #category : 'clap - commands' }
FOPublisher class >> clapPublish: args [
	
	self withLoggingDo: [ 
		self withErrorHandlingDo: [
			| publisher |
			
			publisher := self readFile: (args at: #project) value. 
			args at: #target ifPresent: [ :arg | publisher targetPath: (arg at: #path) value ].
			args at: #source ifPresent: [ :arg | publisher sourcePath: (arg at: #path) value ].
			publisher publish ] ]
]

{ #category : 'clap' }
FOPublisher class >> commandLine [
	<commandline>
	
	^ (ClapCommandSpec id: 'foliage')
		description: 'Foliage publisher';
		add: ClapFlag forHelp;
		add: ((ClapCommandSpec id: 'publish')
			description: 'Publish foliage project';
			add: ClapFlag forHelp;
			add: ((ClapFlag id: 'source')
				description: 'Site input files location';
				add: ((ClapPositional id: 'path')
					description: 'Path to source';
					yourself);
				yourself);
			add: ((ClapFlag id: 'target')
				description: 'Generated output location';
				add: ((ClapPositional id: 'path')
					description: 'Path to destination';
					yourself);
				yourself);
			add: ((ClapPositional id: 'project')
				implicitMeaning: [ self defaultProjectFileName ];
				description: 'STON file describing project (default is Foliage.ston)';
				yourself);
			meaning: [ :args |
				args at: #helpFlag ifPresent: [ :help | 
					help value; exitSuccess ].
				self clapPublish: args ];
			yourself);
		meaning: [ :args | 
			args at: #helpFlag ifPresent: [ :help | 
				help value; exitSuccess ].
			args validateAll ];
		yourself
]

{ #category : 'clap - defaults' }
FOPublisher class >> defaultProjectFileName [
		
	^ 'Foliage.ston'
]

{ #category : 'defaults' }
FOPublisher class >> defaultSourcePath [

	^ '.'
]

{ #category : 'defaults' }
FOPublisher class >> defaultTargetPath [

	^ 'generated'
]

{ #category : 'defaults' }
FOPublisher class >> defaultTemplatePath [

	^ 'templates'
]

{ #category : 'clap' }
FOPublisher class >> readFile: aName [

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

{ #category : 'ston-core' }
FOPublisher class >> stonName [

	^ #Foliage
]

{ #category : 'clap' }
FOPublisher class >> withErrorHandlingDo: aBlock [

	aBlock value. 
	"aBlock 
		on: Error 
		do: [ :e | "
	"	NonInteractiveTranscript stderr crShow: e messageText.
			Exit signalFailure ]"
]

{ #category : 'clap' }
FOPublisher class >> withLoggingDo: aBlock [

	FOStdoutLogger start.
	aBlock ensure: [ FOStdoutLogger stopAll ]
]

{ #category : 'accessing' }
FOPublisher >> baseUri [

	^ baseUri
]

{ #category : 'accessing' }
FOPublisher >> baseUri: aString [
	"Expect the base of the website including the http
	e.g., FOWebSite new baseUri: 'https://pharo.org'."
	
	baseUri := aString
]

{ #category : 'accessing' }
FOPublisher >> blogs [
	^ blogs
]

{ #category : 'actions' }
FOPublisher >> newWebSite [

	^ FOWebSite new
		  baseUri: self baseUri;
		  targetPath: self targetPath;
		  rawPath: self sourcePath;
		  templatePath: self sourcePath asFileReference / self templatePath asString
]

{ #category : 'actions' }
FOPublisher >> publish [

	site := self newWebSite.
	
	"this should probably pushed to the website"
	site importFiles.
	site configureFromConfigFile.
	site handlePlugins.
	
	site publish.
]

{ #category : 'accessing' }
FOPublisher >> sourcePath [

	^ sourcePath 
			ifNil: [ 
					self sourcePath: self class defaultSourcePath. 
					^ sourcePath ]
]

{ #category : 'accessing' }
FOPublisher >> sourcePath: aString [

	sourcePath := aString asFileReference
]

{ #category : 'accessing' }
FOPublisher >> targetPath [
	
	^ targetPath 
		ifNil: [ self targetPath: self class defaultTargetPath. ^ targetPath ]
]

{ #category : 'accessing' }
FOPublisher >> targetPath: aString [

	targetPath := aString
]

{ #category : 'accessing' }
FOPublisher >> templatePath [

	^ templatePath ifNil: [ self templatePath: self class defaultTemplatePath. ^ templatePath ]
]

{ #category : 'accessing' }
FOPublisher >> templatePath: aString [

	templatePath := aString
]
