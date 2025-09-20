Class {
	#name : 'MethodCounterProfiler',
	#superclass : 'Object',
	#instVars : [
		'executedMethods',
		'instrumentator'
	],
	#category : 'Method-Call-Graph-MethodCounter',
	#package : 'Method-Call-Graph',
	#tag : 'MethodCounter'
}

{ #category : 'as yet unclassified' }
MethodCounterProfiler >> executedMethod: aMethod [

    executedMethods add: aMethod
]

{ #category : 'initialization' }
MethodCounterProfiler >> initialize [

    super initialize.
    instrumentator := MethodCounterInstrumentator onProfiler: self.
    executedMethods := Bag new
]

{ #category : 'api' }
MethodCounterProfiler >> instrument [

	instrumentator instrument
]

{ #category : 'api' }
MethodCounterProfiler >> methodsToInstrument: aSetOfMethods [

	instrumentator methodsToInstrument: aSetOfMethods
]

{ #category : 'api' }
MethodCounterProfiler >> profileOn: aBlock [

	self startProfiling.
	^ aBlock ensure: [ self stopProfiling ]
]

{ #category : 'api' }
MethodCounterProfiler >> startProfiling [

	self instrument
]

{ #category : 'api' }
MethodCounterProfiler >> stopProfiling [

	self uninstrument
]

{ #category : 'api' }
MethodCounterProfiler >> uninstrument [

	instrumentator uninstrument
]
