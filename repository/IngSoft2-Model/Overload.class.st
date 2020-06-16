Class {
	#name : #Overload,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Overload >> effect [
	^ -2
]

{ #category : #removing }
Overload >> removeYourselfOf: player using: game [
	game remove: self to: player
]
