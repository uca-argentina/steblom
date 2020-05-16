Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'die',
		'endPosition',
		'table',
		'players'
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

{ #category : #accessing }
Game >> finalPositions [
	^table finalPositions.
]

{ #category : #boolean }
Game >> hasEnded [
	^table arePositionsGreaterThan:endPosition.
]

{ #category : #initialization }
Game >> initializePlayedBy: aSetOfPlayers rolling: aDie until: anEndPosition [
	players:=CircularIterator cyclingOver:aSetOfPlayers.
	die:=aDie.
	endPosition:=anEndPosition.
	table:= Table withPlayers:aSetOfPlayers.
	
]

{ #category : #playing }
Game >> play [
	[self hasEnded] whileFalse:[table useRoll:die roll toChangeStateOf:players current.
	players next]
]

{ #category : #accessing }
Game >> winner [
	^table whoIsWinner:endPosition.
]
