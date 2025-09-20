Class {
	#name : 'MethodCounterInstrumentator',
	#superclass : 'MCGMpInstrumentator',
	#category : 'Method-Call-Graph-MethodCounter',
	#package : 'Method-Call-Graph',
	#tag : 'MethodCounter'
}

{ #category : 'profiling' }
MethodCounterInstrumentator >> install [

    methodProxies valuesDo: [ :mp | mp install ]
]

{ #category : 'accessing' }
MethodCounterInstrumentator >> newHandler: aMethod [

    ^ MethodCounterHandler onMethod: aMethod profiler: profiler
]
