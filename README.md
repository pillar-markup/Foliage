# Foliage

A simple static site generator based on Microdown.




To load it in Pharo 13

```
Metacello new
	baseline: 'Foliage';
	repository: 'github://Ducasse/Foliage:v2.1.0/src';
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

