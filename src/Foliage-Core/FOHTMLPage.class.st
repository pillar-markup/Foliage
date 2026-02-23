"
I'm an html file. I'm usually written in HTML format. 
"
Class {
	#name : 'FOHTMLPage',
	#superclass : 'FOFileBasedWebEntity',
	#category : 'Foliage-Core-Model',
	#package : 'Foliage-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
FOHTMLPage class >> supportedFileExtensions [
	^ #( html )
]

{ #category : 'visiting' }
FOHTMLPage >> acceptFOVisitor: aFOVisitor [ 
	^ aFOVisitor visitHTMLPageSource: self 
]

{ #category : 'conversion' }
FOHTMLPage >> asFOBlogPost [
	
	self flag: #todoSD.
	"the import should do it systematically for all the kind of page we have."
	
	^ self as: FOMicrodownBlogPost
]

{ #category : 'hooks' }
FOHTMLPage >> newRenderContext [
	"In addition, just pass the page to the rendering context"
	
	^ super newRenderContext page: self 
]

{ #category : 'hooks' }
FOHTMLPage >> renderContextClass [

	^ FOMicrodownPageRenderContext
]

{ #category : 'html' }
FOHTMLPage >> templatedContents [

	^ nil
]
