Class {
	#name : #SoupProcessingInstruction,
	#superclass : #SoupString,
	#category : 'SoupGemstone-Core'
}

{ #category : #testing }
SoupProcessingInstruction >> isProcessingInstruction [
	^ true
]

{ #category : #printing }
SoupProcessingInstruction >> printOn: aStream [
	aStream 
		nextPutAll: '<?';
		nextPutAll: contents;
		nextPutAll: '>'
]
