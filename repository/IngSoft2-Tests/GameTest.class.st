Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testEndPositionCantBeNegative [
	|players die endPosition|
	die := Die of:6 rolling:#(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition:=-20.
	self should:[Game playedBy:players rolling:die until:endPosition andLap:2.]
		raise:Error
		description:'End position cannot be negative'
	
]

{ #category : #tests }
GameTest >> testFinalLapCantBeNegative [
	|players die endPosition finalLap|
	die := Die of:6 rolling:#(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition:=20.
	finalLap:=-2.
	self should:[Game playedBy:players rolling:die until:endPosition andLap:finalLap.]
		raise:Error
		description:'Final lap cannot be negative'
	
]

{ #category : #tests }
GameTest >> testFinalPositionsDoesntWorkIfGameHasNotEnded [
	|game players die endPosition|
	die := Die of:6 rolling:#(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition:=20.
	game := Game playedBy:players rolling:die until:endPosition andLap:2.
	self should:[game finalPositions]
		raise:Error
		description:'Game has not ended yet.'
	
]

{ #category : #tests }
GameTest >> testGameCanEnd [
	|game players die board endPosition|
	die := Die of:6 rolling:#(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition:=10.
	board:=Board with:SpeedUp new andSize:endPosition.
	game := Game playedBy:players rolling:die until:endPosition andLap:2 on:board.
	game play.
	self assert: game hasEnded.
]

{ #category : #tests }
GameTest >> testWinnerDoesNotExistIfGameHasNotEnded [
	|game players die board endPosition|
	die := Die of:6 rolling:#(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition:=20.
	game := Game playedBy:players rolling:die until:endPosition andLap:2.
	self should:[game winner]
		raise:Error
		description:'Game has not ended yet.'
	
]

{ #category : #tests }
GameTest >> testWinnerExists [
	|game players die board endPosition|
	die := Die of:6 rolling:#(1 1 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition:=10.
	board:=Board with:SpeedUp new andSize:endPosition.
	game := Game playedBy:players rolling:die until:endPosition andLap:1 on:board.
	game play.
	self assert: game winner equals:'Jorge'.
]
