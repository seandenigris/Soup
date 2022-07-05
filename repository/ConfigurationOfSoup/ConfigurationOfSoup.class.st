"
!!!Current loading expressions and dev history

1/10/2013 - Migrated to XMLParser.
[[[
(ConfigurationOfSoup project version: #'stable') load
(ConfigurationOfSoup project version: '1.5') load
]]]

[[[
(ConfigurationOfSoup project version: #'development') load
(ConfigurationOfSoup project version: '1.4') load
]]]

21/02/2013 - Migrated to SmalltalkHub.
[[[
(ConfigurationOfSoup project version: '1.4') load
]]]

Adding better stable version.
[[[
(ConfigurationOfSoup project version: '1.3') load
]]]

Todo: update when XMLSupport will be migrated to Smalltalk.
"
Class {
	#name : #ConfigurationOfSoup,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : 'ConfigurationOfSoup'
}

{ #category : #private }
ConfigurationOfSoup class >> bootstrapPackage: aString from: aPath [ 
	| repository version |
	repository := MCHttpRepository
				location: aPath
				user: ''
				password: ''.
	repository
		versionReaderForFileNamed: aString , '.mcz'
		do: [:reader | 
			version := reader version.
			version load.
			version workingCopy repositoryGroup addRepository: repository]
]

{ #category : #catalog }
ConfigurationOfSoup class >> catalogChangeLog [
		
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
ConfigurationOfSoup class >> catalogContactInfo [
	^ 'Contact the Pharo mailing-list since this package is maintained by S. Ducasse and S. De Nigris'
]

{ #category : #catalog }
ConfigurationOfSoup class >> catalogDescription [

^ 
'Soup is a frameworks for scrapping HTML. It offers a simplified query mechanism to abstract over the XML and HTML structures of a document.'
]

{ #category : #catalog }
ConfigurationOfSoup class >> catalogKeyClassesAndExample [

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
ConfigurationOfSoup class >> catalogKeywords [
	^ #(HTML web query scrapping Soup XPath)
	
]

{ #category : #private }
ConfigurationOfSoup class >> ensureMetacello [
	"Bootstrap Gofer (if necessary), bootstrap ConfigurationOfMetacello (using old Gofer API), then load the latest 
	version of Metacello itself."

	Smalltalk at: #MetacelloProject ifAbsent: [
		Smalltalk at: #Gofer ifAbsent: [
			"Current version of Gofer from which to bootstrap - as of 1.0-beta.21"
			self bootstrapPackage: 'Gofer-Core-lr.115' from: 'http://seaside.gemstone.com/ss/metacello' ].
		Smalltalk at: #Gofer ifPresent: [:goferClass | | gofer |
			gofer := goferClass new
				url: 'http://seaside.gemstone.com/ss/metacello';
				yourself.
			[ gofer addPackage: 'ConfigurationOfMetacello' ] on: Warning do: [:ex | ex resume ].
			gofer load ].
		"load 'default' group of Metacello"
		(Smalltalk at: #ConfigurationOfMetacello) perform: #load ]
]

{ #category : #'metacello support' }
ConfigurationOfSoup class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello support' }
ConfigurationOfSoup class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #load }
ConfigurationOfSoup class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #load }
ConfigurationOfSoup class >> loadDefault [
	"self loadDefault"

	"^ self loadMostRecentCoreWithTests"
	^ self load.
]

{ #category : #load }
ConfigurationOfSoup class >> loadMostRecentCoreWithTests [
	^self project lastVersion load: #('Core' 'Tests')
]

{ #category : #'metacello support' }
ConfigurationOfSoup class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfSoup class >> project [

	^self new project
]

{ #category : #'metacello support' }
ConfigurationOfSoup class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #baselines }
ConfigurationOfSoup >> baseline10: spec [
	<version: '1.0-baseline'>
	spec
		for: #pharo
		do: [ 
			spec blessing: #baseline.
			spec description: 'First Full Configuration'.
			spec author: 'StephaneDucasse'.
			spec timestamp: '29/12/2011 12:29'.
			spec repository: 'http://www.squeaksource.com/Soup'.
			spec
				package: 'Soup-Core' with: [ spec requires: 'XMLSupport' ];
				package: 'Soup-Tests-Core' with: [ spec requires: 'Soup-Core' ];
				package: 'Soup-Help' with: [ spec requires: 'Soup-Core' ].
			spec
				project: 'XMLSupport'
				with: [ 
					spec
						className: 'ConfigurationOfXMLSupport';
						versionString: #stable;
						repository: 'http://www.squeaksource.com/XMLSupport' ] ]
]

{ #category : #baselines }
ConfigurationOfSoup >> baseline11: spec [
	<version: '1.1-baseline'>
	spec
		for: #pharo
		do: [ 
			spec blessing: #baseline.
			spec description: 'Adding Camillo Bruni XPath extension'.
			spec author: 'StephaneDucasse'.
			spec timestamp: '31/12/2011 12:29'.
			spec repository: 'http://www.squeaksource.com/Soup'.
			spec
				package: 'Soup-Core' with: [ spec requires: 'XMLSupport' ];
				package: 'Soup-Tests-Core' with: [ spec requires: 'Soup-Core' ];
				package: 'Soup-Help' with: [ spec requires: 'Soup-Core' ];
				package: 'Soup-XPath' with: [ spec requires: 'Soup-Core' ].
			spec
				project: 'XMLSupport'
				with: [ 
					spec
						className: 'ConfigurationOfXMLSupport';
						versionString: #stable;
						repository: 'http://www.squeaksource.com/XMLSupport' ] ]
]

{ #category : #baselines }
ConfigurationOfSoup >> baseline13: spec [
	<version: '1.3-baseline'>
	spec
		for: #pharo
		do: [ 
			spec blessing: #baseline.
			spec description: 'Adding Camillo Bruni XPath extension'.
			spec author: 'StephaneDucasse'.
			spec timestamp: '31/12/2011 12:29'.
			spec repository: 'http://www.squeaksource.com/Soup'.
			spec
				package: 'Soup-Core' with: [ spec requires: 'XMLSupport' ];
				package: 'Soup-Tests-Core' with: [ spec requires: 'Soup-Core' ];
				package: 'Soup-Help' with: [ spec requires: 'Soup-Core' ];
				package: 'Soup-XPath' with: [ spec requires: 'Soup-Core' ].
			spec
				project: 'XMLSupport'
				with: [ 
					spec
						className: 'ConfigurationOfXMLSupport';
						versionString: #stable;
						repository: 'http://www.squeaksource.com/XMLSupport' ] ].
	spec
		for: #zinc
		do: [ 
			spec
				package: 'Soup-Zinc';
				package: 'Soup-Core' with: [ spec includes: 'Soup-Zinc' ] ]
]

{ #category : #baselines }
ConfigurationOfSoup >> baseline14: spec [
  <version: '1.4-baseline'>
  spec
    for: #'squeakCommon'
    do: [ 
      spec blessing: #'baseline'.
      spec description: 'Migrated to SmalltalkHub'.
      spec author: 'StephaneDucasse'.
      spec timestamp: '21/02/2013'.
      spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/Soup/main'.
      spec
        package: 'Soup-Core' with: [ spec requires: 'XMLSupport' ];
        package: 'Soup-Tests-Core' with: [ spec requires: 'Soup-Core' ];
        package: 'Soup-Help' with: [ spec requires: 'Soup-Core' ];
        package: 'Soup-XPath' with: [ spec requires: 'Soup-Core' ];
        package: 'Soup-Zinc' with: [ spec requires: 'Soup-Core' ].
      spec
        project: 'XMLSupport'
        with: [ 
          spec
            className: 'ConfigurationOfXMLSupport';
            versionString: #'stable';
            repository: 'http://www.squeaksource.com/XMLSupport' ].
      spec
        group: 'default' with: #('Core' 'Tests');
        group: 'Core' with: #('Soup-Core' 'Soup-XPath');
        group: 'Tests' with: #('Soup-Tests-Core') ].
  spec
    for: #'gemstone'
    do: [ 
      spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/Soup/main'.
      spec
        project: 'XMLSupport'
        with: [ 
          spec
            className: 'ConfigurationOfXMLSupport';
            versionString: #'stable';
            repository: 'http://squeaksource.com/MetacelloRepository' ].
      spec
        package: 'SoupGemstone-Core' with: [ spec requires: 'XMLSupport' ];
        package: 'Soup-Tests-Core' with: [ spec requires: 'SoupGemstone-Core' ];
        package: 'Soup-Help' with: [ spec requires: 'SoupGemstone-Core' ];
        package: 'Soup-XPath' with: [ spec requires: 'SoupGemstone-Core' ];
        package: 'Soup-Zinc' with: [ spec requires: 'SoupGemstone-Core' ].
      spec
        group: 'default' with: #('Core' 'Tests');
        group: 'Core' with: #('SoupGemstone-Core');
        group: 'Tests' with: #('Soup-Tests-Core') ]
]

{ #category : #baselines }
ConfigurationOfSoup >> baseline15: spec [
  <version: '1.5-baseline'>
  spec
    for: #'squeakCommon'
    do: [ 
      spec blessing: #'baseline'.
      spec description: 'Using now XMLParser'.
      spec author: 'StephaneDucasse'.
      spec timestamp: '1/10/2013'.
      spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/Soup/main'.
      spec
        package: 'Soup-Core' with: [ spec requires: 'XMLParser' ];
        package: 'Soup-Tests-Core' with: [ spec requires: 'Soup-Core' ];
        package: 'Soup-Help' with: [ spec requires: 'Soup-Core' ];
        package: 'Soup-XPath' with: [ spec requires: 'Soup-Core' ];
        package: 'Soup-Zinc' with: [ spec requires: 'Soup-Core' ].
      spec
        project: 'XMLParser'
        with: [ 
          spec
            className: 'ConfigurationOfXMLParser';
            versionString: #'stable';
            repository:
                'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
      spec
        group: 'default' with: #('Core' 'Tests');
        group: 'Core' with: #('Soup-Core' 'Soup-XPath');
        group: 'Tests' with: #('Soup-Tests-Core') ].
  spec
    for: #'gemstone'
    do: [ 
      spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/Soup/main'.
      spec
        project: 'XMLSupport'
        with: [ 
          spec
            className: 'ConfigurationOfXMLSupport';
            versionString: #'stable';
            repository: 'http://squeaksource.com/MetacelloRepository' ].
      spec
        package: 'SoupGemstone-Core' with: [ spec requires: 'XMLSupport' ];
        package: 'Soup-Tests-Core' with: [ spec requires: 'SoupGemstone-Core' ];
        package: 'Soup-Help' with: [ spec requires: 'SoupGemstone-Core' ];
        package: 'Soup-XPath' with: [ spec requires: 'SoupGemstone-Core' ];
        package: 'Soup-Zinc' with: [ spec requires: 'SoupGemstone-Core' ].
      spec
        group: 'default' with: #('Core' 'Tests');
        group: 'Core' with: #('SoupGemstone-Core');
        group: 'Tests' with: #('Soup-Tests-Core') ]
]

{ #category : #baselines }
ConfigurationOfSoup >> baseline16: spec [
  <version: '1.6-baseline'>
  spec
    for: #'squeakCommon'
    do: [ 
      spec blessing: #'baseline'.
      spec description: 'Using now XMLParser'.
      spec author: 'StephaneDucasse'.
      spec timestamp: '1/10/2013'.
      spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/Soup/main'.
      spec
        package: 'Soup-Core' with: [ spec requires: 'XMLParser' ];
        package: 'Soup-Tests-Core' with: [ spec requires: 'Soup-Core' ];
        package: 'Soup-Help' with: [ spec requires: 'Soup-Core' ];
        package: 'Soup-XPath' with: [ spec requires: 'Soup-Core' ];
        package: 'Soup-Zinc' with: [ spec requires: 'Soup-Core' ].
      spec
        project: 'XMLParser'
        with: [ 
          spec
            className: 'ConfigurationOfXMLParser';
            versionString: #'stable';
            repository:
                'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
      spec
        group: 'default' with: #('Core' 'Tests');
        group: 'Core' with: #('Soup-Core' 'Soup-XPath');
        group: 'Tests' with: #('Soup-Tests-Core') ].
  spec
    for: #'gemstone'
    do: [ 
      spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/Soup/main'.
      spec
        project: 'XMLSupport'
        with: [ 
          spec
            className: 'ConfigurationOfXMLSupport';
            versionString: #'stable';
            repository: 'http://squeaksource.com/MetacelloRepository' ].
      spec
        package: 'SoupGemstone-Core' with: [ spec requires: 'XMLSupport' ];
        package: 'Soup-Tests-Core' with: [ spec requires: 'SoupGemstone-Core' ];
        package: 'Soup-Help' with: [ spec requires: 'SoupGemstone-Core' ];
        package: 'Soup-XPath' with: [ spec requires: 'SoupGemstone-Core' ];
        package: 'Soup-Zinc' with: [ spec requires: 'SoupGemstone-Core' ].
      spec
        group: 'default' with: #('Core' 'Tests');
        group: 'Core' with: #('SoupGemstone-Core');
        group: 'Tests' with: #('Soup-Tests-Core') ]
]

{ #category : #baselines }
ConfigurationOfSoup >> baseline17: spec [
  <version: '1.7-baseline'>
  spec
    for: #'squeakCommon'
    do: [ 
      spec blessing: #'baseline'.
      spec description: 'Using now XMLParser'.
      spec author: 'StephaneDucasse'.
      spec timestamp: '1/10/2013'.
      spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/Soup/main'.
      spec
        package: 'Soup-Core' with: [ spec requires: 'XMLParser' ];
        package: 'Soup-Tests-Core' with: [ spec requires: 'Soup-Core' ];
        package: 'Soup-Help' with: [ spec requires: 'Soup-Core' ];
        package: 'Soup-XPath' with: [ spec requires: 'Soup-Core' ];
        package: 'Soup-Zinc' with: [ spec requires: 'Soup-Core' ].
      spec
        project: 'XMLParser'
        with: [ 
          spec
            className: 'ConfigurationOfXMLParser';
            versionString: #'stable';
            repository:
                'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
      spec
        group: 'default' with: #('Core' 'Tests');
        group: 'Core' with: #('Soup-Core' 'Soup-XPath');
        group: 'Tests' with: #('Soup-Tests-Core') ].
  spec
    for: #'gemstone'
    do: [ 
      spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/Soup/main'.
      spec
        project: 'XMLSupport'
        with: [ 
          spec
            className: 'ConfigurationOfXMLSupport';
            versionString: #'stable';
            repository: 'http://squeaksource.com/MetacelloRepository' ].
      spec
        package: 'SoupGemstone-Core' with: [ spec requires: 'XMLSupport' ];
        package: 'Soup-Tests-Core' with: [ spec requires: 'SoupGemstone-Core' ];
        package: 'Soup-Help' with: [ spec requires: 'SoupGemstone-Core' ];
        package: 'Soup-XPath' with: [ spec requires: 'SoupGemstone-Core' ];
        package: 'Soup-Zinc' with: [ spec requires: 'SoupGemstone-Core' ].
      spec
        group: 'default' with: #('Core' 'Tests');
        group: 'Core' with: #('SoupGemstone-Core');
        group: 'Tests' with: #('Soup-Tests-Core') ]
]

{ #category : #baselines }
ConfigurationOfSoup >> baseline18: spec [
	<version: '1.8-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/Soup/main'.
		spec project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
		spec 
			package: 'Soup-Core' with: [
				spec requires: #('XMLParser' ). ];
			package: 'Soup-Zinc' with: [
				spec requires: #('Soup-Core' ). ];
			package: 'Soup-XPath' with: [
				spec requires: #('Soup-Core' ). ];
			package: 'Soup-Help' with: [
				spec requires: #('Soup-Core' ). ];
			package: 'Soup-Tests-Core' with: [
				spec requires: #('Soup-Core' ). ];
			package: #'Soup-Tools' with: [
				spec requires: #('Soup-Core' 'Soup-Zinc' 'Soup-XPath' 'Soup-Help' ). ].
		spec 
			group: 'Tests' with: #('Soup-Tests-Core' );
			group: 'default' with: #('Core' 'Tests' 'Tools' );
			group: 'Core' with: #('Soup-Core' 'Soup-XPath' );
			group: 'Tools' with: #(#'Soup-Tools' ). ].

]

{ #category : #baselines }
ConfigurationOfSoup >> baseline19: spec [
	<version: '1.9-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/Soup/main'.
		spec project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
		spec 
			package: 'Soup-Core' with: [
				spec requires: #('XMLParser' ). ];
			package: 'Soup-Zinc' with: [
				spec requires: #('Soup-Core' ). ];
			package: 'Soup-XPath' with: [
				spec requires: #('Soup-Core' ). ];
			package: 'Soup-Help' with: [
				spec requires: #('Soup-Core' ). ];
			package: 'Soup-Tests-Core' with: [
				spec requires: #('Soup-Core' ). ];
			package: #'Soup-Tools' with: [
				spec requires: #('Soup-Core' 'Soup-Zinc' 'Soup-XPath' 'Soup-Help' ). ].
		spec 
			group: 'Tests' with: #('Soup-Tests-Core' );
			group: 'default' with: #('Core' 'Tests' 'Tools' );
			group: 'Core' with: #('Soup-Core' 'Soup-XPath' );
			group: 'Tools' with: #(#'Soup-Tools' ). ].

]

{ #category : #accessing }
ConfigurationOfSoup >> customProjectAttributes [
	| attributes |
	attributes := OrderedCollection new.
	(Smalltalk hasClassNamed: #ZnClient)
		ifTrue: [ attributes add: #zinc ].
	^ attributes
]

{ #category : #'symbolic versions' }
ConfigurationOfSoup >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.9-baseline'.

]

{ #category : #accessing }
ConfigurationOfSoup >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfSoup >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.9'.

	spec for: #'gemstone' version: '1.4.1'.

	spec for: #'pharo1.3.x' version: '0.2'.

	spec for: #'pharo1.4.x' version: '1.4'.

	spec for: #'pharo2.x' version: '1.7.1'.

	spec for: #'pharo3.x' version: '1.7.1'.

	spec for: #'pharo4.x' version: '1.7.1'.

	spec for: #'pharo5.x' version: '1.8'.

]

{ #category : #versions }
ConfigurationOfSoup >> version01: spec [ 

	<version: '0.1'> 
	spec for: #common do: [ spec repository: 'http://www.squeaksource.com/Soup'. 
	spec 
		package: 'Soup-Core' with: 'Soup-Core-StephaneDucasse.6'; 
		package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-StephaneDucasse.2';
		package: 'Soup-Help' with: 'Soup-Help-StephaneDucasse.2' ].
]

{ #category : #versions }
ConfigurationOfSoup >> version02: spec [ 

	<version: '0.2'> 
	spec for: #common do: [ spec repository: 'http://www.squeaksource.com/Soup'. 
	spec 
		package: 'Soup-Core' with: 'Soup-Core-sd.11'; 
		package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-sd.3';
		package: 'Soup-Help' with: 'Soup-Help-StephaneDucasse.2' ].
]

{ #category : #versions }
ConfigurationOfSoup >> version10: spec [
	<version: '1.1' imports: #('1.1-baseline' )>

	spec for: #'pharo' do: [
		spec blessing: #'development'.
		spec project: 'XMLSupport' with: [
				spec
					versionString: '1.2.0';
					loads: #('XML-Parser' 'XML-Tests-Parser' ) ].
		spec 
			package: 'Soup-Core' with: 'Soup-Core-CamilloBruni.14';
			package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-AlexandreBergel.5';
			package: 'Soup-Help' with: 'Soup-Help-StephaneDucasse.2';
			package: 'Soup-XPath' with: 'Soup-XPath-CamilloBruni.3'. ].

]

{ #category : #versions }
ConfigurationOfSoup >> version12: spec [
	<version: '1.2' imports: #('1.1-baseline' )>

	spec for: #'pharo' do: [
		spec blessing: #'baseline'.
		spec description: 'Adding Camillo Bruni XPath extension'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '31/12/2011 12:29'.
		spec project: 'XMLSupport' with: #'stable'.
		spec 
			package: 'Soup-Core' with: 'Soup-Core-CamilloBruni.14';
			package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-AlexandreBergel.5';
			package: 'Soup-Help' with: 'Soup-Help-StephaneDucasse.2';
			package: 'Soup-XPath' with: 'Soup-XPath-CamilloBruni.3'. ].

]

{ #category : #versions }
ConfigurationOfSoup >> version13: spec [
	<version: '1.3' imports: #('1.3-baseline' )>

	spec for: #'pharo' do: [
		spec blessing: #'development'.
		spec description: '- New Help version
- Fix for Pharo 2.0.'.
		spec author: 'SeanDeNigris'.
		spec timestamp: '08/02/2013 11:27'.
		spec project: 'XMLSupport' with: #'stable'.
		spec 
			package: 'Soup-Core' with: 'Soup-Core-CamilloBruni.14';
			package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-AlexandreBergel.5';
			package: 'Soup-Help' with: 'Soup-Help-SeanDeNigris.3';
			package: 'Soup-XPath' with: 'Soup-XPath-CamilloBruni.3'. ].

	spec for: #'pharo2.x' do: [
		spec blessing: #'development'.
		spec description: '- New Help version
- Fix for Pharo 2.0.'.
		spec author: 'SeanDeNigris'.
		spec timestamp: '08/02/2013 11:27'.
		spec project: 'XMLSupport' with: #'stable'.
		spec 
			package: 'Soup-Core' with: 'Soup-Core-SeanDeNigris.15';
			package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-SeanDeNigris.7';
			package: 'Soup-Help' with: 'Soup-Help-SeanDeNigris.3';
			package: 'Soup-XPath' with: 'Soup-XPath-CamilloBruni.3'. ].
		
	spec for: #zinc do: [
		spec 
			package: 'Soup-Zinc' with: 'Soup-Zinc-SeanDeNigris.1' ]
]

{ #category : #versions }
ConfigurationOfSoup >> version141: spec [
  <version: '1.4.1' imports: #('1.4-baseline')>
  spec
    for: #'common'
    do: [ 
      spec
        package: 'Soup-Core' with: 'Soup-Core-CamilloBruni.14';
        package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-AlexandreBergel.5';
        package: 'Soup-Help' with: 'Soup-Help-SeanDeNigris.3';
        package: 'Soup-XPath' with: 'Soup-XPath-CamilloBruni.3';
        package: 'Soup-Zinc' with: 'Soup-Zinc-SeanDeNigris.1' ].
  spec
    for: #'gemstone'
    do: [ 
      spec blessing: #'stable'.
      spec description: 'Get GemStone running a little better'.
      spec author: 'Paul DeBruicker'.
      spec timestamp: '11/28/2016 15:49PST'.
      spec project: 'XMLSupport' with: #'stable'.
      spec
        package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-PaulDeBruicker.6';
        package: 'SoupGemstone-Core' with: 'SoupGemstone-Core-PaulDeBruicker.3' ]
]

{ #category : #versions }
ConfigurationOfSoup >> version14: spec [
  <version: '1.4' imports: #('1.4-baseline')>
  spec
    for: #'common'
    do: [ 
      spec blessing: #'development'.
      spec
        description:
          '- New Help version
- Fix for Pharo 2.0.'.
      spec author: 'SeanDeNigris'.
      spec timestamp: '08/02/2013 11:27'.
      spec project: 'XMLSupport' with: #'stable'.
      spec
        package: 'Soup-Core' with: 'Soup-Core-CamilloBruni.14';
        package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-AlexandreBergel.5';
        package: 'Soup-Help' with: 'Soup-Help-SeanDeNigris.3';
        package: 'Soup-XPath' with: 'Soup-XPath-CamilloBruni.3';
        package: 'Soup-Zinc' with: 'Soup-Zinc-SeanDeNigris.1' ].
  spec
    for: #'pharo2.x'
    do: [ 
      spec blessing: #'development'.
      spec
        description:
          '- New Help version
- Fix for Pharo 2.0.'.
      spec author: 'SeanDeNigris'.
      spec timestamp: '08/02/2013 11:27'.
      spec project: 'XMLSupport' with: #'stable'.
      spec
        package: 'Soup-Core' with: 'Soup-Core-SeanDeNigris.15';
        package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-SeanDeNigris.7';
        package: 'Soup-Help' with: 'Soup-Help-SeanDeNigris.3';
        package: 'Soup-XPath' with: 'Soup-XPath-CamilloBruni.3' ].
  spec
    for: #'gemstone'
    do: [ spec package: 'SoupGemstone-Core' with: 'SoupGemstone-Core-PaulDeBruicker.2' ]
]

{ #category : #versions }
ConfigurationOfSoup >> version15: spec [
	<version: '1.5' imports: #('1.5-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #development.
			spec description:
					'- New Help version
- Fix for Pharo 2.0.'.
			spec author: 'SeanDeNigris'.
			spec timestamp: '08/02/2013 11:27'.
			spec
				package: 'Soup-Core' with: 'Soup-Core-CamilloBruni.14';
				package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-AlexandreBergel.5';
				package: 'Soup-Help' with: 'Soup-Help-SeanDeNigris.3';
				package: 'Soup-XPath' with: 'Soup-XPath-CamilloBruni.3';
				package: 'Soup-Zinc' with: 'Soup-Zinc-SeanDeNigris.1' ].
			
	spec
		for: #'pharo2.x'
		do: [ 
			spec blessing: #development.
			spec description:
					'- New Help version
- Fix for Pharo 2.0.'.
			spec author: ''.
			spec timestamp: '08/02/2013 11:27'.
			spec
				package: 'Soup-Core' with: 'Soup-Core-SeanDeNigris.15';
				package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-SeanDeNigris.7';
				package: 'Soup-Help' with: 'Soup-Help-SeanDeNigris.3';
				package: 'Soup-XPath' with: 'Soup-XPath-CamilloBruni.3' ].
			
	spec for: #gemstone do: [ spec package: 'SoupGemstone-Core' with: 'SoupGemstone-Core-PaulDeBruicker.1' ]
]

{ #category : #versions }
ConfigurationOfSoup >> version16: spec [
	<version: '1.6' imports: #('1.6-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #development.
			spec description:
					'- New Help version
- Fix for Pharo 2.0.'.
			spec author: 'SeanDeNigris'.
			spec timestamp: '08/02/2013 11:27'.
			spec
				package: 'Soup-Core' with: 'Soup-Core-CamilloBruni.14';
				package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-AlexandreBergel.5';
				package: 'Soup-Help' with: 'Soup-Help-SeanDeNigris.3';
				package: 'Soup-XPath' with: 'Soup-XPath-CamilloBruni.3';
				package: 'Soup-Zinc' with: 'Soup-Zinc-SeanDeNigris.1' ].
			
	spec
		for: #'pharo2.x'
		do: [ 
			spec blessing: #development.
			spec description:
					'- New Help version
- Fix for Pharo 2.0.'.
			spec author: ''.
			spec timestamp: '08/02/2013 11:27'.
			spec
				package: 'Soup-Core' with: 'Soup-Core-SeanDeNigris.15';
				package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-SeanDeNigris.7';
				package: 'Soup-Help' with: 'Soup-Help-SeanDeNigris.3';
				package: 'Soup-XPath' with: 'Soup-XPath-CamilloBruni.3' ].
			
	spec for: #gemstone do: [ spec package: 'SoupGemstone-Core' with: 'SoupGemstone-Core-PaulDeBruicker.1' ]
]

{ #category : #versions }
ConfigurationOfSoup >> version171: spec [
	<version: '1.7.1' imports: #('1.7-baseline')>
	spec
		for: #common do: [ 
			spec blessing: #release.
			spec description:
					'Bugfix'.
			spec author: 'StephanEggermont'.
			spec timestamp: '2015-12-14'.
			spec
				package: 'Soup-Core' with: 'Soup-Core-SeanDeNigris.16';
				package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-SeanDeNigris.7';
				package: 'Soup-Help' with: 'Soup-Help-SeanDeNigris.3';
				package: 'Soup-XPath' with: 'Soup-XPath-CamilloBruni.3' ].
			
	spec for: #gemstone do: [ spec package: 'SoupGemstone-Core' with: 'SoupGemstone-Core-PaulDeBruicker.1' ]
]

{ #category : #versions }
ConfigurationOfSoup >> version17: spec [
	<version: '1.7' imports: #('1.7-baseline')>
	spec
		for: #common do: [ 
			spec blessing: #release.
			spec description:
					'- Make former Pharo 2.0 package set the default i.e. common. Works for Pharo 3.0, should work for Squeak. May need Soup-Zinc on Pharo 1.4
					- Update to baseline 1.6, which changes the repo on gemstone'.
			spec author: ''.
			spec timestamp: '04/14/2014 11:27'.
			spec
				package: 'Soup-Core' with: 'Soup-Core-SeanDeNigris.15';
				package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-SeanDeNigris.7';
				package: 'Soup-Help' with: 'Soup-Help-SeanDeNigris.3';
				package: 'Soup-XPath' with: 'Soup-XPath-CamilloBruni.3' ].
			
	spec for: #gemstone do: [ spec package: 'SoupGemstone-Core' with: 'SoupGemstone-Core-PaulDeBruicker.1' ]
]

{ #category : #versions }
ConfigurationOfSoup >> version18: spec [
	<version: '1.8' imports: #('1.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.8'.
		spec author: 'TorstenBergmann'.
		spec timestamp: '4/14/2016 12:35'.
		spec project: 'XMLParser' with: '2.7.5'.
		spec 
			package: 'Soup-Core' with: 'Soup-Core-TorstenBergmann.17';
			package: 'Soup-Zinc' with: 'Soup-Zinc';
			package: 'Soup-XPath' with: 'Soup-XPath-TorstenBergmann.4';
			package: 'Soup-Help' with: 'Soup-Help';
			package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-SeanDeNigris.7';
			package: 'Soup-Tools' with: 'Soup-Tools-TorstenBergmann.1'. ].

]

{ #category : #versions }
ConfigurationOfSoup >> version19: spec [
	<version: '1.9' imports: #('1.9-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.9'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '11/24/2017 17:36'.
		spec project: 'XMLParser' with: '3.2.8'.
		spec 
			package: 'Soup-Core' with: 'Soup-Core-NouryBouraqadi.18';
			package: 'Soup-Zinc' with: 'Soup-Zinc-SeanDeNigris.1';
			package: 'Soup-XPath' with: 'Soup-XPath-TorstenBergmann.4';
			package: 'Soup-Help' with: 'Soup-Help-SeanDeNigris.3';
			package: 'Soup-Tests-Core' with: 'Soup-Tests-Core-NouryBouraqadi.9';
			package: #'Soup-Tools' with: 'Soup-Tools-TorstenBergmann.1'. ].

]
