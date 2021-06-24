Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testAcceleration [
	| game players die board endPosition effects cards acceleration |
	die := Die of: 6 rolling: #(4 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	acceleration := Acceleration new.
	cards := {acceleration}.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	acceleration applyUsing:game.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert: (game positionOf: 'Pedro') equals: 6.
	self assert: (game positionOf: 'Juan') equals: 7.
	self assert: (game positionOf: 'Jorge') equals: 8
]

{ #category : #tests }
GameTest >> testAskingForWinnerFailsIfGameHasNotEndedYet [
	| game players die board endPosition effects overload cards |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 20.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := { overload }.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	self
		should: [ game winner ]
		raise: Error
		whoseDescriptionIncludes: 'Game has not ended yet.'
		description: 'Game has not ended yet.'
]

{ #category : #tests }
GameTest >> testAtomicBomb [
	| game players die board endPosition effects overload cards |
	die := Die of: 6 rolling: #(5 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {AtomicBomb new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := { overload }.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	self assert: (game positionOf:'Pedro') equals:1.
]

{ #category : #tests }
GameTest >> testCancellationOnAcceleration [
	| game players die board endPosition effects cards cancellation acceleration |
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	acceleration := Acceleration new.
	cancellation := Cancellation new.
	cards := {acceleration.
	cancellation}.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	acceleration applyUsing: game.
	game playATurn.
	self assert: (game positionOf: 'Pedro') equals: 7.
	cancellation applyUsing: game onCard: acceleration.
	game playATurn.
	self assert: (game positionOf: 'Juan') equals: 6
]

{ #category : #tests }
GameTest >> testCancellationOnOverLoad [
	| game players die board endPosition effects cards cancellation overload |
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 30.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cancellation := Cancellation new.
	cards := {overload.
	cancellation}.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	overload applyUsing: game on: 'Pedro'.
	game playATurn.
	self assert: (game positionOf: 'Pedro') equals: 4.
	cancellation applyUsing: game onCard: overload onPlayer: 'Pedro'.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert: (game positionOf: 'Pedro') equals: 9
]

{ #category : #tests }
GameTest >> testCancellationOnSpeed [
	| game players die board endPosition effects cards cancellation speed |
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 30.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	speed := Speed new.
	cancellation := Cancellation new.
	cards := {speed.
	cancellation}.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	speed applyUsing: game on: 'Pedro'.
	game playATurn.
	self assert: (game positionOf: 'Pedro') equals: 7.
	cancellation applyUsing: game onCard: speed onPlayer: 'Pedro'.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert: (game positionOf: 'Pedro') equals: 12
]

{ #category : #tests }
GameTest >> testCardDeckActualSizeChanges [
	| players cards die endPosition effects board game |
	cards := {Overload new.
	Speed new.
	Acceleration new.
	Cancellation new.
	Repeat new}.
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {Croupier new}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		playingRandom: cards
		until: endPosition
		andLap: 2
		on: board.
	self assert: game cardDeck actualSize equals: 4.
	game playATurn.
	self assert: game cardDeck actualSize equals: 3.
	
]

{ #category : #tests }
GameTest >> testCardDeckHasCards [
	| players cards die endPosition effects board game |
	players := {'Jorge' . 'Pedro'}.
	cards := {Overload new.
	Speed new.
	Acceleration new.
	Cancellation new.
	Repeat new}.
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		playingRandom: cards
		until: endPosition
		andLap: 2
		on: board.
	self assert: ((game cardDeck) actualSize)>0

]

{ #category : #tests }
GameTest >> testCardDeckIsShuffledWhenEmpty [
	| players cards die endPosition effects board game |
	cards := {Overload new.
	Speed new.
	Acceleration new.
	Repeat new}.
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {Croupier new}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		playingRandom: cards
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	game playACard.
	self assert: game cardDeck actualSize equals: 3.
	game playATurn.
	game playACard.
	self assert: game cardDeck actualSize equals: 2.
	game playATurn.
	game playACard.
	self assert: game cardDeck actualSize equals: 1.
	game playATurn.
	game playACard.
	self assert: game cardDeck actualSize equals: 0.
	self assert: game discardDeck actualSize equals: 4.
	game playATurn.
	self assert: game cardDeck actualSize equals: 4
]

{ #category : #tests }
GameTest >> testCardsCannotBeGivenIfDecksEmpty [
	| players cards die endPosition effects board game |
	cards := {Overload new.
	Speed new.
	Acceleration new.
	Repeat new}.
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {Croupier new}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		playingRandom: cards
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	self assert: game cardDeck actualSize equals: 3.
	game playATurn.
	self assert: game cardDeck actualSize equals: 2.
	game playATurn.
	self assert: game cardDeck actualSize equals: 1.
	game playATurn.
	self assert: game cardDeck actualSize equals: 0.
	game playATurn.
	self assert: game cardDeck actualSize equals: 0.
	
]

{ #category : #tests }
GameTest >> testCroupier [
	| game players die board endPosition effects overload cards |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {Croupier new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := { overload }.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	game applyPermanent:overload on:'Juan'.
	game applyPermanent:overload on:'Juan'.
	game playATurn. 
	game playATurn.
	game playATurn.
	game applyPermanent:overload on:'Juan'.
	self assert: (game positionOf:'Pedro') equals:5.
]

{ #category : #tests }
GameTest >> testDeckHasCards [
	| players cards die endPosition effects board game |
	players := {'Jorge' . 'Pedro'}.
	cards := {Overload new.
	Speed new.
	Acceleration new.
	Cancellation new.
	Repeat new}.
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		playingRandom: cards
		until: endPosition
		andLap: 2
		on: board.
	self assert: ((game cardDeck) actualSize)>0

]

{ #category : #tests }
GameTest >> testDiscardDeckActualSizeAddsUpWhenCardsAreUsed [
	| players cards die endPosition effects board game |
	players := {'Jorge' . 'Pedro'}.
	cards := {Overload new.
	Speed new.
	Acceleration new.
	Repeat new}.
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		playingRandom: cards
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	self assert: game discardDeck actualSize equals: 0.
	game playACard.
	self assert: game discardDeck actualSize equals: 1.
	game playACard.
	self assert: game discardDeck actualSize equals: 2.
	game playATurn.
	game playACard.
	self assert: game discardDeck actualSize equals: 3.
]

{ #category : #tests }
GameTest >> testDiscardDeckActualSizeChanges [
	| players cards die endPosition effects board game |
	players := {'Jorge' . 'Pedro'}.
	cards := {Overload new.
	Speed new.
	Acceleration new.
	Cancellation new.
	Repeat new}.
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	game := Game
		playedBy: players
		rolling: die
		playingRandom: cards
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	game playACard.
	self assert: ((game discardDeck) actualSize)>0

]

{ #category : #tests }
GameTest >> testEndPositionCantBeNegative [
	| players die endPosition effects board overload cards |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := -20.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := {overload}.
	self
		should: [ Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board. ]
		raise: Error
		whoseDescriptionIncludes: 'End position cannot be negative.'
		description: 'End position cannot be negative.'
]

{ #category : #tests }
GameTest >> testErrorIfPlayerDoesNotOwnTheCard [
	| game players die board endPosition effects overload cards |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 20.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := { overload }.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	self
		should: [ game applyOnAll:Acceleration new ]
		raise: Error
		whoseDescriptionIncludes: 'Current player does not own that card'
		description: 'Current player does not own that card'
]

{ #category : #tests }
GameTest >> testFinalLapCantBeNegative [
	| players die endPosition finalLap effects board overload cards |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 20.
	finalLap := -2.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := {overload}.
	self
		should: [ Game
				playedBy: players
				rolling: die
				playing: cards
				until: endPosition
				andLap: finalLap
				on: board ]
		raise: Error
		whoseDescriptionIncludes: 'Final lap cannot be negative.'
		description: 'Final lap cannot be negative'
]

{ #category : #tests }
GameTest >> testFinalPositionsDoesntWorkIfGameHasNotEnded [
	| game players die endPosition effects board overload cards |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 20.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := { overload }.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	self
		should: [ game finalPositions ]
		raise: Error
		whoseDescriptionIncludes: 'Game has not ended yet'
		description: 'Game has not ended yet.'
]

{ #category : #tests }
GameTest >> testGameCanEnd [
	| game players die board endPosition effects overload cards |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := { overload }.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	[ game hasEnded ] whileFalse: [ game playATurn ].
	self assert: game hasEnded
]

{ #category : #tests }
GameTest >> testGameFull [
	| players cards effects endPosition board die game overload speed proportions acceleration repeat |
	die := Die of: 6.
	endPosition := 20.
	players := {'Jorge' . 'Pedro' . 'Joaco'}.
	effects := { NoEffect new.
	SpeedUp new.
	WormHole new.
	MoonWalk substracting: 2.
	AtomicBomb new.
	Croupier new
	}.
	proportions := {38 . 20 . 20 . 10 . 2 . 10}.
	board := Board with: effects and: proportions sized: endPosition.
	overload := Overload new.
	speed := Speed new.
	acceleration := Acceleration new.
	repeat := Repeat new.
	cards := {overload.
	speed.
	acceleration.
	repeat}.
	game := Game
		playedBy: players
		rolling: die
		playingRandom: cards
		until: endPosition
		andLap: 2
		on: board.
	[ game hasEnded ]
		whileFalse: [ game playATurn.
			game playACard ].
	self assert: game hasEnded
]

{ #category : #tests }
GameTest >> testMoonWalk [
	| game players die board endPosition effects overload cards |
	die := Die of: 6 rolling: #(5 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {MoonWalk substracting:2}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := { overload }.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	self assert: (game positionOf:'Pedro') equals:6.
	self assert: (game positionOf:'Juan') equals:1.
	self assert: (game positionOf:'Jorge') equals:1.
]

{ #category : #tests }
GameTest >> testNoEffect [
	| game players die board endPosition effects overload cards |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := { overload }.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	self assert: (game positionOf:'Pedro') equals:5.
]

{ #category : #tests }
GameTest >> testOverload [
	| game players die board endPosition effects cards overload |
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := {overload}.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	overload applyUsing:game on:'Juan'.
	game playATurn.
	game playATurn.
	self assert: (game positionOf: 'Juan') equals: 4
]

{ #category : #tests }
GameTest >> testPlayersPositions [
	| game players die board endPosition effects overload cards |
	die := Die of: 6 rolling: #(1 6 1).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new.}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := { overload }.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	[ game hasEnded ] whileFalse: [ game playATurn ].
	self
		assert: game playerPositions
		equals: (OrderedCollection with: 'Juan' with: 'Pedro' with: 'Jorge')
]

{ #category : #tests }
GameTest >> testProportionsOfCardsInDeckAreCorrect [
	| handsTable players cards overloadCounter speedCounter cancellationCounter accelerationCounter repeatCounter proportions |
	overloadCounter := 0.
	speedCounter := 0.
	accelerationCounter := 0.
	cancellationCounter := 0.
	repeatCounter := 0.
	players := {'Jorge' . 'Pedro'}.
	cards := {Overload new.
	Speed new.
	Acceleration new.
	Cancellation new.
	Repeat new}.
	proportions := {38 . 20 . 20 . 10 . 12}.
	25000
		timesRepeat: [ handsTable := HandsTable
				generateRandomWith: players
				and: (Deck with: cards and: proportions sized: 5).
			overloadCounter := overloadCounter + (handsTable count: Overload).
			speedCounter := speedCounter + (handsTable count: Speed).
			accelerationCounter := accelerationCounter
				+ (handsTable count: Acceleration).
			cancellationCounter := cancellationCounter
				+ (handsTable count: Cancellation).
			repeatCounter := repeatCounter + (handsTable count: Repeat) ].
	self
		assert: (overloadCounter / 100000 * 100) rounded
		equals: 38.
	self
		assert: (speedCounter / 100000 * 100) rounded
		equals: 20.
	self
		assert: (accelerationCounter / 100000 * 100) rounded
		equals: 20.
	self
		assert: (cancellationCounter / 100000 * 100) rounded
		equals: 10.
		self
		assert: (repeatCounter / 100000 * 100) rounded
		equals: 12.
]

{ #category : #tests }
GameTest >> testProportionsOfEffectsAreCorrect [
	| endPosition board effects proportions noEffectsCounter speedUpCounter wormHoleCounter moonWalkCounter atomicBombCounter croupierCounter |
	endPosition := 20.
	noEffectsCounter := 0.
	speedUpCounter := 0.
	moonWalkCounter := 0.
	wormHoleCounter := 0.
	atomicBombCounter := 0.
	croupierCounter := 0.
	effects := {NoEffect new.
	SpeedUp new.
	WormHole new.
	(MoonWalk substracting: 3).
	AtomicBomb new.
	Croupier new}.
	proportions := {38 . 20 . 20 . 10 . 2 . 10}.
	2000
		timesRepeat: [ board := Board with: effects and: proportions sized: endPosition.
			noEffectsCounter := noEffectsCounter + (board count: NoEffect).
			speedUpCounter := speedUpCounter + (board count: SpeedUp).
			wormHoleCounter := wormHoleCounter + (board count: WormHole).
			moonWalkCounter := moonWalkCounter + (board count: MoonWalk).
			atomicBombCounter := atomicBombCounter + (board count: AtomicBomb).
			croupierCounter := croupierCounter + (board count: Croupier) ].
	self assert: (noEffectsCounter / 40000*100) rounded equals: 38.
	self assert: (speedUpCounter / 40000*100) rounded equals: 20.
	self assert: (wormHoleCounter / 40000*100) rounded equals: 20.
	self assert: (moonWalkCounter / 40000*100) rounded equals: 10.
	self assert: (atomicBombCounter / 40000*100) rounded equals: 2.
	self assert: (croupierCounter / 40000*100) rounded equals: 10
]

{ #category : #tests }
GameTest >> testRandomCardsDelivery [
	| handsTable players cards overloadCounter speedCounter cancellationCounter accelerationCounter repeatCounter proportions |
	overloadCounter := 0.
	speedCounter := 0.
	accelerationCounter := 0.
	cancellationCounter := 0.
	repeatCounter := 0.
	players := {'Jorge' . 'Pedro'}.
	cards := {Overload new.
	Speed new.
	Acceleration new.
	Cancellation new.
	Repeat new}.
	proportions := {20 . 20 . 20 . 20 . 20 }.
	25000
		timesRepeat: [ handsTable := HandsTable
				generateRandomWith: players
				and: (Deck with:cards and:proportions sized:5).
			overloadCounter := overloadCounter + (handsTable count: Overload).
			speedCounter := speedCounter + (handsTable count: Speed).
			accelerationCounter := accelerationCounter
				+ (handsTable count: Acceleration).
			cancellationCounter := cancellationCounter
				+ (handsTable count: Cancellation).
			repeatCounter := repeatCounter + (handsTable count: Repeat) ].
	self
		assert: (overloadCounter / 100000 * 100) rounded
		equals: (speedCounter / 100000 * 100) rounded.
	self
		assert: (overloadCounter / 100000 * 100) rounded
		equals: (accelerationCounter / 100000 * 100) rounded.
	self
		assert: (overloadCounter / 100000 * 100) rounded
		equals: (cancellationCounter / 100000 * 100) rounded.
	self
		assert: (overloadCounter / 100000 * 100) rounded
		equals: (repeatCounter / 100000 * 100) rounded
]

{ #category : #tests }
GameTest >> testRandomCroupier [
	| players cards overloadCounter speedCounter cancellationCounter accelerationCounter repeatCounter effects endPosition board die game overload speed |
	die := Die of: 6 rolling: #(5 5 6).
	endPosition := 10.
	overloadCounter := 0.
	speedCounter := 0.
	accelerationCounter := 0.
	cancellationCounter := 0.
	repeatCounter := 0.
	players := {'Jorge'}.
	effects := {SpeedUp new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	speed := Speed new.
	cards := {overload.
	speed.
	Acceleration new.
	Repeat new}.
	game := Game
		playedBy: players
		rolling: die
		playingRandom: cards
		until: endPosition
		andLap: 2
		on: board.
	game removeCardsFrom: 'Jorge'.
	100000 timesRepeat: [ game applyCroupierTo: 'Jorge'. game playACard].
	overloadCounter := game count: Overload.
	speedCounter := game count: Speed.
	accelerationCounter := game count: Acceleration.
	cancellationCounter := game count: Cancellation.
	repeatCounter := game count: Repeat.
	self
		assert: (overloadCounter / 100000 * 100) rounded
		equals: (speedCounter / 100000 * 100) rounded.
	self
		assert: (overloadCounter / 100000 * 100) rounded
		equals: (accelerationCounter / 100000 * 100) rounded.
	self
		assert: (overloadCounter / 100000 * 100) rounded
		equals: (repeatCounter / 100000 * 100) rounded
]

{ #category : #tests }
GameTest >> testRedoOnAcceleration [
	| game players die board endPosition effects cards redo acceleration |
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 30.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	redo := Redo new.
	acceleration := Acceleration new.
	cards := {acceleration.
	redo}.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	acceleration applyUsing: game.
	redo applyUsing: game onCard:nil onPlayer:'Pedro'.
	game playATurn.
	self assert: (game positionOf: 'Pedro') equals: 8
]

{ #category : #tests }
GameTest >> testRedoOnCancellation [
	| game players die board endPosition effects cards redo speed cancellation |
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 30.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	redo := Redo new.
	speed := Speed new.
	cancellation := Cancellation new.
	cards := {speed.
	redo.
	cancellation}.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	game applyPermanent: speed on: 'Pedro'.
	game playATurn.
	self assert: (game positionOf: 'Pedro') equals: 7.
	game applyPermanent: speed on: 'Juan'.
	cancellation applyUsing: game onCard: speed onPlayer:'Pedro'.
	game playATurn.
	redo applyUsing: game onCard: speed onPlayer:'Juan'.
	game playATurn.
	game playATurn.
	self assert: (game positionOf: 'Pedro') equals: 12
]

{ #category : #tests }
GameTest >> testRedoOnOverload [
	| game players die board endPosition effects cards redo overload |
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 30.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	redo := Redo new.
	overload := Overload new.
	cards := {overload.
	redo}.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	overload applyUsing: game on: 'Pedro'.
	redo applyUsing: game onCard:nil onPlayer:'Pedro'.
	game playATurn.
	self assert: (game positionOf: 'Pedro') equals: 2
]

{ #category : #tests }
GameTest >> testRedoOnRepeat [
	| game players die board endPosition effects cards redo repeat |
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 30.
	effects := {SpeedUp new}.
	board := Board generateWith: effects sized: endPosition.
	redo := Redo new.
	repeat := Repeat new.
	cards := {repeat.
	redo}.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	repeat applyUsing: game.
	redo applyUsing: game onCard:nil onPlayer:nil. 
	self assert: (game positionOf: 'Pedro') equals: 18
]

{ #category : #tests }
GameTest >> testRedoOnSpeed [
	| game players die board endPosition effects cards redo speed |
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 30.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	redo := Redo new.
	speed := Speed new.
	cards := {speed.
	redo}.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	speed applyUsing: game on: 'Pedro'.
	redo applyUsing: game onCard:nil onPlayer:'Pedro'.
	game playATurn.
	self assert: (game positionOf: 'Pedro') equals: 8
]

{ #category : #tests }
GameTest >> testRepeat [
	| game players die board endPosition effects cards repeat |
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 30.
	effects := {SpeedUp new}.
	board := Board generateWith: effects sized: endPosition.
	repeat := Repeat new.
	cards := {repeat}.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	self assert: (game positionOf: 'Pedro') equals: 10.
	repeat applyUsing: game.
	self assert: (game positionOf: 'Pedro') equals: 14
]

{ #category : #tests }
GameTest >> testSpeed [
	| game players die board endPosition effects cards speed |
	die := Die of: 6 rolling: #(5 5 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	speed := Speed new.
	cards := {speed}.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	speed applyUsing: game on: 'Juan'.
	game playATurn.
	game playATurn.
	self assert: (game positionOf: 'Juan') equals: 7
]

{ #category : #tests }
GameTest >> testSpeedUp [
	| game players die board endPosition effects overload cards |
	die := Die of: 6 rolling: #(4 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {SpeedUp new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := { overload }.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	self assert: (game positionOf:'Pedro') equals:9.
]

{ #category : #tests }
GameTest >> testWinnerExists [
	| game players die board endPosition effects overload cards |
	die := Die of: 6 rolling: #(1 1 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {NoEffect new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := {overload}.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	[ game hasEnded ] whileFalse: [ game playATurn ].
	self assert: game winner equals: 'Jorge'
]

{ #category : #tests }
GameTest >> testWormHole [
	| game players die board endPosition effects overload cards |
	die := Die of: 6 rolling: #(5 4 6).
	players := #('Pedro' 'Juan' 'Jorge').
	endPosition := 10.
	effects := {WormHole new}.
	board := Board generateWith: effects sized: endPosition.
	overload := Overload new.
	cards := { overload }.
	game := Game
		playedBy: players
		rolling: die
		playing: cards
		until: endPosition
		andLap: 2
		on: board.
	game playATurn.
	self assert: (game positionOf:'Pedro') equals:2.
]
