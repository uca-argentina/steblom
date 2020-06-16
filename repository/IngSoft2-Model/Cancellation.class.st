Class {
	#name : #Cancellation,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
Cancellation >> applyRedoOn: card of: player using: game [ 
	card removeYourselfOf:player using: game
]
