# Foliage
A simple static site generator based on Microdown.

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

```
git clone git@github.com:pharo-project/pharo-website.git
git co WithFoliage20
```

```
|  p |
p := FOPublisher new. 
p baseUri: 'http://pharo.org'.
p sourcePath: '/Users/ducasse/Test2/pharo-website/site'.
p publish
```

## Foliage 1.0 instructions

For initial instructions have a look at https://norbert.hartl.name/blog/2021-01-17-foliage-released.html

