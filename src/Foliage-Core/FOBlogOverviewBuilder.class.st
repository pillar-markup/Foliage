"
I'm responsible to assemble the main page, instance of `FOMicrodownBlogPage`, of the blog with abstracts of the blog posts.
"
Class {
	#name : 'FOBlogOverviewBuilder',
	#superclass : 'Object',
	#instVars : [
		'blog',
		'numberOfCharacters'
	],
	#category : 'Foliage-Core-Blog',
	#package : 'Foliage-Core',
	#tag : 'Blog'
}

{ #category : 'accessing' }
FOBlogOverviewBuilder >> amountOfCharacters [
	^ numberOfCharacters ifNil: [ 
		numberOfCharacters := self defaultNumberOfCharacters ]
]

{ #category : 'accessing' }
FOBlogOverviewBuilder >> blog: aBlog [

	blog := aBlog
]

{ #category : 'building' }
FOBlogOverviewBuilder >> buildAbstract: aPage [
	"Return the Mic object corresponding to the abstract of a page."
	
	"The logic is a bit ugly: 
		- first render the abstract 
		- then create a piece of text.
		
	This is a bit ugly to get HTML this forces us to use a RawBlock."
	
	^ MicRawBlock new bodyString: aPage renderAbstract
]

{ #category : 'building' }
FOBlogOverviewBuilder >> buildSummary [

	| rawAbstracts document |
	rawAbstracts := self publishedPosts 
		collect: [ :post | self buildAbstract: post ].
	
	document := MicRootBlock new.
	rawAbstracts do: [ :each | document addChild: each ].
	
	^ FOMicrodownBlogPage new 
		metaAt: 'layout' put: blog layout;
		metaAt: 'title' put: blog title;
		parent: blog parent;
		document: document
	
]

{ #category : 'accessing' }
FOBlogOverviewBuilder >> defaultNumberOfCharacters [

	^ 500
]

{ #category : 'accessing' }
FOBlogOverviewBuilder >> numberOfCharacters: anObject [

	numberOfCharacters := anObject
]

{ #category : 'page creation' }
FOBlogOverviewBuilder >> publishedPosts [

	^ (blog posts select: [:each | each isPublished]) 
			sorted: #publishDate descending
]
