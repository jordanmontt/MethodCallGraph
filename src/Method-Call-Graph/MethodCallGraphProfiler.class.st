Class {
	#name : 'MethodCallGraphProfiler',
	#superclass : 'Object',
	#instVars : [
		'callStack',
		'nodes',
		'instrumentator'
	],
	#category : 'Method-Call-Graph-Core',
	#package : 'Method-Call-Graph',
	#tag : 'Core'
}

{ #category : 'accessing' }
MethodCallGraphProfiler >> callStack [

	^ callStack
]

{ #category : 'private' }
MethodCallGraphProfiler >> enteringMethod: aMethod [

	| node callerNode |
	callStack ensureStackIsInitialized.

	callerNode := callStack top.
	node := self nodeForMethod: aMethod.
	node addCall.
	callerNode addCallTo: node.
	callStack push: node
]

{ #category : 'private' }
MethodCallGraphProfiler >> exitingMethod [

	callStack pop
]

{ #category : 'initialization' }
MethodCallGraphProfiler >> initialize [

	super initialize.
	nodes := Dictionary new.
	callStack := MCGProcessCallStack new
		profiler: self;
		ensureStackIsInitialized;
		yourself.
	instrumentator := MCGMpInstrumentator onProfiler: self
]

{ #category : 'accessing' }
MethodCallGraphProfiler >> instrumentator [
	^ instrumentator
]

{ #category : 'accessing' }
MethodCallGraphProfiler >> instrumentator: anObject [

	instrumentator := anObject
]

{ #category : 'api' }
MethodCallGraphProfiler >> methodsToInstrument: aSetOfMethods [

	instrumentator methodsToInstrument: aSetOfMethods
]

{ #category : 'private' }
MethodCallGraphProfiler >> nodeForMethod: method [

	^ nodes
		  at: method
		  ifAbsentPut: [ MCGMethodNode forMethod: method ]
]

{ #category : 'accessing' }
MethodCallGraphProfiler >> nodes [

	^ nodes
]

{ #category : 'api' }
MethodCallGraphProfiler >> packageNamesToInstrument: aSetOfSymbols [

	| methodsToInstrument |
	methodsToInstrument := (aSetOfSymbols collect: #asPackage)
			flatCollect: #methods
			as: Set.
	self methodsToInstrument: methodsToInstrument
]

{ #category : 'api' }
MethodCallGraphProfiler >> profileOn: aBlock [

	self startProfiling.
	^ aBlock ensure: [ self stopProfiling ]
]

{ #category : 'private' }
MethodCallGraphProfiler >> rootNode [

	^ nodes
		  at: #root
		  ifAbsentPut: [ MCGMethodNode forMethod: #root ]
]

{ #category : 'profiling' }
MethodCallGraphProfiler >> startProfiling [

	instrumentator instrument
]

{ #category : 'profiling' }
MethodCallGraphProfiler >> stopProfiling [

	instrumentator uninstrument
]
