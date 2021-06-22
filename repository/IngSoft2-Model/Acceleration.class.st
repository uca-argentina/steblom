Class {
	#name : #Acceleration,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #cancelling }
Acceleration >> applyCancellation: cancellation using: game [
	game applyCancellation: cancellation onCard: self
]

{ #category : #'applying card' }
Acceleration >> applyUsing: game [
	game applyOnAll:self.
]

{ #category : #accessing }
Acceleration >> effect [
	^ 1
]
