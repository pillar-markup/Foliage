Class {
	#name : 'FOFullPublicationPage',
	#superclass : 'FOMicrodownPage',
	#category : 'Foliage-Bib',
	#package : 'Foliage-Bib'
}

{ #category : 'visiting' }
FOFullPublicationPage >> acceptFOVisitor: aVisitor [

	^ aVisitor visitMicrodownPage: self
]

{ #category : 'instance creation' }
FOFullPublicationPage >> renderContextClass [

	^ FOBlogRenderContext
]
