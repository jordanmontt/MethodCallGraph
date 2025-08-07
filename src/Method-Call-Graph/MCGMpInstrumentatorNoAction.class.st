Class {
	#name : 'MCGMpInstrumentatorNoAction',
	#superclass : 'MCGMpInstrumentator',
	#category : 'Method-Call-Graph-Instrumentation',
	#package : 'Method-Call-Graph',
	#tag : 'Instrumentation'
}

{ #category : 'accessing' }
MCGMpInstrumentatorNoAction >> newHandler: aMethod [

	^ MpHandler new
]
