Class {
	#name : 'MCGProcessCallStack',
	#superclass : 'ProcessLocalVariable',
	#instVars : [
		'stacks',
		'profiler'
	],
	#category : 'Method-Call-Graph-Core',
	#package : 'Method-Call-Graph',
	#tag : 'Core'
}

{ #category : 'instance creation' }
MCGProcessCallStack class >> onProfiler: aProfiler [

	^ self new
		profiler: aProfiler;
		yourself
]

{ #category : 'initialization' }
MCGProcessCallStack >> ensureStackIsInitialized [
	"A new thread requires a stack.
	Initialize it and store it.
	Otherwise, the process specific variable is stored in a weak array"

	| theStack |
	self value ifNotNil: [ ^ self ].
	theStack := Stack new.
	theStack push: profiler rootNode.
	stacks add: theStack.
	self value: theStack
]

{ #category : 'initialization' }
MCGProcessCallStack >> initialize [

	super initialize.
	stacks := IdentitySet new
]

{ #category : 'removing' }
MCGProcessCallStack >> pop [

	^ self value pop
]

{ #category : 'accessing' }
MCGProcessCallStack >> profiler: aProfiler [

	profiler := aProfiler
]

{ #category : 'adding' }
MCGProcessCallStack >> push: aNode [

	self ensureStackIsInitialized.
	^ self value push: aNode
]

{ #category : 'accessing' }
MCGProcessCallStack >> size [

	^ self value size
]

{ #category : 'accessing' }
MCGProcessCallStack >> top [

	^ self value top
]
