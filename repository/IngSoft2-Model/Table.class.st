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

{ #category : #testing }
Table >> arePositionsGreaterThan: endPosition [ 
	^rows anySatisfy: [ :row| ((row at:2)>endPosition) ].
	
	
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
Table >> useRoll: roll  toChangeStateOf: player [ 
	rows detect:[:row | (row at:1) = player.] ifFound:[:row|row at:2 put:(row at:2)+roll ] ifNone:[Error signal:'Used a player name that is not playing']
]

{ #category : #'changing state' }
Table >> useRoll: roll  toChangeStateOf: player with:endPosition [
	rows detect:[:row | (row at:1) = player.] ifFound:[:row| ((row at:2)+roll)>endPosition ifTrue:[row at:2 put:(row at:2)+roll-endPosition.  row at:3 put:(row at:3)+1  ] ifFalse:[ row at:2 put:(row at:2)+roll ] ] ifNone:[Error signal:'Used a player name that is not playing']
]

{ #category : #testing }
Table >> whoIsWinner: endPosition [
	rows detect:[:row | (row at:2)>=endPosition] ifFound:[:row|^(row at:1)] ifNone:[Error signal:'Game has not ended yet']
]
