Class {
	#name : #Speed,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Speed >> effect [
	^ 1
]

{ #category : #removing }
Speed >> removeYourselfOf: player using: game [
	game remove: self to: player
]
