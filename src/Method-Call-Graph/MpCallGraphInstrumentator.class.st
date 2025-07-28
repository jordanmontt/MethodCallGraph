Class {
	#name : 'MpCallGraphInstrumentator',
	#superclass : 'MpAbstractInstrumentator',
	#category : 'Method-Call-Graph',
	#package : 'Method-Call-Graph'
}

{ #category : 'accessing' }
MpCallGraphInstrumentator >> newHandler: aMethod [

	^ MpCallGraphHandler onMethod: aMethod nameForProfiler profiler: profiler
]
