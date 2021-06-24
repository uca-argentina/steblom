Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'size',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> discardDeck [
	^ self new initializeUsing: OrderedCollection new
]

{ #category : #'instance creation' }
Deck class >> generateRandomUsing: aDeck sized: size [
	| auxCards random |
	auxCards := OrderedCollection new.
	random := Random new.
	1 to: size do: [ :i | auxCards add: (aDeck at: (random nextInt: 100)) ].
	^ self new initializeUsing: auxCards
]

{ #category : #'instance creation' }
Deck class >> using: aSetOfCards [
	^self new initializeUsing: aSetOfCards
]

{ #category : #'instance creation' }
Deck class >> with: aSetOfCards and: proportions sized: size [
	| auxDeck |
	auxDeck := OrderedCollection new.
	aSetOfCards
		with: proportions
		do:
			[ :effect :proportion | 1 to: proportion do: [ :i | auxDeck add: effect ] ].
	^ self generateRandomUsing: auxDeck sized: size
]

{ #category : #getter }
Deck >> actualSize [
	^cards count:[:i|true]
]

{ #category : #adding }
Deck >> add: card [
	cards add: card
]

{ #category : #getter }
Deck >> cards [
	^ cards
]

{ #category : #initialization }
Deck >> initializeUsing: aSetOfCards [
	| length random |
	size := 10.
	length := aSetOfCards count: [ :i | true ].
	cards := OrderedCollection new.
	length > 0
		ifFalse: [ ^ self ].
	random := Random new.
	size
		timesRepeat: [ cards add: (aSetOfCards at: (random nextInt: length)) ]
]

{ #category : #'as yet unclassified' }
Deck >> isEmpty [
	| length |
	length := cards count: [ :i | true ].
	^ length = 0
]

{ #category : #removing }
Deck >> remove: card [
	cards remove: card
]

{ #category : #shuffling }
Deck >> shuffleUsing: discardDeck [
	| discardCards card |
	discardCards := discardDeck cards.
	[discardDeck isEmpty]
		whileFalse: [ card := Hand randomCardFrom: discardCards.
			discardDeck remove: card.
			cards add: card ]
]
