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
	summaryPageObject := blog items at: #'index.html'.
	self assert: summaryPageObject document children size equals: 2
	
]

{ #category : 'failing tests' }
FOBlogAfterConversionTest >> testBlogOverviewRender [

	| summaryPageObject |
	self skip. 
	"we should has template in the fileSystem too."
	
	summaryPageObject := blog items at: #'index.html'.
	self halt.
	self assert: summaryPageObject html
	
]

{ #category : 'running' }
FOBlogAfterConversionTest >> testBlogPostHasMetaData [
	
	self assert: blog publishedPosts first publicationDate printString equals: '21 May 2019'.
	self assert: blog publishedPosts first layout  equals: 'default'.
	self assert: blog publishedPosts first title equals: 'Google Summer of Code'.
]

{ #category : 'overviewBuilder' }
FOBlogAfterConversionTest >> testOverviewBuilder [

	| o |
	o := FOBlogOverviewBuilder new 
		blog: blog;
		numberOfCharacters: 100; 
		buildSummary.
		
	self halt.
]
