Class {
	#name : 'MCGMpInstrumentatorNoAction',
	#superclass : 'MCGMpInstrumentator',
	#category : 'Method-Call-Graph-Instrumentation',
	#package : 'Method-Call-Graph',
	#tag : 'Instrumentation'
}

{ #category : 'profiling' }
MCGMpInstrumentatorNoAction >> install [

    methodProxies valuesDo: [ :mp | mp install ]
]

{ #category : 'accessing' }
MCGMpInstrumentatorNoAction >> newHandler: aMethod [

    ^ MpHandler new
]
