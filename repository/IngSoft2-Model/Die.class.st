Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'sides',
		'numberProvider'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validating }
Die class >> assertSidesGreaterThanTwo: aNumberOfSides [

	aNumberOfSides > 1
		ifFalse: [ InstanceCreationFailed signal: 'A die must have at least 2 sides' ]
]

{ #category : #'instance creation - d20 notation' }
Die class >> d10 [
	
	^ self of: 10
]

{ #category : #'instance creation - d20 notation' }
Die class >> d100 [

	^ self of: 100
]

{ #category : #'instance creation - d20 notation' }
Die class >> d20 [

	^ self of: 20
]

{ #category : #'instance creation - d20 notation' }
Die class >> d4 [
	
	^ self of: 4
]

{ #category : #'instance creation - d20 notation' }
Die class >> d6 [
	
	^ self of: 6
]

{ #category : #'instance creation - d20 notation' }
Die class >> d8 [

	^ self of: 8
]

{ #category : #'instance creation' }
Die class >> of: aNumberOfSides [

	^ self of: aNumberOfSides source: Random new
]

{ #category : #'instance creation' }
Die class >> of: aNumberOfSides rolling: aSequence [

	^ self
		of: aNumberOfSides
		source: (SequentialNaturalNumberProvider providing: aSequence)
]

{ #category : #'instance creation' }
Die class >> of: aNumberOfSides source: aNumberProvider [

	self assertSidesGreaterThanTwo: aNumberOfSides.

	^ self new
		initializeOf: aNumberOfSides
		source: aNumberProvider
]

{ #category : #composing }
Die >> + aDie [

	^ Dice
		withAll:
			{self.
			aDie}
]

{ #category : #initialization }
Die >> initializeOf: aNumberOfSides source: aNumberProvider [

	sides := aNumberOfSides.
	numberProvider := aNumberProvider
]

{ #category : #rolling }
Die >> roll [

	^ numberProvider nextInt: sides 
]
