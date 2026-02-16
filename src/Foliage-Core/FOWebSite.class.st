"
I'm the main entity holding information relative to the site (uri, path) but also model (various files).
I'm populated by FOReader subclasses.

As a model I store 
- image files (basically just a file reference)
- pillar files (for these I parse the microdown and convert it to pillar. 
- my root is a FoWebSiteRoot that manages the model entities as a file trees.

This is on the subclasses of `FOWebResource` that a publisher visitor will create the concrete website.

Here is a way to get a live site

```
FOWebSite new 
	baseUri: 'http://pharo.org';
	rawPath: '/Users/ducasse/Test2/pharo-website/site';
	templatePath: '/Users/ducasse/Test2/pharo-website/site' asFileReference / 'templates'; 
	importFiles
```
"
Class {
	#name : 'FOWebSite',
	#superclass : 'Object',
	#instVars : [
		'targetPath',
		'templatePath',
		'root',
		'plugins',
		'sourcePath',
		'fileSystem',
		'configuration'
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

{ #category : 'accessing items' }
FOWebSite >> / aName [
	"Access the model entity associated with the path aName"
	
	^ root / aName
]

{ #category : 'helpers' }
FOWebSite >> absoluteLinkFor: aFOWebResource [

	^ self baseUri asZnUrl / aFOWebResource pathString  
]

{ #category : 'visiting' }
FOWebSite >> acceptFOVisitor: aFOVisitor [ 
	^ aFOVisitor visitWebsite: self 
]

{ #category : 'initialization' }
FOWebSite >> addPluginHandlerClass: aPluginHandlerClass for: akindKey [

	plugins at: akindKey put: aPluginHandlerClass
]

{ #category : 'accessing items' }
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
	^ configuration baseUri
]

{ #category : 'accessing' }
FOWebSite >> baseUri: anObject [
	"Expect the base of the website including the http
	e.g., FOWebSite new baseUri: 'https://pharo.org'."
	
	configuration baseUri: anObject
]

{ #category : 'building' }
FOWebSite >> build [

	self importFiles.
	self configureFromConfigFile.
	self handlePlugins. 
]

{ #category : 'building' }
FOWebSite >> buildOverviewFor: aString [ 
	
	| blog |
	blog := self / aString.
	blog at: #'index.html' put: blog overviewPage.  
]

{ #category : 'initialization' }
FOWebSite >> buildRoot [

	^ FOWebsiteRoot new
		parent: self 
]

{ #category : 'accessing-blogs' }
FOWebSite >> configureBlogsFrom: blogSpecs [
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
	
	self readConfigFile.
	self configureBlogsFrom: configuration blogs.
]

{ #category : 'defaults' }
FOWebSite >> defaultSourcePath [

	^ 'site'
]

{ #category : 'defaults' }
FOWebSite >> defaultTargetPath [
	^ 'generated'
]

{ #category : 'defaults' }
FOWebSite >> defaultTemplatePath [ 
	^ 'templates'
]

{ #category : 'accessing - for tests' }
FOWebSite >> fileSystem [

	^ fileSystem
]

{ #category : 'accessing - for tests' }
FOWebSite >> fileSystem: aFileSystem [

	fileSystem := aFileSystem.
	self initializePaths.
]

{ #category : 'importing' }
FOWebSite >> handlePlugins [
	"for now only top level: make it work, make it right, make it better"
	
	
	| topElementsWithPlugin |
	topElementsWithPlugin := self root items 
		select: [ :each | (each respondsTo: #meta)
			ifTrue: [  each hasPlugin ] 
			ifFalse: [ false ] ].
	topElementsWithPlugin do: [ :elemenWithPlugin | 
		self 
			pluginHandle: elemenWithPlugin plugin
			for: elemenWithPlugin ]
]

{ #category : 'building' }
FOWebSite >> importDirectory: path [
	"Populate the site by creating a model for each of the file of path"
	self importer readAll: path allFiles
]

{ #category : 'building' }
FOWebSite >> importFiles [
	
	self readConfigFile.
	self importDirectory: self sourcePath
]

{ #category : 'initialization' }
FOWebSite >> importer [
	"Creates a new importer associated with the website."
	
	^ FOImporter new 
		website: self;
		yourself
]

{ #category : 'initialization' }
FOWebSite >> initialize [

	super initialize.
	self fileSystem: FileSystem disk.
	configuration := FOConfigurationFile new.	
	root := self buildRoot.
	self registerPlugins.
	
]

{ #category : 'initialization' }
FOWebSite >> initializePaths [
	" not sure that this is needed may the publisher responsibility is to gather and push these
	values to the website. "
	
	self sourcePath: self defaultSourcePath.
	self targetPath: self defaultTargetPath.
	self templatePath: self defaultTemplatePath.
]

{ #category : 'plugins' }
FOWebSite >> pluginHandle: aString for: aFOMicrodownPage [ 
	
	"
	here we could change the class of the file to be a PublicationPage
	See convertToBlog for an idea how to do it and without duplication
	"
	| handlerClass |

	handlerClass :=
		FOPluginHandler subclasses 
			detect: [ :cls | 
				cls kind = aFOMicrodownPage pluginKind ]
			ifNone: [ Error signal: 'Unknown plugin ',  aFOMicrodownPage pluginKind ]	.
	
	"We return it so that we can get information for test"
	^ handlerClass new
		webSite: self;
		treat: aFOMicrodownPage;
		yourself
	
]

{ #category : 'building' }
FOWebSite >> publish [

	FOPublishVisitor new visit: self

]

{ #category : 'accessing' }
FOWebSite >> rawPath [
	self deprecated: '' transformWith: '`@receiver rawPath' -> '`@receiver sourcePath'.
	^ sourcePath 
]

{ #category : 'accessing' }
FOWebSite >> rawPath: anObject [
	"To define a physical file reference"
	self deprecated: '' transformWith: '`@receiver rawPath: `@arg' -> '`@receiver sourcePath: `@arg'.
	sourcePath := anObject asFileReference 
]

{ #category : 'building' }
FOWebSite >> readConfigFile [

	| dict |
	dict := self readConfigFile: 'FoliageConfig.ston'.
	dict keysAndValuesDo: [ :k :v | 
		configuration propertyAt: k put: v ].
	^ configuration
]

{ #category : 'importing' }
FOWebSite >> readConfigFile: aName [

	| reference |
	reference := sourcePath / aName.
	reference exists ifFalse: [ 
		self error: ('File {1} does not exists' format: { reference fullName }) ].
	
	^ [ (STONReader on: reference readStream) next ]
		on: Error 
		do: [ :e | 
			self error: ('Error reading file {1}: {2}' 
				format: { reference fullName. e messageText }) ]
	
]

{ #category : 'initialization' }
FOWebSite >> registerPlugins [

	plugins := Dictionary new. 
	"do not really like such a way of filling up 
	but else this is unclear how an extension can refer to a website."
	
	FOPluginHandler subclasses do: [ :cl | 
		self addPluginHandlerClass: cl for: cl kind ]
	
]

{ #category : 'helpers' }
FOWebSite >> relativeRawPath: aFileReference [
	
	^ aFileReference relativeTo: self sourcePath 
]

{ #category : 'navigating' }
FOWebSite >> resolvePath: aPath [ 
	^ root resolvePath: aPath
]

{ #category : 'accessing' }
FOWebSite >> root [
	^ root
]

{ #category : 'accessing deployment' }
FOWebSite >> sourcePath [

	^ sourcePath
]

{ #category : 'accessing deployment' }
FOWebSite >> sourcePath: aString [
	"sourcePath: is expected to be a subdirectory of / e.g. 
	/usr/site"
	aString isString not ifTrue: [ self error: 'sourcePath: expects a string' ].
	
	sourcePath := fileSystem referenceTo: aString
]

{ #category : 'accessing deployment' }
FOWebSite >> targetPath [

	^ targetPath 
]

{ #category : 'accessing deployment' }
FOWebSite >> targetPath: anObject [

	anObject isString not ifTrue: [ self error: 'targetPath expects a string' ].	
	targetPath := fileSystem referenceTo: anObject
]

{ #category : 'accessing' }
FOWebSite >> targetPathFor: aWebObject [
	^ self targetPath resolvePath: aWebObject path
]

{ #category : 'accessing' }
FOWebSite >> templatePath [
	^ templatePath 
]

{ #category : 'accessing' }
FOWebSite >> templatePath: anObject [
	anObject isString not ifTrue: [ self error: 'templatePath expects a string' ].
	
	templatePath := fileSystem referenceTo: anObject
]

{ #category : 'helpers' }
FOWebSite >> templatePathForLayout: aString [ 
	^ self templatePath / aString
]

{ #category : 'helpers' }
FOWebSite >> templatePathForLayout: aString  partial: partialName [
	^ self templatePath / partialName
]

{ #category : 'accessing' }
FOWebSite >> webRootPrefix [
	
	^ configuration webRootPrefix
]

{ #category : 'accessing' }
FOWebSite >> webRootPrefix: aString [
	
	configuration webRootPrefix: aString
]
