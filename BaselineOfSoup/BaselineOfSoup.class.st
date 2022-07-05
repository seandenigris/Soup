Class {
	#name : #BaselineOfSoup,
	#superclass : #BaselineOf,
	#category : 'BaselineOfSoup'
}

{ #category : #catalog }
BaselineOfSoup class >> catalogChangeLog [
		
 ^ '
-1/10/2013 - Migrated to XMLParser.
[[[
(ConfigurationOfSoup project version: #''stable'') load
(ConfigurationOfSoup project version: ''1.5'') load
]]]

- Version 1. 4 21/02/2013 migrated to SmalltalkHub
[[[
(ConfigurationOfSoup project version: ''1.4'') load
]]]
- Version 1.3  adding better stable version.
[[[
(ConfigurationOfSoup project version: ''1.3'') load
]]]
'
	
	
]

{ #category : #catalog }
BaselineOfSoup class >> catalogContactInfo [
	^ 'Contact the Pharo mailing-list since this package is maintained by S. Ducasse and S. De Nigris'
]

{ #category : #catalog }
BaselineOfSoup class >> catalogDescription [

^ 
'Soup is a frameworks for scrapping HTML. It offers a simplified query mechanism to abstract over the XML and HTML structures of a document.'
]

{ #category : #catalog }
BaselineOfSoup class >> catalogKeyClassesAndExample [

	^ 'It is composed of some keys classes: 
		
- ==SoupElement== is the root of elements that are extracted during the parsing of an HTML document. Contrary to traditional HTML Parser, Soup produces a limited set of elements which approximate the HTML elements but supports querying and extracting information. 
		
- Soup. ==Soup== is the main public class of the package. It is the class to interact with as shown by the tests.

The best way to get started is to get a soup of html elements using ==Soup class>>fromString:== as follows:

[[[ 
	Soup fromString: ''http://www.bedetheque.com/album-105582-BD-Atomium-Express.html'' 
	    asUrl retrieveContents
]]]
	
Tests of the ==Soup== class are the place to start to learn the API.'
]

{ #category : #catalog }
BaselineOfSoup class >> catalogKeywords [
	^ #(HTML web query scrapping Soup XPath)
	
]

{ #category : #baselines }
BaselineOfSoup >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: 'Soup-Core';
			package: 'Soup-XPath' with: [
				spec requires: #('Soup-Core' ). ];
			package: 'Soup-Help' with: [
				spec requires: #('Soup-Core' ). ];
			package: 'Soup-Tests-Core' with: [
				spec requires: #('Soup-Core' ). ];
			package: #'Soup-Tools' with: [
				spec requires: #('Soup-Core' 'Soup-XPath' 'Soup-Help' ). ].
		spec 
			group: 'Tests' with: #('Soup-Tests-Core' );
			group: 'default' with: #('Core' 'Tests' 'Tools' );
			group: 'Core' with: #('Soup-Core' 'Soup-XPath' );
			group: 'Tools' with: #(#'Soup-Tools' ). ].
			
	spec for: #notGToolkit do: [
		spec baseline: 'XMLParser' with: [
			spec repository: 'github://pharo-contributions/XML-XMLParser' ].
		spec package: 'Soup-Core' with: [
			spec requires: #('XMLParser' ). ] ].

	spec for: #GToolkit do: [
		spec package: 'Soup-GToolkit' with: [
			spec requires: #('Soup-Core' ). ] ].

]

{ #category : #accessing }
BaselineOfSoup >> customProjectAttributes [
	^ self isGTImage
			ifFalse: [ #(notGToolkit) ]
			ifTrue: [ #(GToolkit) ]
]

{ #category : #testing }
BaselineOfSoup >> isGTImage [
	
	^ RPackageOrganizer default packageNames anySatisfy: [ :pn | pn beginsWith: 'Lepiter-' ].
	"Implementation note: used to check for GToolkit prefix, but P7 has a GToolkit-Examples package. Lepiter, OTOH, could only be loaded in a GT image"
]
