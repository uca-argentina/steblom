Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'applying effect' }
SpeedUp >> applyTo: player using: game [
	game applySpeedUpTo: player
]
