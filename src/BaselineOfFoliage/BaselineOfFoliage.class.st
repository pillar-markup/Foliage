Class {
	#name : 'BaselineOfFoliage',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfFoliage',
	#package : 'BaselineOfFoliage'
}

{ #category : 'baselines' }
BaselineOfFoliage >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		
		spec preLoadDoIt: #preload:package:.
		spec postLoadDoIt: #postloadWithLoader:withPackageSpec:.
		
		self
			mustache: spec; 
			soup: spec;
			zinc: spec.
			
		spec 
			package: 'Foliage-Core' with: [
				spec requires: #( 'Soup' 'Microdown') ];
			package: 'Foliage-Publisher' with: [
				spec requires: #('Foliage-Core') ];
			package: 'Foliage-Server' with: [
				spec requires: #('Foliage-Core') ];
			package: 'Foliage-Core-Tests' with: [
				spec requires: #('Foliage-Core') ].
		spec 
			group: 'Core' with: #('Foliage-Core' 'Foliage-Publisher');
			group: 'Publisher' with: #('Core' 'Foliage-Publisher');
			group: 'Tests' with: #('Foliage-Core-Tests' );
			group: 'default' with: #('Core' 'Tests');
			group: 'development' with: #('Core' 'Tests' 'ZincHTTPComponents') ]

]

{ #category : 'baselines' }
BaselineOfFoliage >> microdown: spec [
	spec baseline: 'Microdown' with: [
		spec 
			repository: 'github://pillar-markup/Microdown:dev/src''';
			loads: #( #'Microdown-HTMLExporter')].
]

{ #category : 'baselines' }
BaselineOfFoliage >> mustache: spec [
	spec baseline: 'Mustache' with: [
		spec 
			repository: 'github://noha/Mustache/repository';
			loads: #('Core')].
]

{ #category : 'baselines' }
BaselineOfFoliage >> postloadWithLoader: loader withPackageSpec: spec [

	| mic |
	mic := (IceRepository repositoryNamed: 'Microdown').
	(mic packageNamed: 'Microdown-Pillar') load.
	
]

{ #category : 'baselines' }
BaselineOfFoliage >> preload: loader package: packageSpec [
	"Ignore pre and post loads if already executed"

	| packagesToUnload mic |
packagesToUnload := ((PackageOrganizer default packages 
		select: [ :each | each name beginsWith: 'Microdown' ])  collect: [ :each | each name ]) 
		reject: [ :each |  
 	#('Microdown-RichTextPresenter' 'Microdown-RichTextPresenter-Tests') includes: each ].
	"these two are not managed by the microdown repo but the documentation.
	I should rename them in the future to avoid confusion"
	packagesToUnload := packagesToUnload asOrderedCollection.
	packagesToUnload add: 'BaselineOfMicrodown'.
	mic := (IceRepository repositoryNamed: 'Microdown').
	mic ifNotNil: [ 
		packagesToUnload do: 
			[ :each | 
				(mic packageNamed: each) unload ].
		mic delete ].

	#( 'Microdown' ) do: [ :name |
        (IceRepository repositoryNamed: name)
            ifNil: [ self inform: 'Project not found: ' , name ]
            ifNotNil: [ :found |
                found
                    unload;
                    forget ] ].

	Smalltalk globals
		at: #BaselineOfMicrodown 
		ifPresent: [ :c | c removeFromSystem ].
]

{ #category : 'baselines' }
BaselineOfFoliage >> soup: spec [
	spec baseline: 'Soup' with: [
		spec 
			repository: 'github://pharo-contributions/Soup';
			loads: #('Core')].
]

{ #category : 'baselines' }
BaselineOfFoliage >> zinc: spec [
	spec baseline: 'ZincHTTPComponents' with: [
		spec 
			repository: 'github://svenvc/zinc/repository';
			loads: #('Zinc-HTTP-Examples')].
]
