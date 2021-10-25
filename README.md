# pong

This is pong, implemented in Haskell. I followed along with
[this](https://andrew.gibiansky.com/blog/haskell/haskell-gloss/) tutorial, but I
also did a lot of my own work on it, so I'm keeping it around.

It uses the [gloss](https://hackage.haskell.org/package/gloss-1.13.2.1) graphics
package, which was half my motivation for doing it.

## Installation

To run, do the following:

```sh
stack build # This one might take a while on the first go
stack exec pong # Run the app
stack install pong # Optional: install the app so it's available
everywhere
```

## TODO

- [ ] Move more magic constants to the Configuration file.
- [ ] Make the paddles unable to overlap with the walls at the top and bottom
- [ ] Put comments places
