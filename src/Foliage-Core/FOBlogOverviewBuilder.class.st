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
		
	"This is a bit ugly to get HTML this forces us to use a RawBlock."
	
	^ MicRawBlock new bodyString: aPage renderAbstract
]

{ #category : 'building' }
FOBlogOverviewBuilder >> buildSummary [
	| abstracts |

	abstracts := self publishedPosts 
		collect: [ :post | self buildAbstract: post ].

	self flag: #todo.
	self halt: 'Should migrate to microdown'.
	"how to organite layouts for in-memory pages??"
	^ FOBlogPage new 
		metaAt: 'layout' put: blog layout;
		metaAt: 'title' put: blog title;
		parent: blog parent;
		pillar: (PRDocument new
			setChildren: abstracts;
			yourself)
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

	^ (blog posts select: #isPublished) sorted: #publishDate descending
]
