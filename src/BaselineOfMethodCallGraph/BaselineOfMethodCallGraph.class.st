Class {
	#name : 'BaselineOfMethodCallGraph',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMethodCallGraph',
	#package : 'BaselineOfMethodCallGraph'
}

{ #category : 'baselines' }
BaselineOfMethodCallGraph >> baseline: spec [

	<baseline>
	spec for: #common do: [
		"Packages"
		spec package: 'Method-Call-Graph'.
		spec package: 'Method-Call-Graph-Tests' with: [ spec requires: #( 'Method-Call-Graph' ) ].

		"External dependencies"
		spec baseline: 'MethodProxies' with: [ spec repository: 'github://pharo-contributions/MethodProxies' ].
		"Link external dependencies"
		spec package:  'Method-Call-Graph' with: [ spec requires: #('MethodProxies') ] .

		"Groups"
		spec group: 'default' with: #( 'core' 'tests' ).
		spec group: 'core' with: #( 'Method-Call-Graph' ).
		spec group: 'tests' with: #( 'Method-Call-Graph-Tests' ) ]
]
