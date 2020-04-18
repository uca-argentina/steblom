Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#classInstVars : [
		'die'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testD20Notation [

	| die |

	die := Die d4.
	1 to: 100 do: [ :iteration | self assert: (die roll between: 1 and: 4) ].

	die := Die d6.
	1 to: 100 do: [ :iteration | self assert: (die roll between: 1 and: 6) ].

	die := Die d8.
	1 to: 100 do: [ :iteration | self assert: (die roll between: 1 and: 8) ].

	die := Die d10.
	1 to: 100 do: [ :iteration | self assert: (die roll between: 1 and: 10) ].

	die := Die d20.
	1 to: 200 do: [ :iteration | self assert: (die roll between: 1 and: 20) ].

	die := Die d100.
	1 to: 1000 do: [ :iteration | self assert: (die roll between: 1 and: 100) ]
]

{ #category : #tests }
DiceTest >> testRoll [

	| die |

	die := Die of: 6 source: Random new.
	1 to: 100 do: [ :iteration | self assert: (die roll between: 1 and: 6) ].

	die := Die of: 4.
	1 to: 100 do: [ :iteration | self assert: (die roll between: 1 and: 4) ]
]

{ #category : #tests }
DiceTest >> testRollDice [

	| dice d4 d6 |

	d4 := Die of: 4 rolling: #(3 4 1).
	d6 := Die of: 6 rolling: #(1 5 5).
	dice := d4 + d6.
	self
		assert: dice roll equals: 4;
		assert: dice roll equals: 9;
		assert: dice roll equals: 6.

	self assert: (dice + d4) roll equals: 8
]

{ #category : #tests }
DiceTest >> testRollSequence [

	| die |

	die := Die of: 4 rolling: #(2 1).
	self
		assert: die roll equals: 2;
		assert: die roll equals: 1;
		assert: die roll equals: 2.

	die := Die of: 6 rolling: #(1 2 7).

	self
		assert: die roll equals: 1;
		assert: die roll equals: 2;
		assert: die roll equals: 1
]

{ #category : #tests }
DiceTest >> testSidesMustBeGreaterThanTwo [

	-1 to: 1 do: [ :invalidSides | 
		self
			should: [ Die of: invalidSides ]
			raise: InstanceCreationFailed
			withMessageText: 'A die must have at least 2 sides' ]
]
