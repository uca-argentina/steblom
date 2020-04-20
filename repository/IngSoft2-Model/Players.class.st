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
	^((players getOptions)anySatisfy:[:player|player checkPosition:anEndPos])
]

{ #category : #getter }
Players >> getPositions [
	^(players getOptions)collect:[:player|player getPos]
]

{ #category : #getter }
Players >> getWinner: anEndPos [ 
	^((players getOptions)select:[:player | player checkPosition:anEndPos]) first
]

{ #category : #initialization }
Players >> initializeWith: aPlayerSet [ 
	players:=CircularIterator cyclingOver:aPlayerSet.
]

{ #category : #playing }
Players >> play: aDie [ 
	self withPlayersRoll: aDie.
]

{ #category : #playing }
Players >> withPlayersRoll: aDie [
	(players current) play: aDie.
	players next 
]
