Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testAskingForWinnerFailsIfGameHasNotEndedYet [
	| game players die board endPosition effects |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 20.
	effects := {NoEffect new.
	SpeedUp new.
	WormHole new.
	AtomicBomb new.
	(MoonWalk substracting: 2)}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		until: endPosition
		andLap: 2
		on: board.
	self
		should: [ game winner ]
		raise: Error
		whoseDescriptionIncludes: 'Game has not ended yet.'
		description: 'Game has not ended yet.'
]

{ #category : #tests }
GameTest >> testAtomicBomb [
	| game players die board endPosition effects |
	die := Die of: 6 rolling: #(5 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {AtomicBomb new}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	self assert: (game positionOf:'Pedro') equals:1.
]

{ #category : #tests }
GameTest >> testEndPositionCantBeNegative [
	| players die endPosition effects board |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := -20.
	effects := {NoEffect new.
	SpeedUp new.
	WormHole new.
	AtomicBomb new.
	(MoonWalk substracting: 2)}.
	board := Board generateWith: effects sized: endPosition.
	self
		should: [ Game
				playedBy: players
				rolling: die
				until: endPosition
				andLap: 2
				on: board ]
		raise: Error
		whoseDescriptionIncludes: 'End position cannot be negative.'
		description: 'End position cannot be negative.'
]

{ #category : #tests }
GameTest >> testFinalLapCantBeNegative [
	| players die endPosition finalLap effects board |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 20.
	finalLap := -2.
	effects := {NoEffect new.
	SpeedUp new.
	WormHole new.
	AtomicBomb new.
	(MoonWalk substracting: 2)}.
	board := Board generateWith: effects sized: endPosition.
	self
		should: [ Game
				playedBy: players
				rolling: die
				until: endPosition
				andLap: finalLap
				on: board ]
		raise: Error
		whoseDescriptionIncludes: 'Final lap cannot be negative.'
		description: 'Final lap cannot be negative'
]

{ #category : #tests }
GameTest >> testFinalPositionsDoesntWorkIfGameHasNotEnded [
	| game players die endPosition effects board |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 20.
	effects := {NoEffect new.
	SpeedUp new.
	WormHole new.
	AtomicBomb new.
	(MoonWalk substracting: 2)}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		until: endPosition
		andLap: 2
		on: board.
	self
		should: [ game finalPositions ]
		raise: Error
		whoseDescriptionIncludes:'Game has not ended yet'
		description: 'Game has not ended yet.'
]

{ #category : #tests }
GameTest >> testGameCanEnd [
	| game players die board endPosition effects |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new.
	SpeedUp new.
	WormHole new.
	AtomicBomb new.
	(MoonWalk substracting: 2)}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		until: endPosition
		andLap: 2
		on: board.
	[ game hasEnded ] whileFalse: [ game playATurn ].
	self assert: game hasEnded
]

{ #category : #tests }
GameTest >> testMoonWalk [
	| game players die board endPosition effects |
	die := Die of: 6 rolling: #(5 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {MoonWalk substracting:2}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	self assert: (game positionOf:'Pedro') equals:6.
	self assert: (game positionOf:'Juan') equals:9.
	self assert: (game positionOf:'Jorge') equals:9.
]

{ #category : #tests }
GameTest >> testNoEffect [
	| game players die board endPosition effects |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	self assert: (game positionOf:'Pedro') equals:5.
]

{ #category : #tests }
GameTest >> testPlayersPositions [
	| game players die board endPosition effects |
	die := Die of: 6 rolling: #(1 6 1).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new.
	SpeedUp new.
	WormHole new.
	AtomicBomb new.
	(MoonWalk substracting: 2)}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		until: endPosition
		andLap: 2
		on: board.
	[ game hasEnded ] whileFalse: [ game playATurn ].
	self
		assert: game playerPositions
		equals: (OrderedCollection with: 'Juan' with: 'Pedro' with: 'Jorge')
]

{ #category : #tests }
GameTest >> testSpeedUp [
	| game players die board endPosition effects |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {SpeedUp new}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	self assert: (game positionOf:'Pedro') equals:9.
]

{ #category : #tests }
GameTest >> testWinnerExists [
	| game players die board endPosition effects |
	die := Die of: 6 rolling: #(1 1 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new.
	SpeedUp new.
	WormHole new.
	AtomicBomb new.
	(MoonWalk substracting: 2)}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		until: endPosition
		andLap: 1
		on: board.
	[ game hasEnded ] whileFalse: [ game playATurn ].
	self assert: game winner equals: 'Jorge'
]

{ #category : #tests }
GameTest >> testWormHole [
	| game players die board endPosition effects |
	die := Die of: 6 rolling: #(5 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {WormHole new}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	self assert: (game positionOf:'Pedro') equals:2.
]
