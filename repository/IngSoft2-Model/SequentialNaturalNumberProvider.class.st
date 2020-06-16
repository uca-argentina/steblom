"
I represent a sequence of natural numbers
I provide a polymorphic alternative to `Random>>#nextInt:` answering with a predetermined sequence of natural numbers.
I am given that sequence of natural numbers when created.
Example:
```
sequence := SequentialGenerator generating: #(1 2 3 4).
sequence nextInt: 5. """"1""""
sequence nextInt: 5. """"2""""
sequence nextInt: 5. """"3""""
sequence nextInt: 3. """"1. (reminder of 4 / 3)""""
sequence nextInt: 3. """"1""""
sequence nextInt: 3. """"1""""
```
 
"
Class {
	#name : #SequentialNaturalNumberProvider,
	#superclass : #Object,
	#instVars : [
		'sequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SequentialNaturalNumberProvider class >> assertOnlyNaturalNumbersIn: aSequence [

	(aSequence
		anySatisfy:
			[ :number | number negative or: [ number isZero or: [ number isInteger not ] ] ])
		ifTrue: [ InstanceCreationFailed
				signal: 'Sequence must have only natural numbers' ]
]

{ #category : #'instance creation' }
SequentialNaturalNumberProvider class >> providing: aSequence [

	aSequence isEmpty
		ifTrue: [ InstanceCreationFailed
				signal: 'Sequence is empty, it must have natural numbers' ].
	self assertOnlyNaturalNumbersIn: aSequence.

	^ self new initializeProviding: aSequence
]

{ #category : #initialization }
SequentialNaturalNumberProvider >> initializeProviding: aSequence [

	sequence := (CircularIterator cyclingOver: aSequence ) 
]

{ #category : #providing }
SequentialNaturalNumberProvider >> nextInt: maxium [

	| next |

	[ next := sequence current.
	next > maxium ] whileTrue: [ next := sequence next ].
	sequence next.
	^ next
]
