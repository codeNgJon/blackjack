class window.Hand extends Backbone.Collection

  model: Card
              #hand   #whichDeck #boolean for dealer
  initialize: (array, @deck, @isDealer) ->

  hit: ->
    # if @bestScore() <= 21
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


  bestScore: ->
    currentScore = 0
    scoresArray = @scores()
    if scoresArray[0] > currentScore
      currentScore = scoresArray[0]
    # if scoresArray.length is 2 and
    if scoresArray[1] and scoresArray[1] <= 21
      currentScore = scoresArray[1]
    return currentScore

  checkIfPlayerLost: (x) ->
    if x > 21 then @bust()

  bust: ->
    @trigger 'bust', @

  initDealer: ->
    @models[0].flip()
    while @bestScore() <= 17
      @hit()
    if @bestScore() <= 21
      @trigger 'determineWinner'
    else
      @bust()



    # # get the dealer
    # # while score i less than 17
    #   # hit yourself
