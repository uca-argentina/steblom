Class {
	#name : #HandsTable,
	#superclass : #Object,
	#instVars : [
		'hands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HandsTable class >> generateRandomWithPlayers: players and: cards [
	| hands |
	hands := OrderedCollection new.
	players do: [ :player | hands add: (Hand with: player andRandom: cards) ].
	^ self new initializeWith: hands
]

{ #category : #'instance creation' }
HandsTable class >> withPlayers: players and: cards [
	| hands |
	hands := OrderedCollection new.
	players do: [ :player | hands add: (Hand with: player and: cards) ].
	^ self new initializeWith: hands
]

{ #category : #'applying card' }
HandsTable >> applyOnAll: acceleration [
	hands do: [ :hand | hand apply: acceleration ]
]

{ #category : #'applying card' }
HandsTable >> applyPermanent: card on: player [
	hands
		detect: [ :hand | hand areYou: player ]
		ifFound: [ :hand | hand apply: card ]
		ifNone: [ Error signal: 'Player does not exist' ]
]

{ #category : #testing }
HandsTable >> assert: player has: card [
	hands
		detect: [ :hand | hand areYou: player ]
		ifFound: [ :hand | hand doYouOwn: card ]
		ifNone: [ Error signal: 'Player does not exist' ]
]

{ #category : #testing }
HandsTable >> assert: card isAppliedTo: player [
		hands
		detect: [ :hand | hand areYou: player ]
		ifFound: [ :hand | hand areYouApplied: card ]
		ifNone: [ Error signal: 'Player does not exist' ]
]

{ #category : #testing }
HandsTable >> assertAccelerationIsApplied [
	self shouldBeImplemented.
]

{ #category : #accessing }
HandsTable >> cardsEffectFor: player [
	hands
		detect: [ :hand | hand areYou: player ]
		ifFound: [ :hand | ^ hand cardsEffect ]
		ifNone: [ Error signal: 'Player does not exist' ]
]

{ #category : #accessing }
HandsTable >> count: aClass [ 
	| counter |
	counter:= 0.
	hands do:[:hand | counter := counter +(hand count:aClass)].
	^ counter
]

{ #category : #accessing }
HandsTable >> giveCardTo: player with: cards [
	hands
		detect: [ :hand | hand areYou: player ]
		ifFound: [ :hand | hand give: (cards at: 1) ]
		ifNone: [ Error signal:'Player does not exist' ]
]

{ #category : #accessing }
HandsTable >> giveRandomCardTo: player with: cards [
	hands
		detect: [ :hand | hand areYou: player ]
		ifFound: [ :hand | hand give: (Hand randomCardFrom: cards) ]
		ifNone: [ Error signal:'Player does not exist' ]
]

{ #category : #initialization }
HandsTable >> initializeWith: aSetOfHands [
	hands := aSetOfHands
]

{ #category : #removing }
HandsTable >> remove: acceleration [ 
	hands do:[:hand | hand remove:acceleration]
]

{ #category : #removing }
HandsTable >> remove: card from: player [ 
	hands
		detect: [ :hand | hand areYou: player ]
		ifFound: [ :hand | hand removeOwned: card ]
		ifNone: [ Error signal: 'Player does not exist' ]
]

{ #category : #removing }
HandsTable >> remove: card to: player [
	hands
		detect: [ :hand | hand areYou: player ]
		ifFound: [ :hand | hand remove: card ]
		ifNone: [ Error signal: 'Player does not exist' ]
]
