Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> test2PlayersPlay [
| die playerOne playerTwo players |
die := Die of: 6 rolling: #(6).
playerOne:=Player start.
playerTwo:=Player start.
players:=playerOne + playerTwo.
players play:die.
self assert: (playerOne getPos ~= 0 ).
self assert: (playerTwo getPos ~= 0 )
]

{ #category : #tests }
GameTest >> test2PlayersPlay1ReachesEnd [
| die playerOne playerTwo players endPos|
endPos:=5.
die := Die of: 6 rolling: #(6).
playerOne:=Player start.
playerTwo:=Player start.
players:=playerOne + playerTwo.
players play:die.
self assert: ((playerOne getPos >endPos) or:(playerTwo getPos > endPos )) .

]

{ #category : #tests }
GameTest >> test2PlayersRollDiceRepeatedly [
| die playerOne playerTwo players endPos game|
endPos:=11.
die := Die of: 6 rolling: #(6 1 6 1).
playerOne:=Player start.
playerTwo:=Player start.
players:=playerOne + playerTwo.
game:=Game withDie:die withEndPos:endPos withPlayers:players.
game play.
self assert: game checkIfEnded  .

]

{ #category : #tests }
GameTest >> testFinalPositions [
| die playerOne playerTwo players endPos game finalPositions|
endPos:=11.
die := Die of: 6 rolling: #(6 1 6 1).
playerOne:=Player start.
playerTwo:=Player start.
players:=playerOne + playerTwo.
game:=Game withDie:die withEndPos:endPos withPlayers:players.
game play.
finalPositions:=game getFinalPositions.
self assert: finalPositions equals:#(12 2).

]

{ #category : #tests }
GameTest >> testPlayerMove [
| result die player|
die := Die of: 6 rolling: #(6).
player:=Player start.
result:= player play:die.
self assert: result equals:6
]

{ #category : #tests }
GameTest >> testPlayerReachesEnd [
| result die player endPos|
endPos:=5.
die := Die of: 6 rolling: #(6).
player:=Player start.
result:= player play:die.
self assert: result>endPos
]

{ #category : #tests }
GameTest >> testWinner [
| die playerOne playerTwo players endPos game winner |
endPos:=11.
die := Die of: 6 rolling: #(6).
playerOne:=Player start.
playerTwo:=Player start.
players:=playerOne + playerTwo.
game:=Game withDie:die withEndPos:endPos withPlayers:players.
winner:=game play.
self assert: winner equals:playerOne.

]
