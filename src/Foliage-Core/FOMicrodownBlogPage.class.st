"
I represent the main (index.html) entry of a blog. 
I contain abstracts of the posts.
"
Class {
	#name : 'FOMicrodownBlogPage',
	#superclass : 'FOMicrodownPage',
	#category : 'Foliage-Core-Blog',
	#package : 'Foliage-Core',
	#tag : 'Blog'
}

{ #category : 'instance creation' }
FOMicrodownBlogPage >> renderContextClass [

	^ FOBlogRenderContext
]
