Extension { #name : #SoupTag }

{ #category : #'*Soup-Tools-Inspector' }
SoupTag >> gtInspectChildrenOn: composite [
	<gtInspectorPresentationOrder: 0>  
	
	^ (composite tree)	 
			shouldValidate: false;
			title: 'Children';
			display: [ children ];
			children: [ :each | 
					each isTag 
							ifTrue: [ each children 	] 
							ifFalse: [#()] ];
			format: [:each | 
					each isTag 
							ifTrue: [ each name ]
						   ifFalse: [ each printString ] ]
]

{ #category : #'*Soup-Tools-Inspector' }
SoupTag >> gtInspectorAttributesIn: composite [
	<gtInspectorPresentationOrder: 6>  
	
	^(composite table)	 
		title: 'Attributes';
		display: [:each | attributes associations ];
		column: 'Key' evaluated: #key;
		column: 'Value' evaluated: #value.
]

{ #category : #'*Soup-Tools-Inspector' }
SoupTag >> gtInspectorContentsIn: composite [
	<gtInspectorPresentationOrder: 4> 
	composite text 
		title: 'Contents';
		display: [ :anObject | anObject asString ]				   
]
