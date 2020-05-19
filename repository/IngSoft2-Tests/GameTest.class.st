Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testGameCanEnd [
	|game players die board endPosition|
	die := Die of:6 rolling:#(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition:=10.
	game := Game playedBy:players rolling:die until:endPosition and:2.
	game play.
	self assert: game hasEnded.
]

{ #category : #tests }
GameTest >> testPlayersFinalPositions [
	|game players die|
	die := Die of:6 rolling:#(4 3 6).
	players := #('Pedro' 'Juan' 'Jorge').
	game := Game playedBy:players rolling:die until:45 and:1.
	game play.
	self assertCollection: (game finalPositions) hasSameElements:{(OrderedCollection with:'Pedro' with:19 with:1).(OrderedCollection with:'Juan' with:3 with:1).(OrderedCollection with:'Jorge' with:6 with:2)}.
]

{ #category : #tests }
GameTest >> testWinnerExists [
	|game players die|
	die := Die of:6 rolling:#(4 3 6).
	players := #('Pedro' 'Juan' 'Jorge').
	game := Game playedBy:players rolling:die until:10 and:1.
	game play.
	self assert: game winner equals:'Jorge'.
]
