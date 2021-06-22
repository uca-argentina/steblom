Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> generateRandomUsing: aBoard sized: size [
	| tiles random |
	tiles := OrderedCollection new.
	random := Random new.
	1 to: size do: [ :i | tiles add: (aBoard at: (random nextInt: 100)) ].
	^ self new initializeWith: tiles
]

{ #category : #'instance creation' }
Board class >> generateWith: effects sized: endPosition [
	| tiles effectsIterator |
	effectsIterator := CircularIterator cyclingOver: effects.
	tiles := OrderedCollection new.
	1 to: endPosition do: [ :i | 
		tiles add: effectsIterator current.
		effectsIterator next ].
	^ Board new initializeWith: tiles
]

{ #category : #'instance creation' }
Board class >> with: effects and: proportions sized: size [
	| auxBoard |
	auxBoard := OrderedCollection new.
	effects
		with: proportions
		do:
			[ :effect :proportion | 1 to: proportion do: [ :i | auxBoard add: effect ] ].
	^ self generateRandomUsing: auxBoard sized: size
]

{ #category : #accessing }
Board >> count: effect [
	^ tiles count: [ :tile | tile isMemberOf: effect ]
]

{ #category : #accessing }
Board >> effectAt: position [
	^ tiles at: position
]

{ #category : #initialization }
Board >> initializeWith:aSetOfTiles [
	tiles:=aSetOfTiles.
]
