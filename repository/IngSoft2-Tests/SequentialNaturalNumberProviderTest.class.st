Class {
	#name : #SequentialNaturalNumberProviderTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SequentialNaturalNumberProviderTest >> testCreationFailsIfSequenceIncludesNegativeInteger [

	self
		should: [ SequentialNaturalNumberProvider providing: #(1 -3 5) ]
		raise: Error
		description: 'Sequence must have only natural numbers'
]

{ #category : #tests }
SequentialNaturalNumberProviderTest >> testCreationFailsIfSequenceIncludesNonInteger [

	self
		should: [ SequentialNaturalNumberProvider providing: #(1 0.5 7) ]
		raise: Error
		description: 'Sequence must have only natural numbers'.
	self
		should: [ SequentialNaturalNumberProvider
				providing:	{(1 / 2). 2. 4} ]
		raise: Error
		description: 'Sequence must have only natural numbers'
]

{ #category : #tests }
SequentialNaturalNumberProviderTest >> testCreationFailsIfSequenceIncludesZero [

	self
		should: [ SequentialNaturalNumberProvider providing: #(1 0 7) ]
		raise: Error
		description: 'Sequence must have only natural numbers'
]

{ #category : #tests }
SequentialNaturalNumberProviderTest >> testCreationFailsWithEmptySequence [

	self
		should: [ SequentialNaturalNumberProvider providing: #() ]
		raise: Error
		description: 'Sequence is empty, it must have natural numbers'
]

{ #category : #tests }
SequentialNaturalNumberProviderTest >> testProviding [

	| provider maximum |
	provider := SequentialNaturalNumberProvider providing: #(1 3 5).
	maximum := 6.
	self assert: (provider nextInt: maximum) equals: 1;
		assert: (provider nextInt: maximum) equals: 3;
		assert: (provider nextInt: maximum) equals: 5
]

{ #category : #tests }
SequentialNaturalNumberProviderTest >> testSkipsNumbersGreaterThanMaxium [

	| provider maximum |
	provider := SequentialNaturalNumberProvider providing: #(1 7 5).
	maximum := 6.
	self assert: (provider nextInt: maximum) equals: 1;
		assert: (provider nextInt: maximum) equals: 5;
		assert: (provider nextInt: maximum) equals: 1
]
