Class {
	#name : 'FOMicrodownBlogPost',
	#superclass : 'FOMicrodownPage',
	#category : 'Foliage-Core-Blog',
	#package : 'Foliage-Core',
	#tag : 'Blog'
}

{ #category : 'accessing' }
FOMicrodownBlogPost >> abstract [
	
	^ FOAbstractWriterVisitor new 
		amountOfCharacters: self abstractAmountOfCharacters;
		post: self
]

{ #category : 'scripting - layouts' }
FOMicrodownBlogPost >> abstractLayout [

	^ self meta 
		at: 'abstractLayout'
		ifAbsent: [ self defaultAbstractLayout ]	
]

{ #category : 'scripting - layouts' }
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
FOMicrodownBlogPost >> renderAbstract [
	"Using the corresponding template, launch the rendering of the abstract."
	
	^ self newRenderContext renderTemplate: self abstractTemplate
]

{ #category : 'instance creation' }
FOMicrodownBlogPost >> renderContextClass [

	^ FOBlogPostRenderContext 
]
