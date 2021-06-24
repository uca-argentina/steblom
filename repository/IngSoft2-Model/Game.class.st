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
		playing: cards
		until: endPosition
		and: finalLap
		on: aBoard
		storedOn: (HandsTable with: players and: (CircularIterator cyclingOver: cards))
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
		storedOn: (HandsTable generateRandomWith: players and: cards)
]

{ #category : #'applying card' }
Game >> applyAccelerationWithRedo: acceleration [ 
	handsTable applyOnAll: acceleration.
]

{ #category : #'applying effect' }
Game >> applyAtomicBomb [
	lastEffect := AtomicBomb new.
	positionsTable sendAllPlayersToBeginning
]

{ #category : #'applying card' }
Game >> applyCancellation: cancellation onCard: acceleration [ 
	handsTable assert: players current has: cancellation.
	handsTable assert: acceleration isAppliedTo: players current.
	acceleration removeYourselfOfUsing: self.
	handsTable remove: cancellation from: players current.
	lastCard := cancellation
]

{ #category : #'applying card' }
Game >> applyCancellation: cancellation onCard: card of: player [
	handsTable assert: players current has: cancellation.
	handsTable assert: card isAppliedTo: player.
	card removeYourselfOf: player using: self.
	handsTable remove: cancellation from: players current.
	lastCard := cancellation
]

{ #category : #cancelling }
Game >> applyCancellationWithRedo: cancellation onCard: card of: player [
	handsTable assert: card isAppliedTo: player.
	card removeYourselfOf: player using: self
]

{ #category : #'applying effect' }
Game >> applyCroupierTo: player [
	handsTable giveCardTo: player with: cards
]

{ #category : #'applying card' }
Game >> applyDouble: double [ 
	handsTable assert: players current has: double.
	handsTable remove: double from: players current.
	self playATurn.
	((players getOptions) size-1)timesRepeat: [ players next ]
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
	handsTable applyOnAll: acceleration.
	handsTable remove: acceleration from: players current.
	lastCard := acceleration
]

{ #category : #'applying card' }
Game >> applyPermanent: card on: player [
	handsTable assert: players current has: card.
	handsTable applyPermanent: card on: player.
	handsTable remove: card from: players current.
	lastCard := card
]

{ #category : #'applying card' }
Game >> applyPermanentWithRedo: card onPlayer: player [ 
	handsTable applyPermanent: card on: player.
]

{ #category : #'applying effect' }
Game >> applyRandomCroupierTo: player [
	handsTable giveRandomCardTo: player with: cards
]

{ #category : #'applying card' }
Game >> applyRepeat: repeat [ 
	| game |
	handsTable assert: players current has: repeat.
	game := self.
	lastEffect ifNotNil:[lastEffect applyTo: lastPlayer using: game].
	lastCard := repeat.
]

{ #category : #'applying card' }
Game >> applyRepeatWithRedo: repeat [
	| game |
	game := self.
	lastEffect ifNotNil: [ lastEffect applyTo: lastPlayer using: game ]
]

{ #category : #'applying card' }
Game >> applyReverse: reverse [ 
	| aux aux2 cont auxPlayer a |
	handsTable assert: players current has: reverse.
	handsTable remove: reverse from: players current.
	auxPlayer := players current.
	aux := players getOptions.
	aux2 := OrderedCollection new.
	cont := aux size.
	[ cont > 0 ] whileTrue: [ aux2 add: (aux at:cont). ((aux at:cont)=auxPlayer) ifTrue: [ a := cont ]. cont:=cont-1 ].
	players := CircularIterator cyclingOver: aux2.
	(a-1) timesRepeat: [ players next ]
]

{ #category : #'applying card' }
Game >> applySkip: skip of: player [ 
	handsTable assert: player has: skip.
	handsTable remove: skip from: player.
	players next.
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

{ #category : #getter }
Game >> lastCard [
	^ lastCard
]

{ #category : #playing }
Game >> playACard [
	(handsTable gotCardsInHand: players current)
		ifTrue: [ (handsTable randomCardFrom: players current)
				applyUsing: self
				onCard: lastCard
				onPlayer: players current ]
		
]

{ #category : #playing }
Game >> playATurn [
	positionsTable
		move: players current
		forward: die roll + (handsTable cardsEffectFor: players current)
		with: endPosition.
	(board effectAt: (positionsTable positionOf: players current))
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
	^ positionsTable positionOf: player
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
