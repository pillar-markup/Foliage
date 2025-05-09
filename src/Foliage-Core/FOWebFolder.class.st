Class {
	#name : 'FOWebFolder',
	#superclass : 'FOWebContainer',
	#category : 'Foliage-Core-Model',
	#package : 'Foliage-Core',
	#tag : 'Model'
}

{ #category : 'visiting' }
FOWebFolder >> acceptFOVisitor: aFOVisitor [ 
	^ aFOVisitor visitWebFolder: self 
]

{ #category : 'conversion' }
FOWebFolder >> buildRssFeed [
	^ (FORSSVisitor new
		visit: self)
			parent: self
]

{ #category : 'conversion' }
FOWebFolder >> convertToBlog [ 

	| blog |
	blog := FOBlog new
		title: 'Blog';
		parent: parent;
		setItems: (items associations collect: [ :assoc |
			assoc value isPage 
				ifTrue: [ assoc key -> (assoc value asFOBlogPost) ]
				ifFalse: [ assoc ] ] ) asDictionary.
	parent 
		replace: self 
		with: blog.
	^ blog
		
]

{ #category : 'conversion' }
FOWebFolder >> createOnTarget [
	self publishPath ensureCreateDirectory 
]

{ #category : 'conversion' }
FOWebFolder >> emitSelectors [

	^ #(name)
]

{ #category : 'tools' }
FOWebFolder >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite fastTable 
		title: 'Items';
		display: [ 
			self isRoot 
				ifTrue: [ items values ]
				ifFalse: [ 
					items values asOrderedCollection 
						addFirst: self parent;
						yourself ] ];
		column: 'Name' evaluated: [:each | (self isChildOf: each) 
			ifTrue: [ '..' ] 
			ifFalse: [ each displayString ]] width: 400
		
]

{ #category : 'testing' }
FOWebFolder >> isRoot [
	^ false
]

{ #category : 'accessing' }
FOWebFolder >> name [
	^ parent nameOf: self
]

{ #category : 'printing' }
FOWebFolder >> printOn: aStream [
	aStream << self path asString << '/'
]

{ #category : 'conversion' }
FOWebFolder >> replace: oldResource with: newResource [ 
	items 
		at: oldResource name 
		put: newResource 
]

{ #category : 'resolving' }
FOWebFolder >> resolvePath: aRelativePath [ 
	| child |
	aRelativePath isEmpty ifTrue: [ ^ self ].
	child := items 
		at: aRelativePath segments first
		ifAbsentPut: [ 
			FOWebFolder new 
				parent: self ].
	^ child resolvePath: (RelativePath withAll: aRelativePath segments allButFirst)
]

{ #category : 'conversion' }
FOWebFolder >> rssFeed [
	^ self 
		propertyAt: #rssFeed
		ifAbsentPut: [ self buildRssFeed ]
]
