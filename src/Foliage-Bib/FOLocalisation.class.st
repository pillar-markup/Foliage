"
I manage the localisation of files and entries
"
Class {
	#name : 'FOLocalisation',
	#superclass : 'Object',
	#instVars : [
		'language'
	],
	#classVars : [
		'Book',
		'BookChapter',
		'Booklet',
		'Deliverable',
		'English',
		'French',
		'HDR',
		'HandBook',
		'InternationalConference',
		'InternationalConferences',
		'InternationalReview',
		'InternationalReviewedJournal',
		'InternationalReviewedWorkshop',
		'InvitedPaper',
		'NationalReviewedConference',
		'NationalReviewedConferences',
		'NationalReviewedJournal',
		'NationalWorkshop',
		'PHDAndHdr',
		'Periodical',
		'PhD',
		'TechnicalReport',
		'ToolDemo',
		'TopConferences',
		'Vulgarisation'
	],
	#category : 'Foliage-Bib',
	#package : 'Foliage-Bib'
}

{ #category : 'initialize' }
FOLocalisation class >> initialize [
	"self initialize"
	
	self initializeTypes.
	self initializeEnglishEntries.
	self initializeFrenchEntries.
]

{ #category : 'initialize' }
FOLocalisation class >> initializeEnglishEntries [
	"self initialize"
	
	English := Dictionary new.
	English at: InternationalReviewedJournal put: 'Refereed Articles in International Journals'.
	English at: TopConferences put: 'Refereed Articles in Top Conferences'.
	English at: NationalReviewedJournal put:  'Refereed Articles in French Journals'.
	English at: InternationalConference put: 'Refereed Articles in International Conferences'.
	English at: NationalReviewedConference put: 'Refereed Articles in National Conferences'.
 	English at: Book put: 'Books'.
	English at: Booklet put: 'Booklets'.
	English at: HandBook put: 'Handbooks'.
	English at: BookChapter put: 'Book Chapters'.
	English at: InvitedPaper put: 'Invited Articles'.
	English at: #editor put: 'Editor'.
	English at: InternationalReviewedWorkshop put: 'Refereed Articles in International Workshops'.
	English at: NationalWorkshop put: 'Articles in National Workshops'.
	English at: PhD put: 'PhD'.
	English at: HDR put: 'Habilitation'.
	English at: PHDAndHdr put: 'PhD and Habilitation'.
	English at: Deliverable put: 'Project Deliverables'.
	English at: TechnicalReport put: 'Technical Reports'.
	English at: ToolDemo put: 'Tool Demos'.
	English at: Periodical put: 'Periodicals and Magazines'.
	English at: Vulgarisation put: 'Vulgarisation Articles'.
	
]

{ #category : 'initialize' }
FOLocalisation class >> initializeFrenchEntries [
	"self initializeFrenchEntries"
	
	French := Dictionary new.
	French at: InternationalReviewedJournal put: 'Revues internationales avec comit\''e de lecture'.
	French at: TopConferences put: 'Meilleures conf\''erences internationales'.
	French at: NationalReviewedJournal put:  'Revues nationales avec comit\''e de lecture'.
	French at: InternationalConference put: 'Conf\''erences internationales avec comit\''e de lecture'.
	French at: NationalReviewedConference put: 'Conf\''erences nationales avec comit\''e de lecture'.
 	French at: Book put: 'Livres'.
	French at: Booklet put: 'Livrets'.
	French at: HandBook put: 'Tutoriels'.
	French at: BookChapter put: 'Articles dans un ouvrage collectif'.
	French at: InvitedPaper put: 'Articles invit\''es'.
	French at: #editor put: 'Editeur'.
	French at: InternationalReviewedWorkshop put: 'Articles de workshop internationaux avec comit\''e de lecture'.
	French at: NationalWorkshop put: 'Articles de workshop nationaux avec comit\''e de lecture ou de s\''election'.
	French at: PhD put: 'Th\`ese'.
	French at: HDR put: 'Habilitation \''a diriger des recherches'.
	French at: PHDAndHdr put: 'Th\`ese et Habilitation \''a diriger des recherches'.
	French at: Deliverable put: 'Livrables de projets'.
	French at: TechnicalReport put: 'Rapports scientifiques et/ou techniques'.
	French at: ToolDemo put: 'D\''emonstrations d''outils'.
	French at: Periodical put: 'Magazines'.
	French at: Vulgarisation put: 'Articles de vulgarisation'.
	

]

{ #category : 'initialize' }
FOLocalisation class >> initializeTypes [
	"self initializeTypes"
	
	InternationalReviewedJournal := #internationReviewedJournal.
	NationalReviewedJournal := #nationalReviewedJournal.
	TopConferences := #topConferences.
	InternationalConference := #internationalConferences.
	NationalReviewedConference := #nationalConference.
	Book := #book.
	HandBook := #handbook.
	Booklet := #booklet.	
	BookChapter := #bookChapter.
	InvitedPaper := #invitedPapers.
	"Editor := #editor."
	InternationalReviewedWorkshop := #internationalWorkshop.
	NationalWorkshop := #nationalWorkshop.
	PhD := #phd.
	HDR := #hdr.
	PHDAndHdr := #phdAndHdr.
	Deliverable := #deliverable.
	TechnicalReport := #technicalReport.
	ToolDemo := #tooldemo.
	Periodical := #periodical.
	Vulgarisation := #vulgarisation.
	
]

{ #category : 'accessing' }
FOLocalisation >> PhDAndHabilitation [

	^ language at: PHDAndHdr
]

{ #category : 'accessing' }
FOLocalisation >> book [

	^ language at: Book
]

{ #category : 'accessing' }
FOLocalisation >> bookChapter [

	^ language at: BookChapter
]

{ #category : 'accessing' }
FOLocalisation >> bookChapters [

	^ language at: BookChapter
]

{ #category : 'accessing' }
FOLocalisation >> booklet [

	^ language at: Booklet
]

{ #category : 'accessing' }
FOLocalisation >> booklets [

	^ language at: Booklet
]

{ #category : 'accessing' }
FOLocalisation >> books [

	^ language at: Book
]

{ #category : 'accessing' }
FOLocalisation >> deliverable [

	^ language at: Deliverable
]

{ #category : 'accessing' }
FOLocalisation >> editor [

	^ language at: #editor
]

{ #category : 'setting' }
FOLocalisation >> english [

	language := English
]

{ #category : 'setting' }
FOLocalisation >> french [ 

	language := French
]

{ #category : 'accessing' }
FOLocalisation >> handbooks [

	^ language at: Book
]

{ #category : 'accessing' }
FOLocalisation >> hdr [

	^ language at: HDR
]

{ #category : 'initialization' }
FOLocalisation >> initialize [

	super initialize.
	self english
]

{ #category : 'accessing' }
FOLocalisation >> internationalConference [

	^ language at: InternationalConference
]

{ #category : 'accessing' }
FOLocalisation >> internationalJournal [

	^ language at: InternationalReviewedJournal
]

{ #category : 'accessing' }
FOLocalisation >> internationalReviewedJournal [

	^ language at: InternationalReviewedJournal
]

{ #category : 'accessing' }
FOLocalisation >> internationalReviewedWorkshops [

	^ language at: InternationalReviewedWorkshop
]

{ #category : 'accessing' }
FOLocalisation >> internationalWorkshop [

	^ language at: InternationalReviewedWorkshop
]

{ #category : 'accessing' }
FOLocalisation >> internationalWorkshops [

	^ language at: InternationalReviewedWorkshop
]

{ #category : 'accessing' }
FOLocalisation >> invitedPaper [

	^ language at: InvitedPaper
]

{ #category : 'accessing' }
FOLocalisation >> invitedPapers [

	^ language at: InvitedPaper
]

{ #category : 'accessing' }
FOLocalisation >> nationalConference [

	^ language at: NationalReviewedConference
]

{ #category : 'accessing' }
FOLocalisation >> nationalJournal [

	^ language at: NationalReviewedJournal
]

{ #category : 'accessing' }
FOLocalisation >> nationalReviewedConference [

	^ language at: NationalReviewedConference
]

{ #category : 'accessing' }
FOLocalisation >> nationalReviewedJournal [

	^ language at: NationalReviewedJournal
]

{ #category : 'accessing' }
FOLocalisation >> nationalWorkshops [

	^ language at: NationalWorkshop
]

{ #category : 'accessing' }
FOLocalisation >> periodical [

	^ language at: Periodical
]

{ #category : 'accessing' }
FOLocalisation >> phd [

	^ language at: PhD
]

{ #category : 'accessing' }
FOLocalisation >> phdAndHdr [

	^ language at: PHDAndHdr
]

{ #category : 'accessing' }
FOLocalisation >> technicalReport [

	^ language at: TechnicalReport
]

{ #category : 'accessing' }
FOLocalisation >> toolDemo [

	^ language at: ToolDemo
]

{ #category : 'accessing' }
FOLocalisation >> topConference [

	^ language at: TopConferences
]

{ #category : 'accessing' }
FOLocalisation >> topConferences [

	^ language at: TopConferences
]

{ #category : 'accessing' }
FOLocalisation >> vulgarisation [

	^ language at: Vulgarisation
]
