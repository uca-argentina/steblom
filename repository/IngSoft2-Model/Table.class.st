Class {
	#name : #Table,
	#superclass : #Object,
	#instVars : [
		'rows'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Table class >> withPlayers: aSetOfPlayers [ 
	^self new initializeWithPlayers:aSetOfPlayers
]

{ #category : #'changing state' }
Table >> addLap: player [
	rows
		detect: [ :row | (row at: 1) = player ]
		ifFound: [ :row | row at: 3 put: (row at: 3) + 1 ]
]

{ #category : #'applying effect' }
Table >> applyAtomicBomb [
	rows do:[:row | row at:2 put:0]
]

{ #category : #'applying effect' }
Table >> applyMoonwalkToEveryoneExcept: player with: endPosition substracting: anInteger [ 
	rows do:[:row | (row at:1) ~=player ifTrue:[(row at:2)-anInteger<0 ifTrue:[self substractLap:(row at:1). row at:2 put:endPosition+(row at:2)-anInteger] ifFalse:[row at:2 put: (row at:2)-anInteger] ]] 
]

{ #category : #'applying effect' }
Table >> applySpeedUpTo: player with: endPosition [ 
	|auxPosition|
	rows detect:[:row | (row at:1) =player] ifFound:[:row | auxPosition:=(row at:2)+4].
	(auxPosition>endPosition) ifTrue:[self addLap:player. self movePlayer:player to: 	auxPosition-endPosition]
	ifFalse:[self movePlayer:player to:auxPosition]
]

{ #category : #'applying effect' }
Table >> applyWormHoleTo: player with: endPosition [
	|auxPosition|
	rows detect:[:row | (row at:1) =player] ifFound:[:row | auxPosition:=(row at:2)-4].
	(auxPosition<0) ifTrue:[self substractLap:player. self movePlayer:player to:endPosition+auxPosition]
	ifFalse:[self movePlayer:player to:auxPosition]
]

{ #category : #testing }
Table >> arePositionsGreaterThan: endPosition and:finalLap [
	^rows anySatisfy: [ :row| ((row at:3)>finalLap) ].
	
	
]

{ #category : #accessing }
Table >> finalPositions [
	^rows
]

{ #category : #initialization }
Table >> initializeWithPlayers: aSetOfPlayers [ 
	rows:=OrderedCollection new.
	aSetOfPlayers do: [ :player | rows add:(OrderedCollection with:player with:0 with:0) ].
]

{ #category : #'changing state' }
Table >> movePlayer: player to: temporaryPosition [
	rows
		detect: [ :row | (row at: 1) = player ]
		ifFound: [ :row | row at: 2 put: temporaryPosition ]
]

{ #category : #'as yet unclassified' }
Table >> playerPositions [
   | positions sortedPlayers|
   positions:= SortedCollection new.
	positions sort: [ :a :b | (a at:1) > (b at:1) ].
   rows do: [ :row | positions add: (OrderedCollection with:((row at:2)+(row at:3)) with:(row at:1))].
   sortedPlayers:=positions collect:[:position |position at:2].
	^sortedPlayers.
	
]

{ #category : #accessing }
Table >> substractLap: player [
	rows
		detect: [ :row | (row at: 1) = player ]
		ifFound: [ :row | row at: 3 put: (row at: 3) - 1 ]
]

{ #category : #'changing state' }
Table >> useRoll: roll toChangeStateOf: player with: endPosition using: board [
	| auxPosition temporaryPosition |
	rows
		detect: [ :row | (row at: 1) = player ]
		ifFound: [ :row | auxPosition := (row at: 2) + roll ]
		ifNone: [ Error signal: 'Used a player name that is not playing' ].
	auxPosition > endPosition
		ifTrue: [ self addLap: player.
			temporaryPosition := auxPosition - endPosition ]
		ifFalse: [ temporaryPosition := auxPosition ].
	self movePlayer: player to: temporaryPosition.
	(board effect: temporaryPosition)
		applyTo: self
		usingPlayer: player
		with: endPosition
]

{ #category : #testing }
Table >> whoIsWinner: finalLap [
	rows detect:[:row | (row at:3)>finalLap] ifFound:[:row|^(row at:1)] ifNone:[Error signal:'Game has not ended yet']
]
