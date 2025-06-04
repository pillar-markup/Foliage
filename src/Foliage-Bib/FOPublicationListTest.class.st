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
  annote = {internationalworkshop},
  keywords = {stefPub kzPattern}}
	
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

@article{Poli14c,
  author = {Polito, Guillermo and Ducasse, St{\''e}phane and Fabresse, Luc and Bouraqadi, Noury and van Ryseghem, Benjamin},
  title = {Bootstrapping Reflective Systems: The Case of Pharo},
  journal = {Science of Computer Programming},
  volume = {96},
  pages = {141-155},
  publisher = {Elsevier},
  year = {2014},
  doi = {10.1016/j.scico.2013.10.008},
  pdf = {http://rmod-files.lille.inria.fr/Team/Texts/Papers/Poli14c-BootstrappingASmalltalk-ScienceOfComputerProgramming.pdf},
  annote = {internationaljournal},
  hal-id = {hal-00903724},
  keywords = {lse-pub virtualization metacircularities recovery isolation kzReflection stefpub}}

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

{ #category : 'running' }
FOPublicationListTest >> testPublicationListHasEntryBeforeBuilding [

	| p |
	p := FOPublicationList new.
	p fileNamed: filesystem / 'rmod.bib'.
	
	self assert: p bibset size equals: 6.
	self assert: p bibset entries first class equals: CZEntry.
]
