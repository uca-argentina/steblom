Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'applying effect' }
AtomicBomb >> applyTo: aTable usingPlayer: player with: endPosition [
	aTable applyAtomicBomb
]
