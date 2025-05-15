Class {
	#name : 'FORSSFeed',
	#superclass : 'FOWebResource',
	#instVars : [
		'channels'
	],
	#category : 'Foliage-Feed',
	#package : 'Foliage-Feed'
}

{ #category : 'visiting' }
FORSSFeed >> acceptFOVisitor: aFOVisitor [ 
	^ aFOVisitor visitRSSFeed: self 
]

{ #category : 'adding' }
FORSSFeed >> addChannel: aFORSSChannel [ 
	self channels add: aFORSSChannel 
]

{ #category : 'as yet unclassified' }
FORSSFeed >> addHeadersTo: aPage [
	| htmlDocument head |
	
	htmlDocument := aPage htmlDocument.
	head := (htmlDocument / #html / #head) first.
	head addChild: ((SoupTag named: #link)
		attributeAt: #rel put: self rel;
		attributeAt: #href put: self href printString;
		attributeAt: #type put: self linkType;
		attributeAt: #title put: self title;
		beSelfClosing;
		yourself)
]

{ #category : 'accessing' }
FORSSFeed >> channels [
	^ channels ifNil: [ 
		channels := OrderedCollection new ]
]

{ #category : 'accessing' }
FORSSFeed >> href [
	^ self absoluteLink 
]

{ #category : 'accessing' }
FORSSFeed >> linkType [
	^ 'application/rss+xml'
]

{ #category : 'accessing' }
FORSSFeed >> pathString [
	^ (self path withExtension: #xml) pathString
]

{ #category : 'accessing' }
FORSSFeed >> rel [
	^ #alternate
]

{ #category : 'accessing' }
FORSSFeed >> title [
	^ 'blog'
]
