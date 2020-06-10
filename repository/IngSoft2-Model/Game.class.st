Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'die',
		'endPosition',
		'table',
		'players',
		'finalLap',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertEndPositionIsPositive: endPosition [
	endPosition < 0
		ifTrue: [ Error signal: 'End position cannot be negative.' ]
]

{ #category : #asserting }
Game class >> assertFinalLapIsPositive: finalLap [
	finalLap < 0
		ifTrue: [ Error signal: 'Final lap cannot be negative.' ]
]

{ #category : #'instance creation' }
Game class >> playedBy: players rolling: aDie until: endPosition andLap: finalLap on: aBoard [
	self assertEndPositionIsPositive: endPosition.
	self assertFinalLapIsPositive: finalLap.
	^ self new
		initializePlayedBy: players
		rolling: aDie
		until: endPosition
		andLap: finalLap
		on: aBoard
]

{ #category : #'applying effect' }
Game >> applyAtomicBomb [
	table sendAllPlayersToBeginning
]

{ #category : #'applying effect' }
Game >> applyMoonwalkToEveryoneExcept: player with: n [
	table moveEveryoneExcept: player backward: n with: endPosition
]

{ #category : #'applying effect' }
Game >> applySpeedUpTo: player [
	table move: player forward: 4 with: endPosition
]

{ #category : #'applying effect' }
Game >> applyWormHoleTo: player [ 
	table move:player backward:4 with:endPosition
]

{ #category : #accessing }
Game >> finalPositions [
	self hasEnded
		ifTrue: [ ^ table finalPositions ]
		ifFalse: [ Error signal: 'Game has not ended yet' ]
]

{ #category : #boolean }
Game >> hasEnded [
	^ table arePositionsGreaterThan: finalLap
]

{ #category : #initialization }
Game >> initializePlayedBy: aSetOfPlayers rolling: aDie until: anEndPosition andLap: afinalLap on: aBoard [
	players := CircularIterator cyclingOver: aSetOfPlayers.
	die := aDie.
	endPosition := anEndPosition.
	finalLap := afinalLap.
	table := Table withPlayers: aSetOfPlayers.
	board := aBoard
]

{ #category : #playing }
Game >> playATurn [
	table move: players current forward: die roll with: endPosition.
	(board effect: (table whatIsThePositionOf: players current)) applyTo: players current using: self.
	players next.
]

{ #category : #accessing }
Game >> playerPositions [
	^ table playerPositions
]

{ #category : #accessing }
Game >> positionOf: player [
	^ table whatIsThePositionOf: player
]

{ #category : #accessing }
Game >> winner [
	^ table whoIsWinner: finalLap
]
