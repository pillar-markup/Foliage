Class {
	#name : 'FOPageWithMetadata',
	#superclass : 'FOHTMLPage',
	#instVars : [
		'meta'
	],
	#category : 'Foliage-Core-Model',
	#package : 'Foliage-Core',
	#tag : 'Model'
}

{ #category : 'testing' }
FOPageWithMetadata class >> isAbstract [ 
	^ self == FOPageWithMetadata  
]

{ #category : 'accessing' }
FOPageWithMetadata >> defaultLayout [

	^ self parent defaultLayout
]

{ #category : 'logging' }
FOPageWithMetadata >> emitSlots [

	^ super emitSlots, #(meta)
]

{ #category : 'testing' }
FOPageWithMetadata >> hasLayout [
	^ meta includesKey: 'layout'
]

{ #category : 'testing' }
FOPageWithMetadata >> hasPlugin [

 ^  meta
		at: #plugin 
		ifPresent: [ :string | true ]
		ifAbsent: [ false ] 
]

{ #category : 'testing' }
FOPageWithMetadata >> isPage [
	^ true
]

{ #category : 'testing' }
FOPageWithMetadata >> isPublished [
	^ self publishDate notNil
]

{ #category : 'accessing' }
FOPageWithMetadata >> layout [
	
	^ self meta 
		at: 'layout'
		ifAbsent: [ self defaultLayout ]
]

{ #category : 'accessing' }
FOPageWithMetadata >> layout: aString [
	^ self meta 
		at: 'layout'
		put: aString
]

{ #category : 'accessing' }
FOPageWithMetadata >> meta [
	^ meta ifNil: [ 
		meta := Dictionary new ]
]

{ #category : 'accessing' }
FOPageWithMetadata >> meta: aCollection [ 
	meta := aCollection 
]

{ #category : 'accessing' }
FOPageWithMetadata >> metaAt: key put: value [
	
	self meta 
		at: key
		put: value
]

{ #category : 'plugins' }
FOPageWithMetadata >> plugin [

 ^  meta
		at: #plugin 
		ifPresent: [ :aDict | aDict ]
		
]

{ #category : 'plugins' }
FOPageWithMetadata >> pluginKind [
	
	^  meta
		at: #plugin 
		ifPresent: [ :aDict | aDict asDictionary at: 'kind' ifAbsent: [ self error: 'Missing plugin kind' ]]
		ifAbsent: [ self error: 'Missing plugin' ]
		
]

{ #category : 'plugins' }
FOPageWithMetadata >> pluginSpec [

 ^  meta
		at: #plugin 
		ifPresent: [ :aDict | 
				| res |
				res := aDict asDictionary 
									at: #pluginSpec 
									ifAbsent: [ self error: 'Missing plugin spec' ].
				res asDictionary ]
		ifAbsent: [ self error: 'Missing plugin' ]
		
]

{ #category : 'accessing' }
FOPageWithMetadata >> publishDate [
	^ self meta 
		at: #publishDate 
		ifPresent: [ :string |
			"reading from file an empty date easily ends up being an 
			empty string so we consider it absent in this case" 
			[ string 
				ifNotEmpty: [ Date readFrom: string pattern: 'yyyy-mm-dd'  ]
				ifEmpty: [ nil ]
				] on: DateError do: [ nil ]
				]
		ifAbsent: [ nil ]
]

{ #category : 'accessing' }
FOPageWithMetadata >> title [
	^ self meta at: 'title'
]

{ #category : 'accessing' }
FOPageWithMetadata >> title: aString [ 
	self meta 
		at: 'title'
		put: aString
]
