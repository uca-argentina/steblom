Class {
	#name : #Overload,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #cancelling }
Overload >> applyCancellation: cancellation onPlayer: player using: game [ 
	game applyCancellation: cancellation onCard: self of:player.
]

{ #category : #redoing }
Overload >> applyRedo: redo onCard: card onPlayer: player using: game [ 
	game applyPermanentWithRedo: self onPlayer: player 
]

{ #category : #'applying card' }
Overload >> applyUsing: game on: player [  
	game applyPermanent: self on: player. 
]

{ #category : #accessing }
Overload >> effect [
	^ -2
]

{ #category : #removing }
Overload >> removeYourselfOf: player using: game [
	game remove: self to: player
]
