# Foliage

A simple static site generator

For initial instructions have a look at https://norbert.hartl.name/blog/2021-01-17-foliage-released.html


To load it in Pharo 13

```

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



Metacello new
	baseline: 'Microdown';
	repository: 'github://pillar-markup/Microdown:dev/src';
	onConflict: [ :ex | ex useIncoming ];
	onUpgrade: [ :ex | ex useIncoming ];
	load: #('All').

Metacello new
	baseline: 'Foliage';
	repository: 'github://Ducasse/Foliage:master/src';
	onConflict: [ :ex | ex useIncoming ];
	onUpgrade: [ :ex | ex useIncoming ];
	load.


"load manually Microdown-Pillar since it contains the converter from Microdown to Pillar"

```

Note that the conversion of microdown AST to pillar AST is not loaded. 
This behavior is packged in Microdown-Pillar and Microdown-Pillar-Test.
Note that in Pharo 13 the conversion is not working at this moment. 
Pay attention that if we fix the conversion for MicrodownV2 in Pharo 13 we should be sure that 
the old Foliage using microdownV1 should use an old version of the conversion. 


