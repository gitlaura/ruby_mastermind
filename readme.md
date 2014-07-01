Mastermind
==========

## Table of Contents
 
* [Game Overview](#Overview)
* [How to Play](#Instructions)
* [Rules](#Rules)
* [About](#About)
 
## <a name="Overview"></a>Game Overview
Mastermind is a two-player code-breaking game where one player makes a secret code of four marbles from a set of six different colored marbles and another player tries to guess the code as quickly as possible. (Read more about the game [here][1].) 

I created this program to mimic the game. Either the user or the computer creates a secret Mastermind code and then the user or the computer tries to guess the correct code within 10 turns. 

## <a name="Instructions"></a>How to Play
This game can only be played in a terminal. First, fork this repository and clone your repo to your computer. Then enter this in your terminal

```$ ruby start.rb```
 
## <a name="Rules"></a>Rules

  - Player 1 (the user or the computer) selects any combination of 4 of the 6 possible colors: red, green, orange, yellow, blue, purple (e.g., 'RGOY', POOY', 'BGRB', or 'BGRP') to create a secret code
 
  - Player 2 (the user or the computer) will get one black peg for every correct color in a correct spot and one white peg for every correct color in an incorrect spot

  - Player 2 must guess the secret guess (or receive 4 black pegs) in less than 10 tries

## <a name="About"></a>About
Created by [@getLaura][2] as an exercise for [8th Light][3]'s Student Apprentice program.

[1]:http://en.wikipedia.org/wiki/Mastermind_(board_game)
[2]:http://twitter.com/getlaura
[3]:http://8thlight.com

    