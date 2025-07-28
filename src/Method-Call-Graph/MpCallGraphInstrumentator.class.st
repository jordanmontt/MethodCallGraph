Class {
	#name : 'MpCallGraphInstrumentator',
	#superclass : 'Object',
	#instVars : [
		'methodProxies',
		'profiler'
	],
	#category : 'Method-Call-Graph-Instrumentation',
	#package : 'Method-Call-Graph',
	#tag : 'Instrumentation'
}

{ #category : 'as yet unclassified' }
MpCallGraphInstrumentator class >> new [

	^ self error: 'Use onProfiler: instead of new'
]

{ #category : 'as yet unclassified' }
MpCallGraphInstrumentator class >> onProfiler: aProfiler [

	^ self basicNew
		  initialize;
		  profiler: aProfiler;
		  yourself
]

{ #category : 'initialization' }
MpCallGraphInstrumentator >> initialize [

	super initialize.
	methodProxies := Dictionary new
]

{ #category : 'profiling' }
MpCallGraphInstrumentator >> instrument [

	methodProxies valuesDo: #install
]

{ #category : 'accessing' }
MpCallGraphInstrumentator >> methodProxies [

	^ methodProxies
]

{ #category : 'accessing' }
MpCallGraphInstrumentator >> methodsToInstrument: aSetOfMethods [

	(aSetOfMethods collect: [ :method | method unproxifiedMethod ])
		do: [ :method |
			methodProxies
				at: method
				put: (self newMethodProxy: method) ]
]

{ #category : 'accessing' }
MpCallGraphInstrumentator >> newHandler: aMethod [

	^ MpCallGraphHandler onMethod: aMethod profiler: profiler
]

{ #category : 'accessing' }
MpCallGraphInstrumentator >> newMethodProxy: aMethod [

	^ MpMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]

{ #category : 'accessing' }
MpCallGraphInstrumentator >> profiler: aProfiler [

	profiler := aProfiler
]

{ #category : 'profiling' }
MpCallGraphInstrumentator >> uninstrument [

	methodProxies valuesDo: #uninstall
]
