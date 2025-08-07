Class {
	#name : 'GraphCallerTest',
	#superclass : 'TestCase',
	#instVars : [
		'packageMethods',
		'profilingBlock',
		'testPackageNames',
		'callGraphProfiler'
	],
	#category : 'Method-Call-Graph-Tests',
	#package : 'Method-Call-Graph-Tests'
}

{ #category : 'running' }
GraphCallerTest >> assertProfilerResults [

	| mpRootNode |
	self assert: callGraphProfiler nodes size > 20.

	self
		assert: callGraphProfiler instrumentator methodProxies size
		equals: (self numberOfMethodsForPackageNames: testPackageNames).

	mpRootNode := (callGraphProfiler nodes values select: [ :e | e method = #root ]) first.

	self assert: mpRootNode timesCalled equals: 0.
	self assert: mpRootNode methodCalls size > 50
]

{ #category : 'running' }
GraphCallerTest >> numberOfMethodsForPackageNames: packages [

	^ ((packages collect: #asPackage) flatCollect: #methods as: Set) size
]

{ #category : 'running' }
GraphCallerTest >> setPackagesToInstrument: packagesNames [

	testPackageNames := packagesNames.
	callGraphProfiler packageNamesToInstrument: testPackageNames
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
	callGraphProfiler := MethodCallGraphProfiler new
]

{ #category : 'tests' }
GraphCallerTest >> testFuzzyMatcher [

	self setProfilingBlockForTests: { 'FuzzyMatcher-Tests' asPackage }.
	self setPackagesToInstrument: { 'FuzzyMatcher' }.

	callGraphProfiler profile: profilingBlock.

	self assertProfilerResults
]

{ #category : 'tests' }
GraphCallerTest >> testGraphAlgos [

	self setProfilingBlockForTests: { 'AI-Algorithms-Graph-Tests' asPackage }.
	self setPackagesToInstrument: { 'AI-Algorithms-Graph' }.

	callGraphProfiler profile: profilingBlock.

	self assertProfilerResults
]

{ #category : 'tests' }
GraphCallerTest >> testMicrodown [

	self setProfilingBlockForTests: { 'Microdown-Tests' asPackage }.
	self setPackagesToInstrument: { 'Microdown' . 'Microdown-RichTextComposer' }.
	
	callGraphProfiler profile: profilingBlock.

	self assertProfilerResults
]

{ #category : 'tests' }
GraphCallerTest >> testProfStef [

	self setProfilingBlockForTests: { 'ProfStef-Tests' asPackage }.
	self setPackagesToInstrument: { 'ProfStef-Core' }.
	
	callGraphProfiler profile: profilingBlock.

	self assertProfilerResults
]

{ #category : 'tests' }
GraphCallerTest >> testRewriteTool [

	self setProfilingBlockForTests: { 'NewTools-RewriterTools-Tests' asPackage .
		'NewTools-RewriterTools-Backend-Tests' asPackage }.
	self setPackagesToInstrument: { 'NewTools-RewriterTools-Backend' . 'NewTools-RewriterTools' }.
	
	callGraphProfiler profile: profilingBlock.

	self assertProfilerResults
]
