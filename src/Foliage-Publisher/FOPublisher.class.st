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
				description: 'STON file describing project (default .foliage.ston)';
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
		
	^ '.foliage.ston'
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

	baseUri := aString
]

{ #category : 'accessing' }
FOPublisher >> blogs [

	^ blogs ifNil: [ #() ]
]

{ #category : 'accessing' }
FOPublisher >> blogs: aColOfPairOfFolderNamesToTitles [
	"| p |
	p := FOPublisher new. 
	p blogs: {
		'news' -> 'Pharo News' . 
		'success' ->'Pharo Success Stories'  }."


	blogs := aColOfPairOfFolderNamesToTitles
]

{ #category : 'actions' }
FOPublisher >> configureBlogs [
	"During the configuration of blogs, pages are converted to blog post objects in the model."
	
	self blogs do: [ :assoc |
		| blog |
		"this logic should not be in the publisher
		but in the website and it should call the blog. "
		blog := (site / assoc key) convertToBlog.
		blog title: assoc value.
		blog
			at: #'index.html' put: blog overviewPage";
			at: #'rss.xml' put: blog rssFeed".
		blog emit
		"blog rssFeed addHeadersTo: blog / 'index.html'" ].
]

{ #category : 'actions' }
FOPublisher >> configureNewWebSite [

	^ FOWebSite new
		  baseUri: self baseUri;
		  targetPath: self targetPath;
		  rawPath: self sourcePath;
		  templatePath: self sourcePath asFileReference / self templatePath asString
]

{ #category : 'actions' }
FOPublisher >> publish [

	|  configurationInstance |
	('Publishing: ' , self baseUri) emit.
	
	site := self configureNewWebSite.
	site importFiles.

	('Imported ' , site allFiles size asString , ' files') emit.


	"basically using the command line we get an instance of FOPublisher that is configured 
	based on the command argument. This is not nice for tests and to interactively develop.
	No I do not want to close pharo, type a command to get it. "	
	configurationInstance := self class readFile: (site rawPath asFileReference / self class defaultProjectFileName asString). 
	site baseUri: configurationInstance baseUri.
	self blogs: configurationInstance blogs. 	

	self configureBlogs.

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
