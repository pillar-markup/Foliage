Class {
	#name : 'FOAbstractWebSiteTest',
	#superclass : 'TestCase',
	#instVars : [
		'root',
		'site',
		'fileSystem'
	],
	#category : 'Foliage-Core-Tests-Blog',
	#package : 'Foliage-Core-Tests',
	#tag : 'Blog'
}

{ #category : 'data' }
FOAbstractWebSiteTest >> blogPostAbstractTemplateContents [

	^ '<h2><a href="{{pathString}}">{{title}}</a></h2>
{{abstract}}
<div class="date">{{{publicationDate}}}</div>'
]

{ #category : 'running' }
FOAbstractWebSiteTest >> blogTemplateContents [

	^ '<!DOCTYPE HTML>
<html>
    {{> head}}
    <body class="default">
        <div id="wrap">
            <div id="main">
                {{> header}}
                <div class="container">
                    <h1>{{title}}</h1>
                    {{> main }}
                    {{> blog-footer}}
                </div>
            </div>
        </div>
        {{> footer}}
    </body>
</html>'
]

{ #category : 'running' }
FOAbstractWebSiteTest >> blogfooterTemplateContents [

	^ '<div class="blog-footer">
<hr>
Suscribe to this blog: <a href="http://pharo.org/news/atom.xml">Entries RSS</a> or follow on Twitter <a href="https://twitter.com/pharoproject">@pharoproject</a>
</div>'
]

{ #category : 'running' }
FOAbstractWebSiteTest >> defineFiles [


	(root / 'success') ensureCreateDirectory.
	root / 'success' / self mdOneFileName writeStreamDo: [ :st |
		st nextPutAll: self gsocContentsMD ].
	root / 'success' / self mdOneFileName2 writeStreamDo: [ :st |
		st nextPutAll: self gsocContentsMD2 ].
	(root / 'templates') ensureCreateDirectory.

	root / 'templates' / 'blog-post-abstract' writeStreamDo: [ :st |
		st nextPutAll: self blogPostAbstractTemplateContents ].

	root / 'templates' / 'blog' writeStreamDo: [ :st |
		st nextPutAll: self blogTemplateContents ].

	root / 'templates' / 'head' writeStreamDo: [ :st |
		st nextPutAll: self headTemplateContents ].

	root / 'templates' / 'header' writeStreamDo: [ :st |
		st nextPutAll: self headerTemplateContents ].

	root / 'templates' / 'navbar' writeStreamDo: [ :st |
		st nextPutAll: self navbarTemplateContents ].

	root / 'templates' / 'menu' writeStreamDo: [ :st |
		st nextPutAll: self menuTemplateContents ].
	root / 'templates' / 'main' writeStreamDo: [ :st |
		st nextPutAll: self mainTemplateContents ].
	root / 'templates' / 'blog-footer' writeStreamDo: [ :st |
		st nextPutAll: self blogfooterTemplateContents ].
	root / 'templates' / 'footer' writeStreamDo: [ :st |
		st nextPutAll: self footerTemplateContents ].
	root / 'templates' / 'footer-analytics' writeStreamDo: [ :st |
		st nextPutAll: self footerAnalyticsTemplateContents ]
]

{ #category : 'running' }
FOAbstractWebSiteTest >> footerAnalyticsTemplateContents [

	^ '<script>
</script>'
]

{ #category : 'running' }
FOAbstractWebSiteTest >> footerTemplateContents [

	^ '<div id="footer">
    <div class="container"> 
        <div class="small">
            <br/><br/>
            <p>Pharo is developed by an international community of open-source developers, coordinated and maintained by the pharo consortium and receives essential support from Inria, RMOD, CNRS, UDL, Cristal and many others.</p>
            <div style="text-align: center">
                  <img src="https://files.pharo.org/web-images/all-logos.png"/>
            </div>
        </div>
    </div>
</div>
{{>footer-analytics}}'
]

{ #category : 'data' }
FOAbstractWebSiteTest >> gsocContentsMD [

	^ '{
"title" : "Google Summer of Code",
"layout" : "default",
"publishDate" : "2019-05-21"
}

# Google Summer of Code 2019 Students


On this page, you can find the personal blogs and social media links of the seven students accepted for Google Summer of Code with Pharo Consortium in 2019. Follow their pages to get regular updates on their progress. Don''t hesitate to get in touch with those students - they need your feedback.

## Atharva Khare

- [Personal blog](https://khare.dev/posts/)
- [Twitter](https://twitter.com/code_alchemist)
- [GitHub](https://github.com/AtharvaKhare)


## Dayne Lorena Guerra Calle

- [Personal blog](https://medium.com/@daynestorm)
- [Twitter](https://twitter.com/DayneStorm_)
- [Facebook](https://www.facebook.com/Day.nelo)
- [GitHub](https://github.com/GDayne)


## Evelyn Cusi Lopez

- [Personal blog](https://medium.com/@cusi.evelyn)
- [Twitter](https://twitter.com/Evelyn81435990)
- [Facebook](https://www.facebook.com/evelyn.cusilopez)
- [GitHub](https://github.com/Lin777)


## Myroslava Romaniuk

- [Personal blog](https://medium.com/@myroslavarm)
- [Twitter](https://twitter.com/myroslavarm)
- [GitHub](https://github.com/myroslavarm)


## Nikhil Pinnaparaju

- [Personal blog](https://medium.com/@nikhilpinnaparaju)
- [Twitter](https://twitter.com/NPinnaparaju)
- [Facebook](https://www.facebook.com/nikhil.pinnaparaju.1)
- [GitHub](https://github.com/nikhilpinnaparaju)


## Nina Medic

- [Personal blog](https://pharokeepers.github.io/)
- [Twitter](https://twitter.com/medicka992)
- [GitHub](https://github.com/medicka)


## Smiljana Knezev

- [Personal blog](https://pharokeepers.github.io/)
- [Twitter](https://twitter.com/KnezevSmiljana)
- [GitHub](https://github.com/SmiljanaKnezev)
'
]

{ #category : 'data' }
FOAbstractWebSiteTest >> gsocContentsMD2 [

	^ '{
"title" : "IsLoop",
"layout" : "default",
"publishDate" : "2025-05-21"
}

# IsLoop summer school


We are organizing a summer school on Pharo and advanced design every year. 
The previous editions were held at Split, Montpelllier and Fianarantsoa. 


'
]

{ #category : 'running' }
FOAbstractWebSiteTest >> headTemplateContents [

	^ ''
]

{ #category : 'running' }
FOAbstractWebSiteTest >> headerTemplateContents [
	
	^ '{{> navbar}}'
]

{ #category : 'running' }
FOAbstractWebSiteTest >> mainTemplateContents [

	^ '
	BODYSTART
	{{{body}}}
	BODYEND
	'
]

{ #category : 'data' }
FOAbstractWebSiteTest >> mdOneFileName [

	^ 'gsoc.md'
]

{ #category : 'data' }
FOAbstractWebSiteTest >> mdOneFileName2 [
	
	^ 'gsoc2.md'
]

{ #category : 'running' }
FOAbstractWebSiteTest >> menuTemplateContents [ 
	^ '<ul class="nav navbar-nav">
    <li><a href="/news" class="{{#news-active}}active{{/news-active}}">News</a></li>
    <li><a href="/features"  class="{{#features-active}}active{{/features-active}}">Features</a></li>
    <li><a href="/download"  class="{{#download-active}}active{{/download-active}}">Download</a></li>
    <li><a href="/documentation"  class="{{#documentation-active}}active{{/documentation-active}}">Documentation</a></li>
    <li><a href="/community"  class="{{#community-active}}active{{/community-active}}">Community</a></li>
    <li><a href="/contribute"  class="{{#contribute-active}}active{{/contribute-active}}">Contribute</a></li>
    <li><a href="/success"  class="{{#success-active}}active{{/success-active}}">Stories</a></li>
    <li><a href="/about"  class="{{#about-active}}active{{/about-active}}">About</a></li>
</ul>'
]

{ #category : 'running' }
FOAbstractWebSiteTest >> navbarTemplateContents [ 
	^ '<nav class="navbar navbar-default" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="/web"><img src="/web/files/pharo-logo-small.png" alt="Pharo" srcset="/web/files/pharo-logo-small-2x.png 2x"/></a>
    </div>    

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      {{> menu}}
         <!--
         <form class="navbar-form navbar-right">
            <div class="form-group">
                <a class="btn btn-default" href="/web/download">Download latest version ($.0)</a>
                <a class="btn" href="/web/documentation">Learn more</a>
            </div>
        </form>
        -->
    </div>

  </div>
</nav>'
]

{ #category : 'running' }
FOAbstractWebSiteTest >> setUp [ 
	
	fileSystem := FileSystem memory. 
	root := fileSystem root.

	self defineFiles.
	
	site := FOWebSite new.
	site fileSystem: fileSystem.
	site templatePath: '/templates'.
	site importDirectory: root.
]
