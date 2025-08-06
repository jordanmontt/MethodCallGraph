Class {
	#name : 'MpCallGraphInstrumentatorNoAction',
	#superclass : 'MpCallGraphInstrumentator',
	#category : 'Method-Call-Graph-Instrumentation',
	#package : 'Method-Call-Graph',
	#tag : 'Instrumentation'
}

{ #category : 'accessing' }
MpCallGraphInstrumentatorNoAction >> newHandler: aMethod [

	^ MpHandler new
]
