Class {
	#name : 'FOPublicationList',
	#superclass : 'Object',
	#instVars : [
		'workingDirectory',
		'authorMatchingString',
		'keysOfBlackListedEntries',
		'workingBibSet',
		'shouldFilterNonPublic',
		'localization',
		'years',
		'fieldOrder',
		'originalBibSet',
		'bodySpecification',
		'noEmptySection',
		'sections'
	],
	#category : 'Foliage-Bib-Core',
	#package : 'Foliage-Bib',
	#tag : 'Core'
}

{ #category : 'queries' }
FOPublicationList >> PhDAndHabilitationQuery [
	^ CZQuery PhDAndHabilitation
]

{ #category : 'visiting' }
FOPublicationList >> acceptFOVisitor: aFOVisitor [

	self halt.
]

{ #category : 'intersections' }
FOPublicationList >> addEntitledSection: aString withBibEntries: entries [

	self addSection: (FOSection new
			 title: aString;
			 items: (CZSet new
					  addAll: entries;
					  yourself) 
					yourself)
]

{ #category : 'intersections' }
FOPublicationList >> addSection: aSection [


	sections add: aSection
]

{ #category : 'intersections' }
FOPublicationList >> addSectionFromQuery: aQuery withTitle: aString [
	"Adding a section just add a section and a list of entries following it.
	By default, empty sections are not created and entries are sorted to get more recent on the top. 
	Pay attention that the items of a section are a new group of items."

	| entries |
	entries := workingBibSet select: aQuery.
	noEmptySection & entries size isZero ifTrue: [ ^ self ].
	entries sortByDateReverse.
	self addEntitledSection: aString withBibEntries: entries
]

{ #category : 'private' }
FOPublicationList >> allowEmptySections [
	"It can be useful for document or bibfile debugging purposes to see the empty section of a document. By default it is turn off. "

	noEmptySection := false
]

{ #category : 'queries' }
FOPublicationList >> annotationWithType: aString [

	^  CZQuery annotationWithType: aString
]

{ #category : 'accessing' }
FOPublicationList >> authorMatchingString [
	^ authorMatchingString
]

{ #category : 'main configuration' }
FOPublicationList >> authorMatchingString: aString [

	authorMatchingString := aString
]

{ #category : 'queries' }
FOPublicationList >> authorQuery [

	^ CZFieldQuery 
		named: #author 
		checks: [ :value | self authorMatchingString match: value ]
]

{ #category : 'accessing' }
FOPublicationList >> bibset [
	^ workingBibSet 
]

{ #category : 'private' }
FOPublicationList >> bibset: aBibSet [
	"We copy the original to be sure that we can always refer to it, even if we destructively change the working set."
	originalBibSet := aBibSet.
	aBibSet scope: CZSet standardDefinitions.
	workingBibSet := aBibSet copy
]

{ #category : 'accessing' }
FOPublicationList >> bodySpecification [

	^ bodySpecification ifNil: [ bodySpecification := self defaultSpecification ]
]

{ #category : 'queries' }
FOPublicationList >> bookChapterQuery [
	^ CZQuery bookChapter
]

{ #category : 'queries' }
FOPublicationList >> bookQuery [
	^ CZQuery book
]

{ #category : 'queries' }
FOPublicationList >> bookletQuery [
	^ CZQuery booklet
]

{ #category : 'private' }
FOPublicationList >> build [
	"Build the current document: filter entities that not desirable and build the document body."
	
	self filter.
	self buildBody.
]

{ #category : 'private' }
FOPublicationList >> buildBody [

	self bodySpecification do: [ :each |
			self
				addSectionFromQuery: (self perform: (each , #Query) asSymbol)
				withTitle: (localization perform: each) ]

]

{ #category : 'main configuration' }
FOPublicationList >> configure [

	self 
		fileNamed: 'rmod.bib';
		authorMatchingString: '*', 'Ducasse', '*';
		keysOfBlackListedEntries: #(Berg13b Berg16a Denk14a Denk15a Denk16a Denk18a Denk19a Denk20a Denk21a Anqu17a Denk22a);
		setFilteringOfNonPublicOn
]

{ #category : 'initialization' }
FOPublicationList >> defaultFieldOrder [

	^ #(#author #editor #title #chapter #journal #booktitle #volume #pages #publisher #collection #school #year #pdf)
]

{ #category : 'initialization' }
FOPublicationList >> defaultKeysOfBlackListedEntries [ 

	^ #()
]

{ #category : 'initialization' }
FOPublicationList >> defaultSectionSpecification [

	^ #(#internationalJournal  #topConference #internationalConference #nationalJournal #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #toolDemo #vulgarisation #technicalReport #PhDAndHabilitation)
]

{ #category : 'initialization' }
FOPublicationList >> defaultSpecification [

	^ #( #internationalJournal #nationalJournal #topConference #internationalConference #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #toolDemo #vulgarisation #PhDAndHabilitation)
]

{ #category : 'queries' }
FOPublicationList >> deliverableQuery [
	^ CZQuery deliverable
]

{ #category : 'private' }
FOPublicationList >> doNotAllowEmptySections [

	noEmptySection := true
]

{ #category : 'queries' }
FOPublicationList >> editorQuery [
	"We refine it for a single author!: the entrie is flagged as workshopproceeddings or as editor. This way papers written by the author that is also editor will not be mixed in the editor zone."

	"we know that this is in the author entries, so he is an editor since he marked it"
	^ (self annotationWithType: '*workshopproceedings*') OR: (self annotationWithType: '*editor*')
	
]

{ #category : 'main configuration' }
FOPublicationList >> english [

	localization english
]

{ #category : 'accessing' }
FOPublicationList >> fieldOrder: aCol [
	"To specify the order and fields that should be displayed, for example, 
	#(#author #title #chapter #journal #booktitle #volume #pages #publisher #school #year #url #doi)."

	fieldOrder := aCol
]

{ #category : 'files' }
FOPublicationList >> fileNamed: aStringDotBib [
	"Parser and set the bib file."
	
	self onStream: (workingDirectory resolve: aStringDotBib) readStream
]

{ #category : 'private' }
FOPublicationList >> filter [
	"Filter insubmission and other blacklisted entries"

	self shouldFilterNonPublic
		ifFalse: [ ^ self ].
	workingBibSet := workingBibSet reject: self inSubmissionQuery.
	workingBibSet := workingBibSet
		reject: [ :each | keysOfBlackListedEntries includes: each key ].
		
	"set the working set to only the author entries"
	workingBibSet := workingBibSet select: (self authorQuery OR: self editorQuery)
]

{ #category : 'main configuration' }
FOPublicationList >> french [

	localization french
]

{ #category : 'initialization' }
FOPublicationList >> generateFor: aDoc on: aStream [

	| visitor |
	visitor := self configureGenerator.
	fieldOrder ifNotNil: [ visitor fieldOrder: fieldOrder ].
	visitor outputStream: aStream.
	visitor visit: aDoc
]

{ #category : 'queries' }
FOPublicationList >> inSubmissionQuery [
	^ CZQuery inSubmission
]

{ #category : 'initialization' }
FOPublicationList >> initialize [

	super initialize.
	workingDirectory := FileSystem workingDirectory.
	self authorMatchingString: '*'.
	localization := self localizationClass new.
	self english.
	self fieldOrder: self defaultFieldOrder.
	self setFilteringOfNonPublicOn.
	self keysOfBlackListedEntries: self defaultKeysOfBlackListedEntries.
	years := 1990 to: Year currentYearNumber.
	self doNotAllowEmptySections.
	sections := OrderedCollection new
]

{ #category : 'queries' }
FOPublicationList >> internationalConferenceQuery [

	^ (self annotationWithType:  '*internationalconference*') AND: (self topConferenceQuery) NOT
]

{ #category : 'queries' }
FOPublicationList >> internationalJournalQuery [

	^ (CZFieldQuery 
			named: #annote 
			checks: [ :value | '*internationaljournal*' match: value ])
]

{ #category : 'queries' }
FOPublicationList >> internationalWorkshopQuery [
	^ CZQuery internationalWorkshop
]

{ #category : 'queries' }
FOPublicationList >> invitedPaperQuery [

	^ self annotationWithType:  '*invited*'
]

{ #category : 'queries' }
FOPublicationList >> invitedQuery [

	^ self annotationWithType:  '*invited*'
]

{ #category : 'queries' }
FOPublicationList >> journalQuery [
	^ CZQuery journal
]

{ #category : 'main configuration' }
FOPublicationList >> keysOfBlackListedEntries [
	"Returns the list of entities (identfied via their bib key) that should not be taken into account when building a document."
	
	^ keysOfBlackListedEntries
]

{ #category : 'accessing' }
FOPublicationList >> keysOfBlackListedEntries: aCol [

	keysOfBlackListedEntries := aCol
]

{ #category : 'main configuration' }
FOPublicationList >> localizationClass [
	^ CZLocalisation
]

{ #category : 'queries' }
FOPublicationList >> nationalConferenceQuery [
	"pay attention not to put a star else internationalconference will be matched too"

	^ CZQuery nationalConference
]

{ #category : 'queries' }
FOPublicationList >> nationalJournalQuery [
	^ CZQuery nationalJournal
]

{ #category : 'queries' }
FOPublicationList >> nationalWorkshopQuery [
	^ CZQuery nationalWorkshop
]

{ #category : 'private' }
FOPublicationList >> onStream: aStream [

	| bibset2 |
	bibset2 := CZBibParser parse: aStream contents.
	bibset2 scope: CZSet standardDefinitions.
	self bibset: bibset2
	
]

{ #category : 'queries' }
FOPublicationList >> periodicalQuery [
	^ CZQuery periodical
]

{ #category : 'private' }
FOPublicationList >> publishToWebSite: aWebSite withPath: aPath [

	
]

{ #category : 'intersections' }
FOPublicationList >> sections [

	^ sections
]

{ #category : 'main configuration' }
FOPublicationList >> setFilteringOfNonPublicOff [
	"to filter private entries and others insubmissions"
	
	shouldFilterNonPublic := false
]

{ #category : 'main configuration' }
FOPublicationList >> setFilteringOfNonPublicOn [
	"to filter private entries and others insubmissions"
	
	shouldFilterNonPublic := true
]

{ #category : 'main configuration' }
FOPublicationList >> setFilteringOff [

	shouldFilterNonPublic := false
]

{ #category : 'main configuration' }
FOPublicationList >> setFilteringOn [
	"to filter private entries and others insubmissions"
	
	shouldFilterNonPublic := true
]

{ #category : 'main configuration' }
FOPublicationList >> setLanguage: aSymbol [
	"right now only english and french are managed."
	
	| language |
	language := (#(english french) includes: aSymbol) 
		ifFalse: [ #english ]
		ifTrue: [ aSymbol ].
	self perform: aSymbol
]

{ #category : 'main configuration' }
FOPublicationList >> shouldFilterNonPublic [

	^ shouldFilterNonPublic
]

{ #category : 'queries' }
FOPublicationList >> teamEntryQuery [
	^ CZQuery teamEntry
]

{ #category : 'queries' }
FOPublicationList >> technicalReportQuery [
	^ CZQuery techReport
]

{ #category : 'queries' }
FOPublicationList >> toolDemoQuery [
	^ CZQuery toolDemo
]

{ #category : 'queries' }
FOPublicationList >> topConferenceQuery [
	^ CZQuery topConference
]

{ #category : 'private' }
FOPublicationList >> treatBody [
	self bodySpecification
		do: [ :each |  
					self 
						addSectionFromQuery: (self perform: (each, #Query) asSymbol)  
						withTitle: (localization perform: each) ] 
				
]

{ #category : 'queries' }
FOPublicationList >> vulgarisationQuery [
	^ CZQuery vulgarisation
]

{ #category : 'accessing' }
FOPublicationList >> workingBibSet [ 
	
	^ workingBibSet
]

{ #category : 'accessing' }
FOPublicationList >> workingDirectory: aWorkingDirectory [ 
	
	workingDirectory := aWorkingDirectory
]

{ #category : 'accessing' }
FOPublicationList >> years: aCollection [ 
	years := aCollection
]
