"
I'm the main entity holding information relative to the site (uri, path) but also model (various files).
I'm populated by FOReader subclasses.

As a model I store 
- image files (basically just a file reference)
- pillar files (for these I parse the microdown and convert it to pillar. 
- my root is a FoWebSiteRoot that manages the model entities as a file trees.

This is on the subclasses of `FOWebResource` that a publisher visitor will create the concrete website.


"
Class {
	#name : 'FOWebSite',
	#superclass : 'Object',
	#instVars : [
		'baseUri',
		'blogs',
		'targetPath',
		'templatePath',
		'rawPath',
		'model',
		'root',
		'properties',
		'blogSpecs'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'Foliage-Core-Model',
	#package : 'Foliage-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
FOWebSite class >> build [
	^ self instance build
]

{ #category : 'instance creation' }
FOWebSite class >> instance [
	^ instance ifNil: [ 
		instance := self new ]
]

{ #category : 'resetting' }
FOWebSite class >> reset [
	instance := nil
]

{ #category : 'arithmetic' }
FOWebSite >> / anObject [
	^ root / anObject
]

{ #category : 'accessing' }
FOWebSite >> absoluteLinkFor: aFOWebResourece [
	^ baseUri asZnUrl / (aFOWebResourece pathString)  
]

{ #category : 'visiting' }
FOWebSite >> acceptFOVisitor: aFOVisitor [ 
	^ aFOVisitor visitWebsite: self 
]

{ #category : 'enumerating' }
FOWebSite >> allFiles [

	^ self rawPath allFiles
]

{ #category : 'logging' }
FOWebSite >> asBeaconSignal [

	^ FOObjectSignal new 
		object: self;
		slots: #(baseUri targetPath templatePath rawPath);
		yourself
]

{ #category : 'accessing' }
FOWebSite >> baseUri [
	^ baseUri
]

{ #category : 'accessing' }
FOWebSite >> baseUri: anObject [
	baseUri := anObject
]

{ #category : 'accessing-blogs' }
FOWebSite >> blogSpecs: aColOfPairOfFolderNamesToTitles [
	"| p |
	p := FOPublisher new. 
	p blogs: {
		'news' -> 'Pharo News' . 
		'success' ->'Pharo Success Stories'  }."
	blogSpecs := aColOfPairOfFolderNamesToTitles
]

{ #category : 'building' }
FOWebSite >> buildOverviewFor: aString [ 
	
	| blog |
	blog := self / aString.
	blog at: #'index.html' put: blog overviewPage.  
]

{ #category : 'as yet unclassified' }
FOWebSite >> buildPublicationPage: aString [ 
	
	"contrary to blog post there is no need to create an index.html
	This may be the case for the virtual page"
	
	| p |
	p := FOPublicationList new.
	p workingDirectory: self rawPath.
	p fileNamed:'rmod.bib'.
	p authorMatchingString: '*', 'Ducasse', '*'.
	p setFilteringOfNonPublicOff.
	p build.
	^ p
	

]

{ #category : 'accessing' }
FOWebSite >> buildRoot [
	^ FOWebsiteRoot new
		parent: self 
]

{ #category : 'accessing-blogs' }
FOWebSite >> configureBlogs [
	"During the configuration of blogs, pages are converted to blog post objects in the model."
	
	"This could be managed in a more modular fashion via a plugin architecture if needed."
	blogSpecs do: [ :assoc |
		| blog |
		blog := (self / assoc key) convertToBlog.
		blog title: assoc value.
		blog
			at: #'index.html' put: blog overviewPage";
			at: #'rss.xml' put: blog rssFeed".
		
		"blog rssFeed addHeadersTo: blog / 'index.html'" ].
]

{ #category : 'importing' }
FOWebSite >> configureFromConfigFile [
	
	| instance |
	instance := self readConfigFile: (self rawPath asFileReference / 'FoliageConfig.ston').
	self baseUri: instance baseUri.
		
	self blogSpecs: instance blogs.
	self configureBlogs.
]

{ #category : 'defaults' }
FOWebSite >> defaultTargetPath [
	^ 'docs'
]

{ #category : 'defaults' }
FOWebSite >> defaultTemplatePath [ 
	^ 'templates'
]

{ #category : 'importing' }
FOWebSite >> handlePlugins [
	"We could check all the file and check plugins"
	
	"for now only top level: make it work, make it right, make it better"
	| plugins elemenWithPlugin |
	plugins := self root items select: [ :each | (each respondsTo: #meta)
				ifTrue: [  each meta
						at: #plugin 
						ifPresent: [ :string | true ]
						ifAbsent: [ false ] 
		] 
				ifFalse: [ false ]
	].	
	
	elemenWithPlugin := plugins asArray first.
	self pluginHandle: (elemenWithPlugin meta at: #plugin) for: elemenWithPlugin.
	
	self halt.
]

{ #category : 'building' }
FOWebSite >> importDirectory: path [ 
	self importer
		readAll: path allFiles
]

{ #category : 'building' }
FOWebSite >> importFiles [
	self importDirectory: self rawPath 
]

{ #category : 'accessing' }
FOWebSite >> importer [
	"Creates a new importer associated with the website."
	
	^ FOImporter new 
		website: self;
		yourself
]

{ #category : 'initialization' }
FOWebSite >> initialize [ 
	super initialize.
	properties := Dictionary new.
	blogSpecs := OrderedCollection new. 
	root := self buildRoot.

	rawPath := '' asFileReference
]

{ #category : 'as yet unclassified' }
FOWebSite >> pluginHandle: aString for: aFOMicrodownPage [ 
	
	"
	here we could change the class of the file to be a PublicationPage
	See convertToBlog for an idea how to do it and without duplication
	"
	| p sections |
	self halt.
		p := FOPublicationList new.
		"so ugly"
		p onStream:  (root  / 'rmod.bib') sourcePath asFileReference readStream.
		p authorMatchingString: '*', 'Ducasse', '*'.
		p build.
	sections := p sections.
	aFOMicrodownPage meta at: #sections put: sections.
		
	self halt.
]

{ #category : 'as yet unclassified' }
FOWebSite >> pluginHandleFor: aString [ 
	self shouldBeImplemented.
]

{ #category : 'accessing' }
FOWebSite >> properties [
	^ properties
]

{ #category : 'accessing' }
FOWebSite >> propertyAt: aString [ 
	^ properties at: aString
]

{ #category : 'accessing' }
FOWebSite >> propertyAt: aString put: anObject [
	^ properties 
		at: aString
		put: anObject 
]

{ #category : 'building' }
FOWebSite >> publish [

	FOPublishVisitor new visit: self

]

{ #category : 'accessing' }
FOWebSite >> rawPath [
	^ rawPath 
]

{ #category : 'accessing' }
FOWebSite >> rawPath: anObject [
	rawPath := anObject asFileReference 
]

{ #category : 'importing' }
FOWebSite >> readConfigFile: aName [

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

{ #category : 'accessing' }
FOWebSite >> relativeRawPath: aFileReference [
	^ aFileReference asAbsolute relativeTo: self rawPath asAbsolute 
]

{ #category : 'navigating' }
FOWebSite >> resolvePath: aPath [ 
	^ root resolvePath: aPath
]

{ #category : 'accessing' }
FOWebSite >> root [
	^ root
]

{ #category : 'accessing' }
FOWebSite >> targetPath [
	^ targetPath ifNil: [ 
		targetPath := self defaultTargetPath asFileReference ]
]

{ #category : 'accessing' }
FOWebSite >> targetPath: anObject [

	targetPath := anObject asFileReference
]

{ #category : 'accessing' }
FOWebSite >> targetPathFor: aWebObject [
	^ self targetPath resolvePath: aWebObject path
]

{ #category : 'accessing' }
FOWebSite >> templatePath [
	^ templatePath ifNil: [ 
		templatePath := self defaultTemplatePath asFileReference ]
]

{ #category : 'accessing' }
FOWebSite >> templatePath: anObject [
	templatePath := anObject asFileReference
]

{ #category : 'accessing' }
FOWebSite >> templatePathForLayout: aString [ 
	^ self templatePath / aString
]

{ #category : 'accessing' }
FOWebSite >> templatePathForLayout: aString  partial: partialName [
	^ self templatePath / partialName
]
