Extension { #name : #Soup }

{ #category : #'*Soup-Platform' }
Soup class >> get: aString [

	^ HTTPClient httpGet: aString.
]
