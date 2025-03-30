Class {
	#name : 'FOMicrodownBlogPost',
	#superclass : 'FOMicrodownPage',
	#category : 'Foliage-Core-Blog',
	#package : 'Foliage-Core',
	#tag : 'Blog'
}

{ #category : 'accessing' }
FOMicrodownBlogPost >> abstract [
	
	self halt.
	^ FOPillarTruncateVisitor new 
		amountOfCharacters: self abstractAmountOfCharacters;
		post: self
]

{ #category : 'accessing' }
FOMicrodownBlogPost >> abstractLayout [

	^ self meta 
		at: 'abstractLayout'
		ifAbsent: [ self defaultAbstractLayout ]	
]

{ #category : 'accessing' }
FOMicrodownBlogPost >> abstractTemplate [

	^ (self website templatePathForLayout: self abstractLayout) asMustacheTemplate.
]

{ #category : 'visiting' }
FOMicrodownBlogPost >> acceptFOVisitor: aFOVisitor [ 
	^ aFOVisitor visitBlogPost: self 
]

{ #category : 'accessing' }
FOMicrodownBlogPost >> defaultAbstractLayout [

	^ 'blog-post-abstract'
]

{ #category : 'accessing' }
FOMicrodownBlogPost >> defaultLayout [

	^ 'blogpost'
]

{ #category : 'testing' }
FOMicrodownBlogPost >> isPost [

	^ true
]

{ #category : 'accessing' }
FOMicrodownBlogPost >> publicationDate [

	^ self meta 
		at: 'publishDate'
		ifPresent: [ :aString | aString asDate ]
		ifAbsent: [ nil ]
]

{ #category : 'accessing' }
FOMicrodownBlogPost >> renderAbstract [

	^ self newRenderContext renderTemplate: self abstractTemplate
]

{ #category : 'instance creation' }
FOMicrodownBlogPost >> renderContextClass [

	^ FOBlogPostRenderContext 
]
