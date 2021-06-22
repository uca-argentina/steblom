Class {
	#name : #Repeat,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #redoing }
Repeat >> applyRedo: redo onCard: card onPlayer: player using: game [ 
	game applyRepeatWithRedo: self.
]

{ #category : #apllying }
Repeat >> applyRedoOn: card of: player using: game [ 
	game applyRepeat: card.
]

{ #category : #'applying card' }
Repeat >> applyUsing: game [ 
	game applyRepeat: self.
]
