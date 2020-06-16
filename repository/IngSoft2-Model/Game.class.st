Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'die',
		'endPosition',
		'players',
		'finalLap',
		'board',
		'cards',
		'handsTable',
		'positionsTable',
		'lastEffect',
		'lastPlayer',
		'lastCard'
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
Game class >> playedBy: players rolling: aDie playing: cards until: endPosition andLap: finalLap on: aBoard [
	self assertEndPositionIsPositive: endPosition.
	self assertFinalLapIsPositive: finalLap.
	^ self new
		initializePlayedBy: players
		rolling: aDie
		playing: (CircularIterator cyclingOver:cards)
		until: endPosition
		and: finalLap
		on: aBoard
		storedOn: (HandsTable with: players and: (CircularIterator cyclingOver:cards))
]

{ #category : #'instance creation' }
Game class >> playedBy: players rolling: aDie playingRandom: cards until: endPosition andLap: finalLap on: aBoard [
	self assertEndPositionIsPositive: endPosition.
	self assertFinalLapIsPositive: finalLap.
	^ self new
		initializePlayedBy: players
		rolling: aDie
		playing: cards
		until: endPosition
		and: finalLap
		on: aBoard
		storedOn: (HandsTable generateRandomWith: players and: cards )
]

{ #category : #'applying effect' }
Game >> applyAtomicBomb [
	lastEffect := AtomicBomb new.
	positionsTable sendAllPlayersToBeginning
]

{ #category : #'applying card' }
Game >> applyCard: repeat of: player [ 
	handsTable assert: player has: repeat.
	self assertLastEffectNotNil.
	lastEffect applyTo: lastPlayer using: self.
	lastCard := repeat.
]

{ #category : #'applying card' }
Game >> applyCard: redo of: ownerPlayer on: card of: appliedPlayer [
	handsTable assert: ownerPlayer has: redo.
	lastCard applyRedoOn: card of: appliedPlayer using: self
	
]

{ #category : #'applying card' }
Game >> applyCard: cancellation of: player toCard: acceleration [
	handsTable assert: player has: cancellation.
	handsTable assert: acceleration isAppliedTo: player.
	acceleration removeYourselfOf: player using: self.
	lastCard := cancellation
]

{ #category : #'applying card' }
Game >> applyCard: cancellation of: ownerPlayer toCard: card of: appliedPlayer [
	handsTable assert: ownerPlayer has: cancellation.
	handsTable assert: card isAppliedTo: appliedPlayer.
	card removeYourselfOf: appliedPlayer using: self.
	lastCard := cancellation
]

{ #category : #'applying effect' }
Game >> applyCroupierTo: player [
	handsTable giveCardTo: player with: cards
]

{ #category : #'applying effect' }
Game >> applyMoonwalkToEveryoneExcept: player with: n [
	lastEffect := MoonWalk substracting: n.
	lastPlayer := player.
	positionsTable moveEveryoneExcept: player backward: n with: endPosition
]

{ #category : #'applying card' }
Game >> applyOnAll: acceleration [
	handsTable assert: players current has: acceleration.
	handsTable applyOnAll: acceleration
]

{ #category : #'applying card' }
Game >> applyPermanent: card on: player [
	handsTable assert: players current has: card.
	handsTable applyPermanent: card on: player.
	handsTable remove: card from: players current
]

{ #category : #'applying effect' }
Game >> applyRandomCroupierTo: player [
	handsTable giveRandomCardTo: player with: cards
]

{ #category : #'applying card' }
Game >> applyRepeat [
	self assertLastEffectNotNil.
	lastEffect applyTo: lastPlayer using: self.
	
]

{ #category : #'applying effect' }
Game >> applySpeedUpTo: player [
	lastEffect := SpeedUp new.
	lastPlayer := player.
	positionsTable move: player forward: 4 with: endPosition
]

{ #category : #'applying effect' }
Game >> applyWormHoleTo: player [ 
	lastEffect := WormHole new.
	lastPlayer := player.
	positionsTable move:player backward:4 with:endPosition
]

{ #category : #testing }
Game >> assertLastEffectNotNil [
	lastEffect ~= nil
		ifFalse: [ Error signal: 'Cannot use repeat before someone rolls die' ]
]

{ #category : #accessing }
Game >> count: aClass [ 
	^ handsTable count: aClass
]

{ #category : #accessing }
Game >> finalPositions [
	self hasEnded
		ifTrue: [ ^ positionsTable finalPositions ]
		ifFalse: [ Error signal: 'Game has not ended yet' ]
]

{ #category : #boolean }
Game >> hasEnded [
	^ positionsTable arePositionsGreaterThan: finalLap
]

{ #category : #initialization }
Game >> initializePlayedBy: aSetOfPlayers rolling: aDie playing: aSetOfCards until: anEndPosition and: afinalLap on: aBoard storedOn: aHandsTable [
	players := CircularIterator cyclingOver: aSetOfPlayers.
	die := aDie.
	cards := aSetOfCards.
	handsTable := aHandsTable.
	endPosition := anEndPosition.
	finalLap := afinalLap.
	positionsTable := PositionsTable withPlayers: aSetOfPlayers.
	board := aBoard
]

{ #category : #playing }
Game >> playATurn [
	positionsTable
		move: players current
		forward: die roll + (handsTable cardsEffectFor: players current)
		with: endPosition.
	(board effect: (positionsTable whatIsThePositionOf: players current))
		applyTo: players current
		using: self.
	players next
]

{ #category : #accessing }
Game >> playerPositions [
	^ positionsTable playerPositions
]

{ #category : #accessing }
Game >> positionOf: player [
	^ positionsTable whatIsThePositionOf: player
]

{ #category : #removing }
Game >> remove: acceleration [
	handsTable remove: acceleration
]

{ #category : #removing }
Game >> remove: card to: player [ 
	handsTable remove: card to: player
]

{ #category : #removing }
Game >> removeCardsFrom: player [ 
	handsTable removeCardsFrom: player
]

{ #category : #accessing }
Game >> winner [
	^ positionsTable whoIsWinner: finalLap
]
