Class {
	#name : 'FOBrokenDateBlogTest',
	#superclass : 'TestCase',
	#instVars : [
		'root',
		'blog',
		'site',
		'filesystem'
	],
	#category : 'Foliage-Core-Tests-Blog',
	#package : 'Foliage-Core-Tests',
	#tag : 'Blog'
}

{ #category : 'running' }
FOBrokenDateBlogTest >> brokenDateGsocContentsMD [

	^ '{
"title" : "Google Summer of Code",
"layout" : "default",
"publishDate" : "2019-05-51"
}

# Google Summer of Code 2019 Students


On this page, you can find the personal blogs and social media links of the seven students accepted for Google Summer of Code with Pharo Consortium in 2019. Follow their pages to get regular updates on their progress. Don''t hesitate to get in touch with those students - they need your feedback.'
]

{ #category : 'running' }
FOBrokenDateBlogTest >> nilDateGsocContentsMD [

	^ '{
"title" : "Google Summer of Code",
"layout" : "default"
}

# Google Summer of Code 2019 Students


On this page, you can find the personal blogs and social media links of the seven students accepted for Google Summer of Code with Pharo Consortium in 2019. Follow their pages to get regular updates on their progress. Don''t hesitate to get in touch with those students - they need your feedback.'
]

{ #category : 'running' }
FOBrokenDateBlogTest >> setUp [ 

	filesystem := FileSystem memory.
	(filesystem / 'site' / 'success') ensureCreateDirectory.
	filesystem / 'site' / 'success' / 'broken.md'
		writeStreamDo: [ :st | st nextPutAll: self brokenDateGsocContentsMD ].
	filesystem / 'site' / 'success' / 'niled.md'
		writeStreamDo: [ :st | st nextPutAll: self nilDateGsocContentsMD ].
	
	"this looks too much just to test a date in a metadata of a file.
	There is something wrong."	
	
	site := FOWebSite new.
	site sourcePath: (filesystem / 'site') fullName.
	site importDirectory: filesystem root / 'site'.
	blog := (site / 'success') convertToBlog.
	blog title: 'Super success'.
]

{ #category : 'running' }
FOBrokenDateBlogTest >> testBlogItems [

	
	self assert: blog items size equals: 2.
	self assert: blog publishedPosts size equals: 0.
]

{ #category : 'running' }
FOBrokenDateBlogTest >> testBrokenDateGetsASubstitutionDate [
	self flag: #todiscuss.
	"Should we create a default date...
	At least we should report a problem because just turning it into nil and 
	filtering nil is lame to me."

	self assert: (blog items at: 'broken.md') publishDate isNil
]

{ #category : 'running' }
FOBrokenDateBlogTest >> testNilDateGetsASubstitutionDate [
	self flag: #todiscuss.
	"Should we create a default date...
	At least we should report a problem because just turning it into nil and 
	filtering nil is lame to me."

	self assert: (blog items at: 'niled.md') publishDate isNil
]
