Class {
	#name : 'FOPublicationListBuilder',
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
		'sections',
		'startYear',
		'endYear',
		'webSite'
	],
	#category : 'Foliage-Bib-Core',
	#package : 'Foliage-Bib',
	#tag : 'Core'
}

{ #category : 'queries' }
FOPublicationListBuilder >> PhDAndHabilitationQuery [
	^ CZQuery PhDAndHabilitation
]

{ #category : 'intersections' }
FOPublicationListBuilder >> addEntitledSection: aString withBibEntries: entries [

	self addSection: (MicPublicationSection new
			 title: aString;
			 items: (entries entries collect: [ :each | MicPublication new pub: each ]); 
					yourself)
]

{ #category : 'intersections' }
FOPublicationListBuilder >> addSection: aSection [

	sections add: aSection
]

{ #category : 'intersections' }
FOPublicationListBuilder >> addSectionFromQuery: aQuery withTitle: aString [
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
FOPublicationListBuilder >> allowEmptySections [
	"It can be useful for document or bibfile debugging purposes to see the empty section of a document. By default it is turn off. "

	noEmptySection := false
]

{ #category : 'queries' }
FOPublicationListBuilder >> annotationWithType: aString [

	^  CZQuery annotationWithType: aString
]

{ #category : 'accessing' }
FOPublicationListBuilder >> authorMatchingString [
	^ authorMatchingString
]

{ #category : 'main configuration' }
FOPublicationListBuilder >> authorMatchingString: aString [

	authorMatchingString :=  '*', aString, '*'
]

{ #category : 'queries' }
FOPublicationListBuilder >> authorQuery [

	^ CZFieldQuery 
		named: #author 
		checks: [ :value | self authorMatchingString match: value ]
]

{ #category : 'files' }
FOPublicationListBuilder >> bibFilename: aStringDotBib [
	"Parser and set the bib file."

	"self onStream: ((webSite root / aStringDotBib) sourcePath asFileReference) readStream"

	self onStream: (webSite sourcePath / aStringDotBib) readStream
]

{ #category : 'accessing' }
FOPublicationListBuilder >> bibset [
	^ workingBibSet 
]

{ #category : 'private' }
FOPublicationListBuilder >> bibset: aBibSet [
	"We copy the original to be sure that we can always refer to it, even if we destructively change the working set."
	originalBibSet := aBibSet.
	aBibSet scope: CZSet standardDefinitions.
	
]

{ #category : 'accessing' }
FOPublicationListBuilder >> bodySpecification [

	^ bodySpecification ifNil: [ bodySpecification := self defaultSpecification ]
]

{ #category : 'accessing' }
FOPublicationListBuilder >> bodySpecification: aColOfSymbols [
	"
	aColOfSymbols should be a selector amongst
		 #( #internationalJournal #nationalJournal #topConference #internationalConference #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #toolDemo #vulgarisation #PhDAndHabilitation) 
	"
	
	bodySpecification := aColOfSymbols
	
]

{ #category : 'queries' }
FOPublicationListBuilder >> bookChapterQuery [
	^ CZQuery bookChapter
]

{ #category : 'queries' }
FOPublicationListBuilder >> bookQuery [
	^ CZQuery book
]

{ #category : 'queries' }
FOPublicationListBuilder >> bookletQuery [
	^ CZQuery booklet
]

{ #category : 'private' }
FOPublicationListBuilder >> build [
	"Build the current document: filter entities that not desirable and build the document body."
	
	self filter.
	self buildBody.
]

{ #category : 'private' }
FOPublicationListBuilder >> buildBody [

	self bodySpecification do: [ :each |
			self
				addSectionFromQuery: (self perform: (each , #Query) asSymbol)
				withTitle: (localization perform: each) ]

]

{ #category : 'main configuration' }
FOPublicationListBuilder >> configure [

	self 
		fileNamed: 'rmod.bib';
		authorMatchingString: '*', 'Ducasse', '*';
		keysOfBlackListedEntries: #(Berg13b Berg16a Denk14a Denk15a Denk16a Denk18a Denk19a Denk20a Denk21a Anqu17a Denk22a);
		setFilteringOfNonPublicOn
]

{ #category : 'initialization' }
FOPublicationListBuilder >> defaultFieldOrder [

	^ #(#author #editor #title #chapter #journal #booktitle #volume #pages #publisher #collection #school #year #pdf)
]

{ #category : 'initialization' }
FOPublicationListBuilder >> defaultKeysOfBlackListedEntries [ 

	^ #()
]

{ #category : 'initialization' }
FOPublicationListBuilder >> defaultSectionSpecification [

	^ #(#internationalJournal  #topConference #internationalConference #nationalJournal #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #toolDemo #vulgarisation #technicalReport #PhDAndHabilitation)
]

{ #category : 'initialization' }
FOPublicationListBuilder >> defaultSpecification [

	^ #( #internationalJournal #nationalJournal #topConference #internationalConference #nationalConference #invitedPaper #bookChapter #book #editor #internationalWorkshop #toolDemo #vulgarisation #PhDAndHabilitation)
]

{ #category : 'queries' }
FOPublicationListBuilder >> deliverableQuery [
	^ CZQuery deliverable
]

{ #category : 'private' }
FOPublicationListBuilder >> doNotAllowEmptySections [

	noEmptySection := true
]

{ #category : 'queries' }
FOPublicationListBuilder >> editorQuery [
	"We refine it for a single author!: the entrie is flagged as workshopproceeddings or as editor. This way papers written by the author that is also editor will not be mixed in the editor zone."

	
	^ (CZFieldQuery
		named: #editor
		checks: [ :value | self authorMatchingString match: value ])
		AND: ((self annotationWithType: '*workshopproceedings*') OR: (self annotationWithType: '*editor*'))
	

	
	"^ (self annotationWithType: '*workshopproceedings*') OR: (self annotationWithType: '*editor*')"
	
]

{ #category : 'accessing' }
FOPublicationListBuilder >> endYear [
	^ endYear
]

{ #category : 'accessing' }
FOPublicationListBuilder >> endYear: aNumber [
	
 	endYear := aNumber asNumber.
	self updateYears
]

{ #category : 'main configuration' }
FOPublicationListBuilder >> english [

	localization english
]

{ #category : 'accessing' }
FOPublicationListBuilder >> fieldOrder: aCol [
	"To specify the order and fields that should be displayed, for example, 
	#(#author #title #chapter #journal #booktitle #volume #pages #publisher #school #year #url #doi)."

	fieldOrder := aCol
]

{ #category : 'files' }
FOPublicationListBuilder >> fileNamed: aStringDotBib [
	"Parser and set the bib file."
	
	self onStream: (webSite fileSystem / aStringDotBib) readStream
]

{ #category : 'filtering' }
FOPublicationListBuilder >> filter [
	
	self filterWithinPeriod.
	self filterInSubmissionAndBlackListed.
	self filterAuthorAndEditor.
]

{ #category : 'filtering' }
FOPublicationListBuilder >> filterAuthorAndEditor [
	"Filter the **working set** to only the author entries"
	
	workingBibSet := workingBibSet select: (self authorQuery OR: self editorQuery)
]

{ #category : 'filtering' }
FOPublicationListBuilder >> filterInSubmissionAndBlackListed [
	"Filter insubmission and other blacklisted entries.
	Pay attention works on a selection of the original list."

	self shouldFilterNonPublic
		ifFalse: [ ^ self ].
	workingBibSet := workingBibSet reject: self inSubmissionQuery.
	workingBibSet := workingBibSet
		reject: [ :each | keysOfBlackListedEntries includes: each key ].
	
]

{ #category : 'filtering' }
FOPublicationListBuilder >> filterWithinPeriod [
	"Pay attention filter from the original set so it should always be invoked prior to 
	other filer functions."
	
	| yearDict |
	yearDict := originalBibSet groupedBy: CZQuery year.
	(((yearDict keys select: [ :each | each isNumber ]) sort: [ :a :b| a > b ]) 
		select: [:each | 
			years includes: each asNumber]) 
			do: 
				[ :k | 
					workingBibSet addAll: (yearDict at: k) ]
]

{ #category : 'main configuration' }
FOPublicationListBuilder >> french [

	localization french
]

{ #category : 'queries' }
FOPublicationListBuilder >> inSubmissionQuery [
	^ CZQuery inSubmission
]

{ #category : 'initialization' }
FOPublicationListBuilder >> initialize [

	super initialize.
	workingBibSet := CZSet new.
	originalBibSet := CZSet new.
	self authorMatchingString: '*'.
	localization := self localizationClass new.
	self english.
	self fieldOrder: self defaultFieldOrder.
	self setFilteringOfNonPublicOn.
	self keysOfBlackListedEntries: self defaultKeysOfBlackListedEntries.
	startYear := 1900.
	endYear := Year currentYearNumber.
	self updateYears. 
	self doNotAllowEmptySections.
	bodySpecification := self defaultSpecification.
	sections := OrderedCollection new.

]

{ #category : 'queries' }
FOPublicationListBuilder >> internationalConferenceQuery [

	^ (self annotationWithType:  '*internationalconference*') AND: (self topConferenceQuery) NOT
]

{ #category : 'queries' }
FOPublicationListBuilder >> internationalJournalQuery [

	^ (CZFieldQuery 
			named: #annote 
			checks: [ :value | '*internationaljournal*' match: value ])
]

{ #category : 'queries' }
FOPublicationListBuilder >> internationalWorkshopQuery [
	^ CZQuery internationalWorkshop
]

{ #category : 'queries' }
FOPublicationListBuilder >> invitedPaperQuery [

	^ self annotationWithType:  '*invited*'
]

{ #category : 'queries' }
FOPublicationListBuilder >> invitedQuery [

	^ self annotationWithType:  '*invited*'
]

{ #category : 'queries' }
FOPublicationListBuilder >> journalQuery [
	^ CZQuery journal
]

{ #category : 'main configuration' }
FOPublicationListBuilder >> keysOfBlackListedEntries [
	"Returns the list of entities (identfied via their bib key) that should not be taken into account when building a document."
	
	^ keysOfBlackListedEntries
]

{ #category : 'accessing' }
FOPublicationListBuilder >> keysOfBlackListedEntries: aCol [

	keysOfBlackListedEntries := aCol
]

{ #category : 'main configuration' }
FOPublicationListBuilder >> localizationClass [
	^ FOLocalisation
]

{ #category : 'queries' }
FOPublicationListBuilder >> nationalConferenceQuery [
	"pay attention not to put a star else internationalconference will be matched too"

	^ CZQuery nationalConference
]

{ #category : 'queries' }
FOPublicationListBuilder >> nationalJournalQuery [
	^ CZQuery nationalJournal
]

{ #category : 'queries' }
FOPublicationListBuilder >> nationalWorkshopQuery [
	^ CZQuery nationalWorkshop
]

{ #category : 'private' }
FOPublicationListBuilder >> onStream: aStream [

	| bibset2 |
	bibset2 := CZBibParser parse: aStream contents.
	bibset2 scope: CZSet standardDefinitions.
	self bibset: bibset2
	
]

{ #category : 'accessing' }
FOPublicationListBuilder >> originalBibSet [

	^ originalBibSet
]

{ #category : 'queries' }
FOPublicationListBuilder >> periodicalQuery [
	^ CZQuery periodical
]

{ #category : 'private' }
FOPublicationListBuilder >> publishToWebSite: aWebSite withPath: aPath [

	
]

{ #category : 'intersections' }
FOPublicationListBuilder >> sections [

	^ sections
]

{ #category : 'main configuration' }
FOPublicationListBuilder >> setFilteringOfNonPublicOff [
	"to filter private entries and others insubmissions"
	
	shouldFilterNonPublic := false
]

{ #category : 'main configuration' }
FOPublicationListBuilder >> setFilteringOfNonPublicOn [
	"to filter private entries and others insubmissions"
	
	shouldFilterNonPublic := true
]

{ #category : 'main configuration' }
FOPublicationListBuilder >> setFilteringOff [

	shouldFilterNonPublic := false
]

{ #category : 'main configuration' }
FOPublicationListBuilder >> setFilteringOn [
	"to filter private entries and others insubmissions"
	
	shouldFilterNonPublic := true
]

{ #category : 'main configuration' }
FOPublicationListBuilder >> setLanguage: aSymbol [
	"right now only english and french are managed."
	
	| language |
	language := (#(english french) includes: aSymbol) 
		ifFalse: [ #english ]
		ifTrue: [ aSymbol ].
	self perform: aSymbol
]

{ #category : 'main configuration' }
FOPublicationListBuilder >> shouldFilterNonPublic [

	^ shouldFilterNonPublic
]

{ #category : 'accessing' }
FOPublicationListBuilder >> startYear: aNumber [

 	startYear := aNumber asNumber.
	self updateYears
]

{ #category : 'queries' }
FOPublicationListBuilder >> teamEntryQuery [
	^ CZQuery teamEntry
]

{ #category : 'queries' }
FOPublicationListBuilder >> technicalReportQuery [
	^ CZQuery techReport
]

{ #category : 'queries' }
FOPublicationListBuilder >> toolDemoQuery [
	^ CZQuery toolDemo
]

{ #category : 'queries' }
FOPublicationListBuilder >> topConferenceQuery [
	^ CZQuery topConference
]

{ #category : 'private' }
FOPublicationListBuilder >> treatBody [
	self bodySpecification
		do: [ :each |  
					self 
						addSectionFromQuery: (self perform: (each, #Query) asSymbol)  
						withTitle: (localization perform: each) ] 
				
]

{ #category : 'initialization' }
FOPublicationListBuilder >> updateYears [
	
	years := startYear to: endYear.
]

{ #category : 'queries' }
FOPublicationListBuilder >> vulgarisationQuery [
	^ CZQuery vulgarisation
]

{ #category : 'accessing' }
FOPublicationListBuilder >> webSite: aFOWebSite [ 
	webSite := aFOWebSite
]

{ #category : 'accessing' }
FOPublicationListBuilder >> workingBibSet [ 
	
	^ workingBibSet
]

{ #category : 'accessing' }
FOPublicationListBuilder >> workingDirectory: aWorkingDirectory [ 
	
	workingDirectory := aWorkingDirectory
]

{ #category : 'accessing' }
FOPublicationListBuilder >> years [
	^ years
]

{ #category : 'accessing' }
FOPublicationListBuilder >> years: aCollection [ 
	years := aCollection
]
