Class {
	#name : 'FOBlogAfterConversionTest',
	#superclass : 'FOBlogTest',
	#category : 'Foliage-Core-Tests-Blog',
	#package : 'Foliage-Core-Tests',
	#tag : 'Blog'
}

{ #category : 'running' }
FOBlogAfterConversionTest >> setUp [ 
	
		super setUp.	
		"we sbould be able to write
		blog := site convertToBlog: 'success' 
		or better 
		blog := site buildBlog: 'success
		It should call convertToBlog + build overview"

		blog := (site / 'success') convertToBlog.
		blog title: 'Super success'.
		"	blog at: #'index.html' put: blog overviewPage."
	
]

{ #category : 'failing tests' }
FOBlogAfterConversionTest >> testBlogAfterOverviewBuildingNowContainsIndex [ 

	site buildOverviewFor: 'success'.
	self assert: blog items size equals: 3.
	self assert: (blog items at: #'index.html') class equals: FOMicrodownBlogPage 
	
]

{ #category : 'running' }
FOBlogAfterConversionTest >> testBlogBeforeOverviewBuildingOnlyContainsChildren [ 

	self assert: blog items size equals: 2.
	blog items keys do: [ :each | self assert: (#( 'gsoc.md2' 'gsoc2.md2') includes: each) ].
	self assert: blog publishedPosts size equals: 2.
]

{ #category : 'failing tests' }
FOBlogAfterConversionTest >> testBlogGeneration [

	| p |
	self halt. 
	"we should call the publisher!"
	p := FOPublisher new. 
	p baseUri: 'http://pharo.org'.
	p targetPath: root / 'generated'.
	p publish. 
	self assert: blog items size equals: 3.
	self assert: (blog items at: #'index.html') class equals: FOMicrodownBlogPage.
	
	
]

{ #category : 'running' }
FOBlogAfterConversionTest >> testBlogIsNowInFileModel [
	
	self assert: (site / 'success') equals: blog.
	self assert: (site / 'success') class equals: FOBlog
]

{ #category : 'failing tests' }
FOBlogAfterConversionTest >> testBlogOverviewHasAbstracts [

	| summaryPageObject |
	site buildOverviewFor: 'success'.
	summaryPageObject := blog items at: #'index.html'.
	self assert: blog items size equals: 3.
	
	"The abstracts are correctly generated."
	self assert: summaryPageObject document children size equals: 2
	
]

{ #category : 'failing tests' }
FOBlogAfterConversionTest >> testBlogOverviewRender [

	| summaryPageObject |
	site buildOverviewFor: 'success'.
	summaryPageObject := blog items at: #'index.html'.

	self assert: summaryPageObject htmlString equals: '<!DOCTYPE HTML>
<html>
    
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
                    <h1>Super success</h1>
                    
                    <div class="blog-footer">
<hr>
Suscribe to this blog: <a href="http://pharo.org/news/atom.xml">Entries RSS</a> or follow on Twitter <a href="https://twitter.com/pharoproject">@pharoproject</a>
</div>
                </div>
            </div>
        </div>
        <div id="footer">
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
<script>
</script>
    </body>
</html>'
	
]

{ #category : 'running' }
FOBlogAfterConversionTest >> testBlogPostHasMetaData [
	
	self assert: blog publishedPosts first publicationDate printString equals: '21 May 2019'.
	self assert: blog publishedPosts first layout  equals: 'default'.
	self assert: blog publishedPosts first title equals: 'Google Summer of Code'.
]

{ #category : 'overviewBuilder' }
FOBlogAfterConversionTest >> testOverviewBuilderCreatesPageWithDocumentHavingRawChildren [

	| o page |
	o := FOBlogOverviewBuilder new.
	o
		blog: blog;
		numberOfCharacters: 100. 
	page := o buildSummary.
	self assert: page title equals: blog title.
	self assert: page layout equals: blog layout.
	self assert: page document children size equals: 2.
	
	self assert: page document children first class equals: MicRawBlock
]
