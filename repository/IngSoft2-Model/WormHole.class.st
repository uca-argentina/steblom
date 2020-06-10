Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'applying effect' }
WormHole >> applyTo: player using: game [
	game applyWormHoleTo: player
]
