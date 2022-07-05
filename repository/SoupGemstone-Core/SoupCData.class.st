Class {
	#name : #SoupCData,
	#superclass : #SoupString,
	#category : 'SoupGemstone-Core'
}

{ #category : #testing }
SoupCData >> isCData [
	^ true
]

{ #category : #printing }
SoupCData >> printOn: aStream [
	aStream 
		nextPutAll: '<![CDATA[';
		nextPutAll: contents;
		nextPutAll: ']]>'
]
