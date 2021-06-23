Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'owner',
		'lap',
		'tile'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Position class >> for: player [ 
	^self new initializeFor:player.
]

{ #category : #comparing }
Position >> > aPosition [
	lap > aPosition lap
		ifTrue: [ ^ true ]
		ifFalse: [ self lap == aPosition lap
				ifTrue: [ ^ tile > aPosition tile ]
				ifFalse: [ ^ false ] ]
]

{ #category : #testing }
Position >> areYouFrom: player [
	^ player = owner
]

{ #category : #accessing }
Position >> backward: numberOfTiles with: endPosition [
	tile - numberOfTiles < 1
		ifTrue: [ tile := 1 ]
		ifFalse: [ tile := tile - numberOfTiles ]
]

{ #category : #accessing }
Position >> forward: numberOfTiles with: endPosition [
	tile + numberOfTiles > endPosition
		ifTrue: [ tile := tile + numberOfTiles - endPosition.
			lap := lap + 1 ]
		ifFalse: [ tile := tile + numberOfTiles ].
	
]

{ #category : #accessing }
Position >> goToBeginning [
	tile:=1
]

{ #category : #initialization }
Position >> initializeFor: player [
	owner := player.
	tile := 1.
	lap := 1
]

{ #category : #testing }
Position >> isYourLapGreaterThan: finalLap [
	^ lap > finalLap
]

{ #category : #getter }
Position >> lap [
	^ lap
]

{ #category : #accessing }
Position >> owner [
	^ owner
]

{ #category : #getter }
Position >> tile [
	^ tile
]

{ #category : #accessing }
Position >> whereAreYou [
	^ tile
]
