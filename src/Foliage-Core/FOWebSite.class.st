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
		'targetPath',
		'templatePath',
		'rawPath',
		'model',
		'root',
		'properties'
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

{ #category : 'building' }
FOWebSite >> buildOverviewFor: aString [ 
	
	| blog |
	blog := self / aString.
	blog at: #'index.html' put: blog overviewPage.  
]

{ #category : 'accessing' }
FOWebSite >> buildRoot [
	^ FOWebsiteRoot new
		parent: self 
]

{ #category : 'accessing' }
FOWebSite >> defaultTargetPath [
	^ 'docs'
]

{ #category : 'accessing' }
FOWebSite >> defaultTemplatePath [ 
	^ 'templates'
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
	root := self buildRoot.

	rawPath := '' asFileReference
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
