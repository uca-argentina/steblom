Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testGameCanEnd [
	|game players die|
	die := Die of:6 rolling:#(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	game := Game playedBy:players rolling:die until:40 and:2.
	game play.
	self assert: game hasEnded.
]

{ #category : #tests }
GameTest >> testPlayersFinalPositions [
	|game players die|
	die := Die of:6 rolling:#(4 3 6).
	players := #('Pedro' 'Juan' 'Jorge').
	game := Game playedBy:players rolling:die until:45.
	game play.
	self assertCollection: (game finalPositions) hasSameElements:{(OrderedCollection with:'Pedro' with:32).(OrderedCollection with:'Juan' with:24).(OrderedCollection with:'Jorge' with:48)}.
]

{ #category : #tests }
GameTest >> testWinnerExists [
	|game players die|
	die := Die of:6 rolling:#(4 3 6).
	players := #('Pedro' 'Juan' 'Jorge').
	game := Game playedBy:players rolling:die until:45.
	game play.
	self assert: game winner equals:'Jorge'.
]
