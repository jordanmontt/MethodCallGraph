Class {
	#name : 'MethodCounterHandler',
	#superclass : 'MpHandler',
	#instVars : [
		'profiler',
		'method'
	],
	#category : 'Method-Call-Graph-MethodCounter',
	#package : 'Method-Call-Graph',
	#tag : 'MethodCounter'
}

{ #category : 'instance creation' }
MethodCounterHandler class >> onMethod: aMethod profiler: aProfiler [

	^ self new
		method: aMethod;
		profiler: aProfiler;
		yourself
]

{ #category : 'evaluating' }
MethodCounterHandler >> afterExecutionWithReceiver: rcv arguments: args returnValue: returnValue [

    profiler executedMethod: method.
    ^ returnValue
]

{ #category : 'accessing' }
MethodCounterHandler >> method: aMethod [

    method := aMethod
]

{ #category : 'accessing' }
MethodCounterHandler >> profiler: aProfiler [

	profiler := aProfiler
]
