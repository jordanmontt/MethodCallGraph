"
I am a node in the method call graph. I represent a method call
"
Class {
	#name : 'MCGMethodNode',
	#superclass : 'Object',
	#instVars : [
		'methodCalls',
		'timesCalled',
		'method'
	],
	#category : 'Method-Call-Graph-Core',
	#package : 'Method-Call-Graph',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
MCGMethodNode class >> forMethod: aMethod [

	^ self new
		method: aMethod;
		yourself
]

{ #category : 'initialization' }
MCGMethodNode >> addCall [

	timesCalled := timesCalled + 1
]

{ #category : 'initialization' }
MCGMethodNode >> addCallTo: aNode [

	methodCalls add: aNode
]

{ #category : 'initialization' }
MCGMethodNode >> initialize [

	super initialize.
	methodCalls := Bag new.
	timesCalled := 0
]

{ #category : 'accessing' }
MCGMethodNode >> method [

	^ method
]

{ #category : 'accessing' }
MCGMethodNode >> method: aMethod [

	method := aMethod
]

{ #category : 'accessing' }
MCGMethodNode >> methodCalls [

	^ methodCalls
]

{ #category : 'printing' }
MCGMethodNode >> printOn: aStream [

	aStream << 'Node on: '.
	method printOn: aStream
]

{ #category : 'accessing' }
MCGMethodNode >> timesCalled [

	^ timesCalled
]
