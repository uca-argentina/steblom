Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'applying effect' }
AtomicBomb >> applyTo: player using: game [
	game applyAtomicBomb
]
