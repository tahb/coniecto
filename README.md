# Wat?

After reading into some different approaches to OO design, I threw this game together without a preconcieved idea just to see how the approach of small objects and depenency management would handle constant change.

Turns out it was, great fun.

(Certainly some areas I didn't manage to finish!)

## Have a try

```
$ irb
```

To play a quick game
```
$ GameMaster.example
```

Customise your own game by specifying the players involved and the maximum guessable number.

Don't worry if you're on your own, you can play against a bot!

```
$ GameMaster.new(players: [Player.new], limit: 125)
```

## Ranks

Specifying a rank 1-5 defines how much margin of error your guess can be to succeed.

If you guess 100 with a rank 3, guessing anywhere inbetween 70-130 will score.