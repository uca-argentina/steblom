Class {
	#name : #Acceleration,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'applying card' }
Acceleration >> applyUsing: game [
	game applyOnAll:self.
]

{ #category : #accessing }
Acceleration >> effect [
	^ 1
]

{ #category : #removing }
Acceleration >> removeYourselfOf: player using: game [ 
	game remove: self.
]
