Class {
	#name : 'CallGraphProfiler',
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
CallGraphProfiler >> callStack [

	^ callStack
]

{ #category : 'private' }
CallGraphProfiler >> enteringMethod: aMethod [

	| node callerNode |
	callerNode := callStack top.
	node := self nodeForMethod: aMethod.
	node addCall.
	callerNode addCallTo: node.
	callStack push: node
]

{ #category : 'private' }
CallGraphProfiler >> exitingMethod [

	callStack pop
]

{ #category : 'initialization' }
CallGraphProfiler >> initialize [

	super initialize.
	nodes := Dictionary new.
	callStack := CallGraphProcessCallStack new
		profiler: self;
		ensureStackIsInitialized;
		yourself.
	instrumentator := MpCallGraphInstrumentator onProfiler: self
]

{ #category : 'profiling' }
CallGraphProfiler >> instrument [

	instrumentator instrument
]

{ #category : 'accessing' }
CallGraphProfiler >> instrumentator [
	^ instrumentator
]

{ #category : 'api' }
CallGraphProfiler >> methodsToInstrument: aSetOfMethods [

	instrumentator methodsToInstrument: aSetOfMethods
]

{ #category : 'private' }
CallGraphProfiler >> nodeForMethod: method [

	^ nodes
		  at: method
		  ifAbsentPut: [ CallGraphMethodNode forMethod: method ]
]

{ #category : 'accessing' }
CallGraphProfiler >> nodes [

	^ nodes
]

{ #category : 'api' }
CallGraphProfiler >> packageNamesToInstrument: aSetOfSymbols [

	| methodsToInstrument |
	methodsToInstrument := (aSetOfSymbols collect: #asPackage)
			flatCollect: #methods
			as: Set.
	self methodsToInstrument: methodsToInstrument
]

{ #category : 'api' }
CallGraphProfiler >> profile: aBlock [

	self startProfiling.
	^ aBlock ensure: [ self stopProfiling ]
]

{ #category : 'private' }
CallGraphProfiler >> rootNode [

	^ nodes
		  at: #root
		  ifAbsentPut: [ CallGraphMethodNode forMethod: #root ]
]

{ #category : 'profiling' }
CallGraphProfiler >> startProfiling [

	self instrument.
	MpMethodProxy enableInstrumentation
]

{ #category : 'profiling' }
CallGraphProfiler >> stopProfiling [

	MpMethodProxy disableInstrumentation.
	self uninstrument
]

{ #category : 'profiling' }
CallGraphProfiler >> uninstrument [

	instrumentator uninstrument
]
