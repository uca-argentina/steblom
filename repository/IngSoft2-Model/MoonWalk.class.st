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
MoonWalk >> applyTo: aTable usingPlayer: player with: endPosition [ 
	aTable applyMoonwalkToEveryoneExcept:player with:endPosition substracting:n
]

{ #category : #initialization }
MoonWalk >> initializeSubstracting: anInteger [ 
	n:=anInteger
]
