Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Dice class >> withAll: aDiceSet [
	
	^ self new initializeWithAll: aDiceSet
]

{ #category : #composing }
Dice >> + aDie [

	^ Dice withAll: { self . aDie }
]

{ #category : #initialization }
Dice >> initializeWithAll: aDiceSet [
	
	dice := aDiceSet
]

{ #category : #rolling }
Dice >> roll [
	
	^ dice sumNumbers: #roll
]
