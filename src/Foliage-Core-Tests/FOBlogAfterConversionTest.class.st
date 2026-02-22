Class {
	#name : 'FOBlogAfterConversionTest',
	#superclass : 'FOAbstractWebSiteTest',
	#instVars : [
		'blog'
	],
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
		
		blog := ( site / 'success' ) convertToBlog.
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

	self 
		assert: blog items size 
		equals: 2.
	blog items keys do: [ :each | self assert: (#( 'gsoc.md' 'gsoc2.md') includes: each) ].
	self 
		assert: blog publishedPosts size 
		equals: 2.
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
	self 
		assert: summaryPageObject htmlString
		equals: 
	 '<!DOCTYPE HTML>
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
                    
	BODYSTART
	<h2><a href="/success/gsoc2.html">IsLoop</a></h2>
We are organizing a summer school on Pharo and advanced design every year.
The previous editions were held at Split, Montpelllier and Fianarantsoa.
<div class="date">21 May 2025</div>
<h2><a href="/success/gsoc.html">Google Summer of Code</a></h2>
On this page, you can find the personal blogs and social media links of the seven students accepted for Google Summer of Code with Pharo Consortium in 2019. Follow their pages to get regular updates on their progress. Don''t hesitate to get in touch with those students - they need your feedback.Personal blogTwitterGitHubPersonal blogTwitterFacebookGitHubPersonal blogTwitterFacebookGitHubPersonal...TwitterGitHubPersona...TwitterFacebookGitHubPersona...TwitterGitHubPersona...TwitterGitHub
<div class="date">21 May 2019</div>

	BODYEND
	
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

{ #category : 'failing tests' }
FOBlogAfterConversionTest >> testBlogOverviewRenderOn [

	| summaryPageObject str |
	site buildOverviewFor: 'success'.
	summaryPageObject := blog items at: #'index.html'.
	str := String streamContents: [ :st | summaryPageObject renderOn: st ].
	self assert: str equals: '<h2><a href="/success/gsoc2.html">IsLoop</a></h2>
We are organizing a summer school on Pharo and advanced design every year.
The previous editions were held at Split, Montpelllier and Fianarantsoa.
<div class="date">21 May 2025</div>
<h2><a href="/success/gsoc.html">Google Summer of Code</a></h2>
On this page, you can find the personal blogs and social media links of the seven students accepted for Google Summer of Code with Pharo Consortium in 2019. Follow their pages to get regular updates on their progress. Don''t hesitate to get in touch with those students - they need your feedback.Personal blogTwitterGitHubPersonal blogTwitterFacebookGitHubPersonal blogTwitterFacebookGitHubPersonal...TwitterGitHubPersona...TwitterFacebookGitHubPersona...TwitterGitHubPersona...TwitterGitHub
<div class="date">21 May 2019</div>
' 
]

{ #category : 'running' }
FOBlogAfterConversionTest >> testBlogPostHasMetaData [
	
	self
		assert: blog publishedPosts first publishDate printString
		equals: '21 May 2025'.
	self 
		assert: blog publishedPosts first layout 
		equals: 'default'.
	self 
		assert: blog publishedPosts first title 
		equals: 'IsLoop'
]

{ #category : 'overviewBuilder' }
FOBlogAfterConversionTest >> testOverviewBuilderCreatesPageWithDocumentHavingRawChildren [

	| builder page |
	builder := FOBlogOverviewBuilder new.
	builder
		blog: blog;
		numberOfCharacters: 100. 
	page := builder buildSummary.
	self assert: page title equals: blog title.
	self assert: page layout equals: blog layout.
	self 
		assert: page document children size 
		equals: 2.
	
	self 
		assert: page document children first class 
		equals: MicRawBlock
]
