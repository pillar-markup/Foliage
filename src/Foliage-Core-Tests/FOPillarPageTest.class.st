"
Here we test that the reader is reading well md files and produces a PR document.
At the end we will get rid of the PR document. 

For now the only distinction between md converted in pillar and md are: md2 extension and different metadata.

"
Class {
	#name : 'FOPillarPageTest',
	#superclass : 'TestCase',
	#instVars : [
		'root'
	],
	#category : 'Foliage-Core-Tests-Model',
	#package : 'Foliage-Core-Tests',
	#tag : 'Model'
}

{ #category : 'tests' }
FOPillarPageTest >> setUp [

	root := FileSystem memory root.
	(root / 'community.md')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << 'title: Community
layout: default
publishDate: 2021-11-04

# Community & help



## Discord team

We hang out on Discord \(Invitation at [https://discord.gg/QewZMZa](https://discord.gg/QewZMZa)\), where we discuss everything for Pharo users and developers.

You can get an instant invite following this [link](https://discord.gg/QewZMZa).
' ].

	(root / 'templates' / 'default')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << '<!DOCTYPE HTML>
<html>
    {{> head}}
    <body class="default">
        <div id="wrap">
            <div id="main">
                {{> header}}

                <div class="container">
                    {{> main}}
                </div>
            </div>
        </div>
    </body>
</html>' ].

	(root / 'templates' / 'head')
		ensureCreateFile;
		writeStreamDo: [ :s |
			s << '<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Pharo - {{{title}}}</title>
    <link rel="shortcut icon" href="/files/favicon.ico" />
    <link href=''//fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic'' rel=''stylesheet'' type=''text/css''>
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootswatch/3.1.1/united/bootstrap.min.css">
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css">
    <link rel="stylesheet" href="/web/files/style.css">
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
    <script src="/web/files/ekko-lightbox.min.js"></script>
    <script src="/web/files/pharo.js"></script>
    <link rel="stylesheet" href="/web/files/ekko-lightbox.min.css">
</head>' ].

	(root / 'templates' / 'header')
		ensureCreateFile;
		writeStreamDo: [ :s | s << '{{> navbar}}' ].
	
	(root / 'templates' / 'header')
		ensureCreateFile;
		writeStreamDo: [ :s | s << 
	
'<nav class="navbar navbar-default" role="navigation">
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
</nav>'].

	(root / 'templates' / 'menu')
		ensureCreateFile;
		writeStreamDo: [ :s | s << 
'<ul class="nav navbar-nav">
    <li><a href="/news" class="{{#news-active}}active{{/news-active}}">News</a></li>
    <li><a href="/features"  class="{{#features-active}}active{{/features-active}}">Features</a></li>
    <li><a href="/download"  class="{{#download-active}}active{{/download-active}}">Download</a></li>
    <li><a href="/documentation"  class="{{#documentation-active}}active{{/documentation-active}}">Documentation</a></li>
    <li><a href="/community"  class="{{#community-active}}active{{/community-active}}">Community</a></li>
    <li><a href="/contribute"  class="{{#contribute-active}}active{{/contribute-active}}">Contribute</a></li>
    <li><a href="/success"  class="{{#success-active}}active{{/success-active}}">Stories</a></li>
    <li><a href="/about"  class="{{#about-active}}active{{/about-active}}">About</a></li>
</ul>'].
	(root / 'templates' / 'main')
		ensureCreateFile;
		writeStreamDo: [ :s | s <<  '{{{body}}}' ]

]

{ #category : 'tests' }
FOPillarPageTest >> testGetAPageWithAPRDocument [

	| aPage |
	aPage := (FOMicrodownV2Reader file: root / 'community.md') createModelEntity.
	self assert: aPage class equals: FOMicrodownPage.
	self assert: (aPage meta at: 'layout') equals: 'default'.
	self assert: (aPage meta at: 'publishDate') equals: '2021-11-04'.
	self assert: aPage document class equals: PRDocument
]

{ #category : 'tests' }
FOPillarPageTest >> testHTMLString [

	| aPage web |
		self skip.
	aPage := (FOMicrodownV2Reader file: root / 'community.md') createModelEntity.
	web := FOWebSite new.
	web
		rawPath: root;
		templatePath: root / 'templates'.
	aPage parent: web.
	
	
	
	self assert: aPage htmlString equals: '<!DOCTYPE HTML>
<html>
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Pharo - Community</title>
    <link rel="shortcut icon" href="/files/favicon.ico" />
    <link href=''//fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic'' rel=''stylesheet'' type=''text/css''>
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootswatch/3.1.1/united/bootstrap.min.css">
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css">
    <link rel="stylesheet" href="/web/files/style.css">
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
    <script src="/web/files/ekko-lightbox.min.js"></script>
    <script src="/web/files/pharo.js"></script>
    <link rel="stylesheet" href="/web/files/ekko-lightbox.min.css">
</head>
    <body class="default">
        <div id="wrap">
            <div id="main">
                <nav class="navbar navbar-default" role="navigation">
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
      <ul class="nav navbar-nav">
    <li><a href="/news" class="">News</a></li>
    <li><a href="/features"  class="">Features</a></li>
    <li><a href="/download"  class="">Download</a></li>
    <li><a href="/documentation"  class="">Documentation</a></li>
    <li><a href="/community"  class="">Community</a></li>
    <li><a href="/contribute"  class="">Contribute</a></li>
    <li><a href="/success"  class="">Stories</a></li>
    <li><a href="/about"  class="">About</a></li>
</ul>
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
</nav>

                <div class="container">
                    <h1>Community & help</h1><h2>Discord team</h2><p>We hang out on Discord (Invitation at <a href="https://discord.gg/QewZMZa"><a href="https://discord.gg/QewZMZa">https://discord.gg/QewZMZa</a></a>), where we discuss everything for Pharo users and developers.</p><p>You can get an instant invite following this <a href="https://discord.gg/QewZMZa">link</a>.</p>
                </div>
            </div>
        </div>
    </body>
</html>'
]

{ #category : 'tests' }
FOPillarPageTest >> testRenderOn [

	| aPage |
		self skip.
	aPage := (FOMicrodownV2Reader file: root / 'community.md')
		         createModelEntity.

	self
		assert: (String streamContents: [ :s | aPage renderOn: s ])
		equals:
		'
<h1>Community & help</h1><h2>Discord team</h2><p>We hang out on Discord (Invitation at <a href="https://discord.gg/QewZMZa"><a href="https://discord.gg/QewZMZa">https://discord.gg/QewZMZa</a></a>), where we discuss everything for Pharo users and developers.</p><p>You can get an instant invite following this <a href="https://discord.gg/QewZMZa">link</a>.</p>'
]
