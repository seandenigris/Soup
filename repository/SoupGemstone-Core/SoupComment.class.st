Class {
	#name : #SoupComment,
	#superclass : #SoupString,
	#category : 'SoupGemstone-Core'
}

{ #category : #testing }
SoupComment >> isComment [
	^ true
]

{ #category : #printing }
SoupComment >> printOn: aStream [
	aStream 
		nextPutAll: '<!--';
		nextPutAll: contents;
		nextPutAll: '-->'
]
