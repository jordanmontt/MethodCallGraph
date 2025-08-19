Class {
	#name : 'MCGMpHandler',
	#superclass : 'MpHandler',
	#instVars : [
		'profiler',
		'method',
		'samplingCounter',
		'samplingRate'
	],
	#category : 'Method-Call-Graph-Instrumentation',
	#package : 'Method-Call-Graph',
	#tag : 'Instrumentation'
}

{ #category : 'instance creation' }
MCGMpHandler class >> onMethod: aMethod profiler: aProfiler [

	^ self new
		method: aMethod;
		profiler: aProfiler;
		yourself
]

{ #category : 'evaluating' }
MCGMpHandler >> afterExecutionWithReceiver: anObject arguments: anArrayOfObjects returnValue: returnValue [

	samplingRate = 1 ifTrue: [
		"Sampling 100% capture all"
		self afterMethod: returnValue.
		^ returnValue ].

	samplingCounter := samplingCounter + 1.
	samplingCounter > samplingRate denominator ifTrue: [ samplingCounter := 1 ].

	samplingCounter <= samplingRate numerator
		ifTrue: [ ^ self afterMethod: returnValue ]
		ifFalse: [ ^ returnValue ]
]

{ #category : 'evaluating' }
MCGMpHandler >> afterMethod: returnValue [

    profiler exitingMethod.
    ^ returnValue
]

{ #category : 'evaluating' }
MCGMpHandler >> beforeExecutionWithReceiver: anObject arguments: args [

	samplingRate = 1 ifTrue: [
		"Sampling 100% capture all"
		self beforeMethod.
		^ self ].

	samplingCounter <= samplingRate numerator
		ifTrue: [ self beforeMethod ]
		ifFalse: [ ^ self ]
]

{ #category : 'evaluating' }
MCGMpHandler >> beforeMethod [

    profiler enteringMethod: method
]

{ #category : 'initialization' }
MCGMpHandler >> initialize [

    super initialize.
    samplingCounter := 0.
    self samplingRate: MCGMpInstrumentator defaultSamplingRate
]

{ #category : 'accessing' }
MCGMpHandler >> method: aMethod [

	method := aMethod
]

{ #category : 'accessing' }
MCGMpHandler >> profiler: aProfiler [

	profiler := aProfiler
]

{ #category : 'accessing' }
MCGMpHandler >> samplingRate: aFraction [
    "I expect my argument to be a fraction. For example 4 / 5. That will mean that I will
	register 4 out of 5 allocations."

    "The default sampling rate is 1%, which, by our evaluations, still gives precise results and does not sacrifice too much performance"
	
	
	"We are asserting here because the error risen because of the bad sampling rate will be in the instrumentation, in the proxy method, so it will break the image with no debugger."
    self assert: aFraction isFraction.
    self assert: aFraction asFloat >= 0.
    self assert: aFraction asFloat <= 1.
   

	samplingRate := aFraction
]
