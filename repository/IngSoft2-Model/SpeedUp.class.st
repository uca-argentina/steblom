Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'applying effect' }
SpeedUp >> applyTo: aTable usingPlayer: player with: endPosition [  
	aTable applySpeedUpTo: player with:endPosition
]
