Class {
	#name : #Players,
	#superclass : #Object,
	#instVars : [
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #boolean }
Players >> checkPositions: anEndPos [
	^(players anySatisfy:[:player|player checkPosition:anEndPos])
]

{ #category : #getter }
Players >> getPositions [
	^players collect:[:player|player getPos]
]

{ #category : #getter }
Players >> getWinner: anEndPos [ 
	^(players select:[:player | player checkPosition:anEndPos]) first
]

{ #category : #initialization }
Players >> initializeWith: aPlayerSet [ 
	players:=aPlayerSet.
]

{ #category : #playing }
Players >> play: aDie [ 
	self withPlayersRoll: aDie.
]

{ #category : #playing }
Players >> withPlayersRoll: aDie [
	players do: [ :player | player play: aDie ]
]
