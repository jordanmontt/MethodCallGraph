Class {
	#name : 'GraphCallerTest',
	#superclass : 'TestCase',
	#instVars : [
		'packageMethods',
		'profilingBlock',
		'mpProfiler',
		'testPackageNames'
	],
	#category : 'Method-Call-Graph-Tests',
	#package : 'Method-Call-Graph-Tests'
}

{ #category : 'tests' }
GraphCallerTest >> assertProfilerResultsForTotalNodes: totalNodes rootNodeCalls: rootNodeCalls [

	| mpRootNode |
	self assert: mpProfiler nodes size equals: totalNodes.

	self
		assert: mpProfiler instrumentator methodProxies size
		equals: (self numberOfMethodsForPackageNames: testPackageNames).

	mpRootNode := (mpProfiler nodes values select: [ :e |
		               e method = #root ]) first.

	self assert: mpRootNode timesCalled equals: 0.
	self assert: mpRootNode methodCalls size equals: rootNodeCalls
]

{ #category : 'running' }
GraphCallerTest >> numberOfMethodsForPackageNames: packages [

	^ ((packages collect: #asPackage) flatCollect: #methods as: Set) size
]

{ #category : 'tests' }
GraphCallerTest >> setPackagesToInstrument: packagesNames [

	testPackageNames := packagesNames.
	mpProfiler packageNamesToInstrument: testPackageNames
]

{ #category : 'running' }
GraphCallerTest >> setProfilingBlockForTests: testPackages [

	| testClasses testSuites |
	testClasses := (testPackages flatCollect: #definedClasses) select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite.
	profilingBlock := [ testSuites do: #run ]
]

{ #category : 'running' }
GraphCallerTest >> setUp [

	super setUp.
	mpProfiler := CallGraphProfiler new
]

{ #category : 'tests' }
GraphCallerTest >> testFuzzyMatcher [

	self setProfilingBlockForTests: { 'FuzzyMatcher-Tests' asPackage }.
	self setPackagesToInstrument: { 'FuzzyMatcher' }.

	mpProfiler profile: profilingBlock.

	self assertProfilerResultsForTotalNodes: 24 rootNodeCalls: 53
]

{ #category : 'tests' }
GraphCallerTest >> testGraphAlgos [

	self setProfilingBlockForTests: { 'AI-Algorithms-Graph-Tests' asPackage }.
	self setPackagesToInstrument: { 'AI-Algorithms-Graph' }.

	mpProfiler profile: profilingBlock.

	self assertProfilerResultsForTotalNodes: 155 rootNodeCalls: 725
	
]

{ #category : 'tests' }
GraphCallerTest >> testMicrodown [

	self setProfilingBlockForTests: { 'Microdown-Tests' asPackage }.
	self setPackagesToInstrument: { 'Microdown' . 'Microdown-RichTextComposer' }.
	
	mpProfiler profile: profilingBlock.

	self assertProfilerResultsForTotalNodes: 496 rootNodeCalls: 7946
	
]

{ #category : 'tests' }
GraphCallerTest >> testProfStef [

	self setProfilingBlockForTests: { 'ProfStef-Tests' asPackage }.
	self setPackagesToInstrument: { 'ProfStef-Core' }.
	
	mpProfiler profile: profilingBlock.

	self assertProfilerResultsForTotalNodes: 93 rootNodeCalls: 324
	
]

{ #category : 'tests' }
GraphCallerTest >> testRewriteTool [

	self setProfilingBlockForTests: { 'NewTools-RewriterTools-Tests' asPackage .
		'NewTools-RewriterTools-Backend-Tests' asPackage }.
	self setPackagesToInstrument: { 'NewTools-RewriterTools-Backend' . 'NewTools-RewriterTools' }.
	
	mpProfiler profile: profilingBlock.

	self assertProfilerResultsForTotalNodes: 129 rootNodeCalls: 341
	
]
