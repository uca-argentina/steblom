Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'die',
		'endPos',
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Game class >> withDie: aDie withEndPos: anEndPos withPlayers: aSetOfPlayers [ 
	^self new initializeWithDie:aDie withEndPos:anEndPos withPlayers: aSetOfPlayers.
]

{ #category : #boolean }
Game >> checkIfEnded [
	^(players checkPositions:endPos )
]

{ #category : #getter }
Game >> getFinalPositions [
	(self checkIfEnded) ifTrue:[^players getPositions] ifFalse:[^'Game did not end'].
]

{ #category : #initialization }
Game >> initializeWithDie: aDie withEndPos: anEndPos withPlayers: aSetOfPlayers [ 
	die:=aDie.
	endPos:=anEndPos.
	players:=aSetOfPlayers.
]

{ #category : #playing }
Game >> play [
	[self checkIfEnded] whileFalse:[players play:die].
	^self winner
]

{ #category : #getter }
Game >> winner [
	^players getWinner:endPos.
]
