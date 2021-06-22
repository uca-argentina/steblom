Class {
	#name : #Speed,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'applying card' }
Speed >> applyCancellation: cancellation onPlayer: player using: game [
	game applyCancellation: cancellation onCard: self of: player
]

{ #category : #redoing }
Speed >> applyRedo: redo onCard: card onPlayer: player using: game [
	game applyPermanentWithRedo: self onPlayer: player
]

{ #category : #'applying card' }
Speed >> applyUsing: game on: player [
	game applyPermanent: self on: player
]

{ #category : #accessing }
Speed >> effect [
	^ 1
]

{ #category : #removing }
Speed >> removeYourselfOf: player using: game [
	game remove: self to: player
]
