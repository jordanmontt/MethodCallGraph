Class {
	#name : 'MpCallGraphHandler',
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
MpCallGraphHandler class >> onMethod: aMethod profiler: aProfiler [

	^ self new
		method: aMethod;
		profiler: aProfiler;
		yourself
]

{ #category : 'evaluating' }
MpCallGraphHandler >> afterExecutionWithReceiver: anObject arguments: anArrayOfObjects returnValue: returnValue [

	profiler exitingMethod.
	^ returnValue
]

{ #category : 'evaluating' }
MpCallGraphHandler >> beforeExecutionWithReceiver: anObject arguments: args [

	profiler enteringMethod: method
]

{ #category : 'accessing' }
MpCallGraphHandler >> method: aMethod [

	method := aMethod
]

{ #category : 'accessing' }
MpCallGraphHandler >> profiler: aProfiler [

	profiler := aProfiler
]
