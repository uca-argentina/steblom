Class {
	#name : #Croupier,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'applying effect' }
Croupier >> applyTo: player using: game [ 
	game applyCroupierTo:player.
]
