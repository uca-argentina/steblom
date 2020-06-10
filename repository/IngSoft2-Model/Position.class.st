Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'owner',
		'position',
		'lap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Position class >> for: player [ 
	^self new initializeFor:player.
]

{ #category : #testing }
Position >> areYou: player [
	^ player = owner
]

{ #category : #accessing }
Position >> backward: anInteger [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
Position >> backward: numberOfTiles with: endPosition [
	position - numberOfTiles < 1
		ifTrue: [ lap := lap - 1.
			position := endPosition + position - numberOfTiles ]
		ifFalse: [ position := position - numberOfTiles ]
]

{ #category : #accessing }
Position >> forward: numberOfTiles with: endPosition [
	position + numberOfTiles > endPosition
		ifTrue: [ position := position + numberOfTiles - endPosition.
			lap := lap + 1 ]
		ifFalse: [ position := position + numberOfTiles ]
]

{ #category : #accessing }
Position >> goToBeginning [
	position:=1
]

{ #category : #initialization }
Position >> initializeFor: player [
	owner := player.
	position := 1.
	lap := 1
]

{ #category : #testing }
Position >> isYourLapGreaterThan: finalLap [
	^ lap > finalLap
]

{ #category : #accessing }
Position >> owner [
	^ owner
]

{ #category : #accessing }
Position >> sumPosition [
	^ lap + position
]

{ #category : #accessing }
Position >> whereAreYou [
	^ position
]
