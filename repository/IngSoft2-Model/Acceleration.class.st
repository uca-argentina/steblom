Class {
	#name : #Acceleration,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #cancelling }
Acceleration >> applyCancellation: cancellation using: game [
	game applyCancellation: cancellation onCard: self
]

{ #category : #redoing }
Acceleration >> applyRedo: redo onCard: card onPlayer: player using: game [ 
	game applyAccelerationWithRedo: self using:redo.
]

{ #category : #'applying card' }
Acceleration >> applyUsing: game [
	game applyOnAll:self.
]

{ #category : #'applying card' }
Acceleration >> applyUsing: game onCard: card onPlayer: player [
	self applyUsing: game
]

{ #category : #accessing }
Acceleration >> effect [
	^ 1
]

{ #category : #redoing }
Acceleration >> removeYourselfOfUsing: game [
	game remove: self.
]
