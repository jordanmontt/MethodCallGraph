Extension { #name : 'CompiledMethod' }

{ #category : '*Method-Call-Graph' }
CompiledMethod >> nameForProfiler [

	^ (self methodClass name , '>>#' , self selector) surroundedBySingleQuotes
]
