class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        #spades: 0, diamonds: 1, clubs: 2, hearts: 3
        suit: Math.floor(card / 13)

  dealPlayer: -> new Hand [ @pop(), @pop() ], @

  dealDealer: -> new Hand [ @pop().flip(), @pop() ], @, true
