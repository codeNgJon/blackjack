class window.Hand extends Backbone.Collection

  model: Card
              #hand   #whichDeck #boolean for dealer
  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()

  stand: ->
    #save score for player
    #hit for dealer
    @trigger 'stand', @

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]


  checkIfPlayerLost: (x) ->
    if x > 21 then @trigger 'bust', @

  initDealer: ->
    @hit() while @scores()[0] < 17
    if @scores()[0] < 21
      @trigger 'determineWinner'

    # get the dealer
    # while score is less than 17
      # hit yourself
