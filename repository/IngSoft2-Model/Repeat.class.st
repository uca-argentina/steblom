Class {
	#name : #Repeat,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #apllying }
Repeat >> applyRedoOn: card of: player using: game [ 
	game applyRepeat.
]
