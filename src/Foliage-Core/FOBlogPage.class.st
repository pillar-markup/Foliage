Class {
	#name : 'FOBlogPage',
	#superclass : 'FOPillarPage',
	#category : 'Foliage-Core-Blog',
	#package : 'Foliage-Core',
	#tag : 'Blog'
}

{ #category : 'rendering' }
FOBlogPage >> renderContextClass [

	^ FOBlogRenderContext
]
