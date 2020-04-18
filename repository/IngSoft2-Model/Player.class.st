Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'pos'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Player class >> start [
	^self new initializeWithPos
]

{ #category : #composing }
Player >> + aPlayer [ 
	^Players new initializeWith:{self.aPlayer}
]

{ #category : #boolean }
Player >> checkPosition: anEndPos [ 
	^(pos>anEndPos)
]

{ #category : #getter }
Player >> getPos [
	^pos
]

{ #category : #initialization }
Player >> initializeWithPos [
	pos:=0
]

{ #category : #playing }
Player >> play: aDie [ 
	pos:=pos+(aDie roll).
	^pos
]
