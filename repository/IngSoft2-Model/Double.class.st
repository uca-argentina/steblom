Class {
	#name : #Double,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'applying effect' }
Double >> applyUsing: game on: player [
	game applyDouble:self of: player
]
