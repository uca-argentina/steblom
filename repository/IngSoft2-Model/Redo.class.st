Class {
	#name : #Redo,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'applying card' }
Redo >> applyUsing: game onCard: card onPlayer: player [
	(game lastCard) applyRedo: self onCard: card onPlayer: player using:game
]
