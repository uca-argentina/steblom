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

{ #category : #asserting }
Game class >> assertFinalLapIsPositive:finalLap [
	^finalLap>0
]

{ #category : #'instance creation' }
Game class >> playedBy: players rolling: aDie until: endPosition andLap:finalLap [
	(self assertEndPositionIsPositive:endPosition) ifTrue:[(self assertFinalLapIsPositive:finalLap) 	ifTrue:[^self new initializePlayedBy:players rolling: 	aDie until:endPosition andLap:finalLap.] 	ifFalse:[Error signal:'Final lap cannot be negative']] 	ifFalse:[Error signal:'End position cannot be 	negative']
]

{ #category : #'instance creation' }
Game class >> playedBy: players rolling: aDie until: endPosition andLap:finalLap on:aBoard [
	(self assertEndPositionIsPositive:endPosition) ifTrue:[(self assertFinalLapIsPositive:finalLap) 	ifTrue:[^self new initializePlayedBy:players rolling: 	aDie until:endPosition andLap:finalLap 	on:aBoard.] 	ifFalse:[Error signal:'Final lap cannot be negative']] 	ifFalse:[Error signal:'End 	position cannot be 	negative']
]

{ #category : #accessing }
Game >> finalPositions [
	self hasEnded ifTrue:[^table finalPositions] ifFalse:[Error signal:'Game has not ended yet']
]

{ #category : #boolean }
Game >> hasEnded [
	^table arePositionsGreaterThan:endPosition and:finalLap.
]

{ #category : #initialization }
Game >> initializePlayedBy: aSetOfPlayers rolling: aDie until: anEndPosition andLap: afinalLap [
	players:=CircularIterator cyclingOver:aSetOfPlayers.
	die:=aDie.
	endPosition:=anEndPosition.
	finalLap:=afinalLap.
	table:= Table withPlayers:aSetOfPlayers.
	board:= Board generateSized:anEndPosition.
	
	
]

{ #category : #initialization }
Game >> initializePlayedBy: aSetOfPlayers rolling: aDie until: anEndPosition andLap: afinalLap on:aBoard [
	players:=CircularIterator cyclingOver:aSetOfPlayers.
	die:=aDie.
	endPosition:=anEndPosition.
	finalLap:=afinalLap.
	table:= Table withPlayers:aSetOfPlayers.
	board:= aBoard.
	
	
]

{ #category : #playing }
Game >> play [
	[self hasEnded] whileFalse:[table useRoll:die roll toChangeStateOf:players current with:endPosition 	using:board.
	players next. table playerPositions ]
]

{ #category : #accessing }
Game >> playerPositions [
	^table playerPositions
]

{ #category : #accessing }
Game >> winner [
	^table whoIsWinner:finalLap.
]
