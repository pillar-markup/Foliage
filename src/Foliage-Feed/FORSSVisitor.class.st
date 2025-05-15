Class {
	#name : 'FORSSVisitor',
	#superclass : 'FOModelVisitor',
	#category : 'Foliage-Feed',
	#package : 'Foliage-Feed'
}

{ #category : 'visiting' }
FORSSVisitor >> visitBlog: aFOBlog [ 
	| feed channel |
	feed := FORSSFeed new.
	channel := FORSSChannel new
		title: 'fo';
		link: 'https://norbert.hartl.name/blog/rss.xml';
		description: 'the general channel'.
	channel items: (super visitAll: aFOBlog posts).
	feed addChannel: channel. 
	"(aFOBlog website resolve: '/index.md') addHeaderLink: feed."
	^ feed
]

{ #category : 'visiting' }
FORSSVisitor >> visitBlogPost: aFOBlogPost [ 
	^ self visitMicrodownPage: aFOBlogPost
]
