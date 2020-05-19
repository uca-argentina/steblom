Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Board class >> generateSized:anEndPosition [
	^Board new initializeSized:anEndPosition
]

{ #category : #'instance creation' }
Board class >> with: effect andSize: size [
	^self new initializeWith:effect andSize:size.
]

{ #category : #accessing }
Board >> effect: anInteger [ 
	^tiles at:anInteger
]

{ #category : #initialization }
Board >> initializeSized:anEndPosition [
	tiles:=OrderedCollection new.
	1 to: anEndPosition do:[ :i |tiles add: self randomEffect ]
]

{ #category : #initialization }
Board >> initializeWith: effect andSize: size [
	tiles:=OrderedCollection new.
	1 to: size do:[:i | tiles add:effect]
]

{ #category : #'as yet unclassified' }
Board >> randomEffect [
	|index|
	index:= Random new nextInt:100.
	index<48 ifTrue: [ ^NoEffect new ] ifFalse:[index < 68 ifTrue:[^WormHole new] ifFalse:[index<88 	ifTrue:[^SpeedUp new] ifFalse:[index<98 ifTrue:[^MoonWalk substracting:(Random new nextInt:3)] 	ifFalse:[^AtomicBomb new] ]]]
]
