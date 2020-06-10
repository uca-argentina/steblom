Class {
	#name : #MoonWalk,
	#superclass : #Object,
	#instVars : [
		'n'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalk class >> substracting: anInteger [ 
	^self new initializeSubstracting:anInteger.
]

{ #category : #'applying effect' }
MoonWalk >> applyTo: player using: game [
	game applyMoonwalkToEveryoneExcept: player with: n
]

{ #category : #initialization }
MoonWalk >> initializeSubstracting: anInteger [
	n := anInteger
]
