# Foliage

A simple static site generator

For initial instructions have a look at https://norbert.hartl.name/blog/2021-01-17-foliage-released.html


To load it in Pharo 13


```
Metacello new
	baseline: 'Foliage';
	repository: 'github://Ducasse/Foliage:master/src';
	onConflict: [ :ex | ex useIncoming ];
	onUpgrade: [ :ex | ex useIncoming ];
	load.
```


### To generate the Pharo website

```
git clone git@github.com:pharo-project/pharo-website.git
git co WithFoliage20
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












### Old


```
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

Metacello new
	baseline: 'Pillar';
	repository: 'github://pillar-markup/Pillar:dev/src';
	onConflict: [ :ex | ex useIncoming ];
	onUpgrade: [ :ex | ex useIncoming ];
	load.

mic := (IceRepository repositoryNamed: 'Microdown').
(mic packageNamed: 'Microdown-Pillar') load.

	
Metacello new
	baseline: 'Foliage';
	repository: 'github://Ducasse/Foliage:master/src';
	onConflict: [ :ex | ex useIncoming ];
	onUpgrade: [ :ex | ex useIncoming ];
	load.
```
This behavior is packged in Microdown-Pillar and Microdown-Pillar-Test.
Note that in Pharo 13 the conversion is not working at this moment. 
Pay attention that if we fix the conversion for MicrodownV2 in Pharo 13 we should be sure that 
the old Foliage using microdownV1 should use an old version of the conversion. 


