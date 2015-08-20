# Coniecto (Guess) game

Multiplayer guess the number.

## Why is this a thing?

After reading Sandi Metz's book on OO design, I threw this game together as a toy project.

The point was that there was no preconcieved idea in order to see how the approach of small objects and depenency management would handle constant change (as I worked out how it would work along the way).

Turns out it was flexible and great fun.


## Have a quick try

First make sure you have and are running with Ruby 2.2.0 available.

Then simply start irb and it will kick off an example game.

```
$ irb
```

## How to win?

You can win in three ways which are mutually exclusive in this order:

1. By guessing the number exactly right
2. By guessing a number within your margin, this is determined by your rank (see ranks below)
3. By simply being the player who guessed the closest to the number overall

## Make your own

Customise your own game by specifying the following:

`players` The humans involved and ready to play

`limit` The maximum guessable number


Don't worry if you're on your own, it will auto populate bots who you can play against!

```
$   game = Game.new(
      players: [
        Human.new(name: "Tom", rank: 1),
        Human.new(name: "Mark", rank: 2)
      ],
      limit: 125
    )

    game.play
```

## Ranks

Specifying a rank for a player (1-5) defines how much margin of error your guess can be to succeed.

If you guess 100 with a rank 3, guessing anywhere inbetween 70-130 will score.
