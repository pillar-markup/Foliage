Class {
	#name : 'FOFullPublicationPage',
	#superclass : 'FOMicrodownPage',
	#category : 'Foliage-Core-Blog',
	#package : 'Foliage-Core',
	#tag : 'Blog'
}

{ #category : 'visiting' }
FOFullPublicationPage >> acceptFOVisitor: aVisitor [

	^ aVisitor visitMicrodownPage: self
]

{ #category : 'instance creation' }
FOFullPublicationPage >> renderContextClass [

	^ FOBlogRenderContext
]
