Class {
	#name : #Table,
	#superclass : #Object,
	#instVars : [
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Table class >> withPlayers: aSetOfPlayers [ 
	^self new initializeWithPlayers:aSetOfPlayers
]

{ #category : #testing }
Table >> arePositionsGreaterThan: finalLap [
	positions
		detect: [ :position | position isYourLapGreaterThan: finalLap ]
		ifFound: [ ^ true ]
		ifNone: [ ^ false ]
]

{ #category : #initialization }
Table >> initializeWithPlayers: aSetOfPlayers [
	positions := OrderedCollection new.
	aSetOfPlayers do: [ :player | positions add: (Position for: player) ]
]

{ #category : #accessing }
Table >> move: player backward: numberOfTiles [ 
	positions
		detect: [ :position | position areYou: player ]
		ifFound: [ :position | position backward: numberOfTiles ]
		ifNone: [ Error signal: 'Player not found.' ]
]

{ #category : #accessing }
Table >> move: player backward: numberOfTiles with: endPosition [
	positions
		detect: [ :position | position areYou: player ]
		ifFound: [ :position | position backward: numberOfTiles with: endPosition ]
		ifNone: [ Error signal: 'Player not found.' ]
]

{ #category : #accessing }
Table >> move: player forward: numberOfTiles with: endPosition [
	positions
		detect: [ :position | position areYou: player ]
		ifFound: [ :position | position forward: numberOfTiles with: endPosition ]
		ifNone: [ Error signal: 'Player not found.' ]
]

{ #category : #accessing }
Table >> moveEveryoneExcept: player backward: numberOfTiles with: endPosition [
	positions
		do: [ :position | 
			(position areYou: player)
				ifFalse: [ position backward: numberOfTiles with: endPosition ] ]
]

{ #category : #accessing }
Table >> playerPositions [
	| auxPositions sortedPlayers |
	auxPositions := SortedCollection new.
	auxPositions sort: [ :a :b | a sumPosition > b sumPosition ].
	positions do: [ :position | auxPositions add: position ].
	sortedPlayers := OrderedCollection new.
	auxPositions do: [ :position | sortedPlayers add: position owner ].
	^ sortedPlayers
]

{ #category : #accessing }
Table >> sendAllPlayersToBeginning [
	positions do: [ :position | position goToBeginning ]
]

{ #category : #accessing }
Table >> whatIsThePositionOf:player [
	positions
		detect: [ :position | position areYou: player ]
		ifFound: [ :position | ^position whereAreYou  ]
		ifNone: [ Error signal: 'Player not found.' ]
]
