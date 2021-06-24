Class {
	#name : #Reverse,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'applying card' }
Reverse >> applyUsing: game on: player [
	game applyReverse: self
]
