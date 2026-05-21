# Foliage
A simple static site generator based on Microdown. It supports blogs as well as plugin for automatic generation of publication. 
It can be extended to introduce new features. 

It is used to generate for example
- https://www.pharo.org
- https://stephaneducasse.github.io

### User Get Started 

Have a look at https://github.com/Pillar-Markup/FoliageSample for a working example with automatic publication on push. 
The resulting site is available at https://pillar-markup.github.io/FoliageSample


### For Dev: Loading 

To load it in Pharo 13 change the following expression to point to the latest tag.

Since the current Metacello version is not able to update the baselines we should do it manually as follows: 

```
Smalltalk globals
	at: #BaselineOfMicrodown 
	ifPresent: [ :c | c removeFromSystem ].
Smalltalk globals
	at: #BaselineOfMustache 
	ifPresent: [ :c | c removeFromSystem ].
```

```
Metacello new
	baseline: 'Foliage';
	repository: 'github://pillar-markup/Foliage:vXXXX/src';
	onConflict: [ :ex | ex useIncoming ];
	onUpgrade: [ :ex | ex useIncoming ];
	load.
```

### To generate the Pharo website

You can use the archived https://github.com/pharo-project/PharoWeb20
to play with. Some configuration files may be different. 

The Pharo official website hosted at https://github.com/pharo-project/pharoweb is generated with Foliage20 using a centralized build hosted in the current repo. The pharo web is using a staging branch: using it you can see the resulting web site at https://staging.pharo.org before changing the official one. 


In general you can generate a web site executing this from within Pharo with Foliage loaded. 
```
|  p |
p := FOPublisher new. 
p baseUri: 'http://pharo.org'.
p sourcePath: '/Users/ducasse/Test2/pharo-website/site'.
p publish
```

### Command line

Here is a little command line expression to launch the generation of a site

```
.../Documents/Pharo/vms/130-x64/Pharo.app/Contents/MacOS/Pharo .../Documents/Pharo/images/P13-FoliageFixingCitezen/P13-FoliageFixingCitezen.image clap publish  --source site --target generated
```



## Foliage 1.0 instructions

For initial instructions have a look at https://norbert.hartl.name/blog/2021-01-17-foliage-released.html

