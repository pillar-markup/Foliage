Class {
	#name : 'FOPublicationListTest',
	#superclass : 'TestCase',
	#instVars : [
		'filesystem'
	],
	#category : 'Foliage-Bib',
	#package : 'Foliage-Bib'
}

{ #category : 'running' }
FOPublicationListTest >> contents [

	^ '

	@article{Duca22a,
  author = {St{\''e}phane Ducasse and  Guillermo Polito and Oleksandr Zaitsev and Marcus Denker and Pablo Tesone},
  title = {Deprewriter: On the fly rewriting method deprecations},
  journal = {Journal of Object Technologies (JOT)},
  volume = {21},
  year = {2022},
  doi = {10.5381/jot.2022.21.1.a1},
  pdf = {http://rmod-files.lille.inria.fr/Team/Texts/Papers/Duca22a-JOT-Deprewriter.pdf},
  number = {1},
  url2 = {http://www.jot.fm/contents/issue_2022_01/article1.html},
  annote = {internationaljournal kzTools},
  hal-id = {hal-03563605},
  hal-url = {https://hal.inria.fr/hal-03563605/document}}
	
	
	@inproceedings{Duca00c,
  author = {St{\''e}phane Ducasse and Serge Demeyer and Oscar Nierstrasz},
  title = {Transform Conditionals to Polymorphism},
  booktitle = {Proceedings of EuroPLoP ''2000},
  pages = {219--252},
  year = {2000},
  pdf = {http://rmod-files.lille.inria.fr/Team/Texts/Papers/Duca00cTransform.pdf},
  abstract = {Conditionals -i.e., switch statements, nested ifs- that are used to simulate polymorphism hamper evolution and flexibility of applications. The reengineering patterns presented in this paper show you how to transform conditionals in object-oriented code to improve the flexibility of application.},
  annote = {internalworkshop},
  keywords = {insubmission stefPub kzPattern}}
	
	@article{Saren24a,
  author = {Balsa Sarenac and Nicolas Anquetil and St{\''e}phane Ducasse and Pablo Tesone},
  title = {A New Architecture Reconciling Refactorings and Transformations},
  journal = {Journal of Computer Languages},
  pages = {101273},
  year = {2024},
  doi = {https://doi.org/10.1016/j.cola.2024.101273},
  pdf = {http://rmod-files.lille.inria.fr/Team/Texts/Papers/Saren24a-COLA-NewArchitecture.pdf},
  issn = {2590-1184},
  keywords = {StefPub kzEvolution},
  annote = {internationaljournal},
  hal-id = {hal-04576527},
  hal-url = {http://hal.inria.fr/hal-04576527}}


@inproceedings{Scha03a,
  author = {Nathanael Sch\"arli and St{\''e}phane Ducasse and Oscar Nierstrasz and Andrew P. Black},
  title = {Traits: Composable Units of Behavior},
  booktitle = {Proceedings of European Conference on Object-Oriented Programming},
  volume = {2743},
  pages = {248--274},
  publisher = {Springer Verlag},
  year = {2003},
  misc = {acceptance rate: 18/88 = 20\%},
  doi = {10.1007/b11832},
  pdf = {http://rmod-files.lille.inria.fr/Team/Texts/Papers/Scha03a-ECOOP-Traits.pdf},
  acceptnum = {18},
  accepttotal = {88},
  annote = {internationalconference topconference},
  cvs = {TraitsECOOP2003},
  isbn = {978-3-540-40531-3},
  keywords = {scg-pub traits stefPub kzTrait},
  month = jul,
  series = {LNCS}}

@inproceedings{Anqu20a,
  author = {Nicolas Anquetil and Anne Etien and Houekpetodji, Mahugnon Honor\''e and Beno{\^\i}t Verhaeghe and St{\''e}phane Ducasse and Clotilde Toullec and Fatija Djareddir and J\''er\^ome Sudich and Mustapha Derras},
  title = {Modular {Moose}:  A new generation of software reengineering platform},
  booktitle = {International Conference on Software and Systems Reuse (ICSR''20)},
  pages = {119--134},
  year = {2020},
  misc = {acceptance rate: 16/60 = 27\%},
  doi = {10.1007/978-3-030-64694-3_8},
  pdf = {http://rmod-files.lille.inria.fr/Team/Texts/Papers/Anqu20a-ICSR-Moose.pdf},
  series = {LNCS},
  number = {12541},
  hal-id = {hal-02972159},
  hal-url = {https://hal.inria.fr/hal-02972159},
  annote = {internationalconference},
  tagnicolasa = {tools},
  keywords = {kzEvolution},
  month = dec}

@inproceedings{Duca20a,
  author = {Ducasse, St{\''e}phane and Dargaud, Laurine and Polito, Guillermo},
  title = {Microdown: a Clean and extensible markup language to support Pharo documentation},
  booktitle = {Proceedings of the 2020 International Workshop on Smalltalk Technologies},
  year = {2020},
  pdf = {http://rmod-files.lille.inria.fr/Team/Texts/Papers/Duca20a-Microdown-IWST.pdf},
  annote = {internationalworkshop},
  keywords = {StefPub kzDesign},
  hal-id = {hal-03137098},
  hal-url = {https://hal.inria.fr/hal-03137098}}


@inproceedings{Poli22a,
  author = {Guillermo Polito and Pablo Tesone and St{\''e}phane Ducasse},
  title = {{Interpreter-guided Differential JIT Compiler Unit Testing}},
  booktitle = {Programming Language Design and Implementation (PLDI''22)},
  year = {2022},
  pdf = {http://rmod-files.lille.inria.fr/Team/Texts/Papers/Poli22a-InterpreterGuided-PLDI-22.pdf},
  hal-id = {hal-03607939},
  hal-url = {https://hal.inria.fr/hal-03607939},
  annote = {topconference},
  keywords = {StefPub kzVM}}
	 '
]

{ #category : 'running' }
FOPublicationListTest >> setUp [

	super setUp.
	filesystem := FileSystem memory.
	(filesystem / 'rmod.bib')
		ensureCreateFile;
		writeStreamDo: [ :s | s << self contents ].
	
	
]

{ #category : 'tests - sections' }
FOPublicationListTest >> testBuild [

	| p |
	p := FOPublicationList new.
	p fileNamed: filesystem / 'rmod.bib'.
	p authorMatchingString: '*', 'Ducasse', '*'.
	p setFilteringOfNonPublicOff.
	p build.
	self assert: p sections size equals: #(intJournal topConf internConf intWorks) size.
	self assert: p sections first title equals: 'Refereed Articles in International Journals'.
	self assert: p sections first items size equals: 2.
	self assert: p sections second title equals: 'Refereed Articles in Top Conferences'.
	self assert: p sections first items size equals: 2.
]

{ #category : 'tests - filter by script' }
FOPublicationListTest >> testFilteringOffInSubmission [

	| p |
	p := FOPublicationList new.
	p fileNamed: filesystem / 'rmod.bib'.
	p authorMatchingString: '*', 'Ducasse', '*'.
	self assert: p bibset size equals: 7.
	p setFilteringOfNonPublicOff.
	p filter.
	self assert: p workingBibSet size equals: p bibset size.
]

{ #category : 'tests - filter by script' }
FOPublicationListTest >> testFilteringOutBlackListed [

	| p |
	p := FOPublicationList new.
	p fileNamed: filesystem / 'rmod.bib'.
	p authorMatchingString: '*', 'Ducasse', '*'.
	p keysOfBlackListedEntries: #(Duca22a Duca00c).
	p setFilteringOfNonPublicOn.
	p filter.
	self assert: p workingBibSet size equals: 5.
]

{ #category : 'tests - filter by script' }
FOPublicationListTest >> testFilteringOutBlackListedWithInSubmissionToo [

	| p |
	p := FOPublicationList new.
	p fileNamed: filesystem / 'rmod.bib'.
	p authorMatchingString: '*', 'Ducasse', '*'.
	p keysOfBlackListedEntries: #(Duca22a Scha03a).
	p setFilteringOfNonPublicOn.
	p filter.
	self assert: p workingBibSet size equals: 4.
]

{ #category : 'tests - filter by script' }
FOPublicationListTest >> testFilteringOutInSubmission [

	| p |
	p := FOPublicationList new.
	p fileNamed: filesystem / 'rmod.bib'.
	p authorMatchingString: '*', 'Ducasse', '*'.
	p setFilteringOfNonPublicOn.
	p filter.
	self assert: p workingBibSet size equals: 6.
]

{ #category : 'tests - import' }
FOPublicationListTest >> testPublicationListHasEntryBeforeBuilding [

	| p |
	p := FOPublicationList new.
	p fileNamed: filesystem / 'rmod.bib'.
	
	self assert: p bibset size equals: 7.
	self assert: p bibset entries first class equals: CZEntry.
]
