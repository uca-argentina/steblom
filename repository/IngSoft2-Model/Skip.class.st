Class {
	#name : #Skip,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'applying card' }
Skip >> applyUsing: game on: player [
	game applySkip: self of: player
]
