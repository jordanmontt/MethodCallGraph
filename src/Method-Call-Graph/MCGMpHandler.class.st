Class {
	#name : 'MCGMpHandler',
	#superclass : 'MpHandler',
	#instVars : [
		'profiler',
		'method'
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

	profiler exitingMethod.
	^ returnValue
]

{ #category : 'evaluating' }
MCGMpHandler >> beforeExecutionWithReceiver: anObject arguments: args [

	profiler enteringMethod: method
]

{ #category : 'accessing' }
MCGMpHandler >> method: aMethod [

	method := aMethod
]

{ #category : 'accessing' }
MCGMpHandler >> profiler: aProfiler [

	profiler := aProfiler
]
