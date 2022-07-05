Class {
	#name : #SoupDeclaration,
	#superclass : #SoupString,
	#category : 'SoupGemstone-Core'
}

{ #category : #testing }
SoupDeclaration >> isDeclaration [
	^ true
]

{ #category : #printing }
SoupDeclaration >> printOn: aStream [
	aStream 
		nextPutAll: '<!';
		nextPutAll: contents;
		nextPutAll: '>'
]
