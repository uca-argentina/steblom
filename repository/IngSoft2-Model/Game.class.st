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
Game class >> assertEndPositionIsPositive: anInteger [ 
	^anInteger>0
]

{ #category : #'instance creation' }
Game class >> playedBy: players rolling: aDie until: endPosition [
	(self assertEndPositionIsPositive:endPosition) ifTrue:[^self new initializePlayedBy:players rolling: 	aDie until:endPosition.] ifFalse:[Error signal:'End position cannot be negative']
]

{ #category : #'instance creation' }
Game class >> playedBy: players rolling: aDie until: endPosition and:finalLap [
	(self assertEndPositionIsPositive:endPosition) ifTrue:[^self new initializePlayedBy:players rolling: 	aDie until:endPosition and:finalLap.] ifFalse:[Error signal:'End position cannot be negative']
]

{ #category : #'instance creation' }
Game class >> playedBy: players rolling: aDie until: endPosition and:finalLap on:aBoard [
	(self assertEndPositionIsPositive:endPosition) ifTrue:[^self new initializePlayedBy:players rolling: 	aDie until:endPosition and:finalLap on:aBoard] ifFalse:[Error signal:'End position cannot be negative']
]

{ #category : #accessing }
Game >> finalPositions [
	^table finalPositions.
]

{ #category : #boolean }
Game >> hasEnded [
	^table arePositionsGreaterThan:endPosition and:finalLap.
]

{ #category : #initialization }
Game >> initializePlayedBy: aSetOfPlayers rolling: aDie until: anEndPosition [
	players:=CircularIterator cyclingOver:aSetOfPlayers.
	die:=aDie.
	endPosition:=anEndPosition.
	table:= Table withPlayers:aSetOfPlayers.
	
]

{ #category : #initialization }
Game >> initializePlayedBy: aSetOfPlayers rolling: aDie until: anEndPosition and: afinalLap [
	players:=CircularIterator cyclingOver:aSetOfPlayers.
	die:=aDie.
	endPosition:=anEndPosition.
	finalLap:=afinalLap.
	table:= Table withPlayers:aSetOfPlayers.
	board:= Board Random:anEndPosition.
	
	
]

{ #category : #initialization }
Game >> initializePlayedBy: aSetOfPlayers rolling: aDie until: anEndPosition and: afinalLap on:aBoard [
	players:=CircularIterator cyclingOver:aSetOfPlayers.
	die:=aDie.
	endPosition:=anEndPosition.
	finalLap:=afinalLap.
	table:= Table withPlayers:aSetOfPlayers.
	board:= aBoard.
	
	
]

{ #category : #playing }
Game >> play [
	[self hasEnded] whileFalse:[table useRoll:die roll toChangeStateOf:players current with:endPosition using:board.
	players next]
]

{ #category : #accessing }
Game >> winner [
	^table whoIsWinner:finalLap.
]
