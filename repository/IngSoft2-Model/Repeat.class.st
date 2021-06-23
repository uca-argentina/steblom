Class {
	#name : #Repeat,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #cancelling }
Repeat >> applyCancellation: card onPlayer: player using: game [

]

{ #category : #redoing }
Repeat >> applyRedo: redo onCard: card onPlayer: player using: game [ 
	game applyRepeatWithRedo: self.
]

{ #category : #'applying card' }
Repeat >> applyUsing: game [ 
	game applyRepeat: self.
]

{ #category : #applying }
Repeat >> applyUsing: game onCard: card onPlayer: player [
	self applyUsing: game
]
