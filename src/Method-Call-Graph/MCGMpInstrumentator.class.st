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

{ #category : 'profiling' }
MCGMpInstrumentator >> disableInstrumentation [

	MpMethodProxy disableInstrumentation
]

{ #category : 'profiling' }
MCGMpInstrumentator >> enableInstrumentation [

	MpMethodProxy enableInstrumentation
]

{ #category : 'initialization' }
MCGMpInstrumentator >> initialize [

	super initialize.
	methodProxies := Dictionary new
]

{ #category : 'profiling' }
MCGMpInstrumentator >> install [

	methodProxies valuesDo: #install
]

{ #category : 'api - profiling' }
MCGMpInstrumentator >> instrument [

	self install.
	self enableInstrumentation
]

{ #category : 'accessing' }
MCGMpInstrumentator >> methodProxies [

	^ methodProxies
]

{ #category : 'accessing' }
MCGMpInstrumentator >> methodsToInstrument: aSetOfMethods [

	(aSetOfMethods collect: [ :method | method ])
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
MCGMpInstrumentator >> uninstall [

	methodProxies valuesDo: #uninstall
]

{ #category : 'api - profiling' }
MCGMpInstrumentator >> uninstrument [

	self disableInstrumentation.
	self uninstall
]
