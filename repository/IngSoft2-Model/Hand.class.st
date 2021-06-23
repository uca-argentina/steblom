Class {
	#name : #Hand,
	#superclass : #Object,
	#instVars : [
		'owner',
		'ownedCards',
		'appliedCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #random }
Hand class >> randomCardFrom: cards [
	| length random |
	length := cards count: [ :i | true ].
	random := Random new.
	^ cards at: (random nextInt: length)
]

{ #category : #'instance creation' }
Hand class >> with: player and: cards [
	| ownedCards |
	ownedCards := OrderedCollection new.
	1 to: 2 do: [ :i | 
		ownedCards add: cards current.
		cards next ].
	^ self new initializeFor: player with: ownedCards
]

{ #category : #'instance creation' }
Hand class >> with: player andRandom: cards [
	| ownedCards |
	ownedCards := OrderedCollection new.
	1 to: 2 do: [ :i | 
		ownedCards add: (self randomCardFrom:cards) ].
	^ self new initializeFor: player with: ownedCards
]

{ #category : #accessing }
Hand >> apply: card [
	appliedCards add: card.
	
]

{ #category : #testing }
Hand >> areYouApplied: aCard [
	appliedCards
		detect: [ :card | card = aCard ]
		ifNone: [ Error signal: 'Player is not applied that card' ]
]

{ #category : #accessing }
Hand >> areYouFrom: player [
	^ player = owner
]

{ #category : #accessing }
Hand >> cardsEffect [
	| sum |
	sum := 0.
	appliedCards isEmpty
		ifFalse: [ appliedCards do: [ :card | sum := sum + card effect ] ].
	^ sum
]

{ #category : #accessing }
Hand >> count: aClass [
	| counter |
	counter := 0.
	ownedCards
		do: [ :card | 
			(card isMemberOf: aClass)
				ifTrue: [ counter := counter + 1 ] ].
	^ counter
]

{ #category : #testing }
Hand >> doYouOwn: aCard [
	ownedCards
		detect: [ :card | card = aCard ]
		ifNone: [ Error signal: 'Current player does not own that card' ]
]

{ #category : #accessing }
Hand >> give: card [
	ownedCards add: card
]

{ #category : #initialization }
Hand >> initializeFor: player with: aSetOfCards [
	owner := player.
	ownedCards := aSetOfCards.
	appliedCards := OrderedCollection new
]

{ #category : #getter }
Hand >> randomCard [
	| length random |
	length:= ownedCards count: [ :i | true ].
	random := Random new.
	^ownedCards at: (random nextInt: length)
]

{ #category : #removing }
Hand >> remove: acceleration [ 
	appliedCards remove: acceleration.
]

{ #category : #removing }
Hand >> removeAllCards [
	ownedCards := OrderedCollection new.
	appliedCards := OrderedCollection new.
]

{ #category : #removing }
Hand >> removeOwned: card [
	ownedCards remove: card
]
