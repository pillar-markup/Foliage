Extension { #name : 'MicHTMLVisitor' }

{ #category : '*Foliage-Bib' }
MicHTMLVisitor >> visitPublication: aMicPublication [ 
	
	canvas tag
		name: 'li';
		with: [ 
			| czVisitor |
			czVisitor :=  CZRawHTMLGenerator new.
			aMicPublication pub acceptVisitor: czVisitor.
			canvas nextPutAll: czVisitor contents ].
	canvas newLine.
	
	"CZAccentuateCharactersParser parseToAccentedChars:"
]

{ #category : '*Foliage-Bib' }
MicHTMLVisitor >> visitPublicationSection: aMicPublicationSection [ 
	
	canvas newLine.	
	canvas tag 
		name: 'h2';
		with: [ canvas nextPutAll: aMicPublicationSection title ].		
				
	canvas tag
		name: 'ol';
		with: [ 
			canvas newLine. 		
			aMicPublicationSection items do: [ :each | each accept: self ] ]. 
	
	 
]
