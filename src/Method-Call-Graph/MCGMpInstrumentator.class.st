Class {
	#name : 'MCGMpInstrumentator',
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
MCGMpInstrumentator class >> new [

	^ self error: 'Use onProfiler: instead of new'
]

{ #category : 'as yet unclassified' }
MCGMpInstrumentator class >> onProfiler: aProfiler [

	^ self basicNew
		  initialize;
		  profiler: aProfiler;
		  yourself
]

{ #category : 'initialization' }
MCGMpInstrumentator >> initialize [

	super initialize.
	methodProxies := Dictionary new
]

{ #category : 'profiling' }
MCGMpInstrumentator >> instrument [

	methodProxies valuesDo: #install
]

{ #category : 'accessing' }
MCGMpInstrumentator >> methodProxies [

	^ methodProxies
]

{ #category : 'accessing' }
MCGMpInstrumentator >> methodsToInstrument: aSetOfMethods [

	(aSetOfMethods collect: [ :method | method unproxifiedMethod ])
		do: [ :method |
			methodProxies
				at: method
				put: (self newMethodProxy: method) ]
]

{ #category : 'accessing' }
MCGMpInstrumentator >> newHandler: aMethod [

	^ MCGMpHandler onMethod: aMethod profiler: profiler
]

{ #category : 'accessing' }
MCGMpInstrumentator >> newMethodProxy: aMethod [

	^ MpMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]

{ #category : 'accessing' }
MCGMpInstrumentator >> profiler: aProfiler [

	profiler := aProfiler
]

{ #category : 'profiling' }
MCGMpInstrumentator >> uninstrument [

	methodProxies valuesDo: #uninstall
]
