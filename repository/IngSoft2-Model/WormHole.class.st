Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'applying effect' }
WormHole >> applyTo: aTable usingPlayer: player with: endPosition [
	aTable applyWormHoleTo:player with:endPosition
]
