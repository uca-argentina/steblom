Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> with: effect andSize: size [
	^self new initializeWith:effect andSize:size.
]

{ #category : #accessing }
Board >> effect: anInteger [ 
	^tiles at:anInteger
]

{ #category : #initialization }
Board >> initializeWith: effect andSize: size [
	tiles:=OrderedCollection new.
	1 to: size do:[:i | tiles add:effect]
]
