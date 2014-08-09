#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bust', =>
      @determineWinner()

    @get('dealerHand').on 'determineWinner', =>
      @determineWinner()

    @get('playerHand').on 'stand', =>
      @get('dealerHand').initDealer()

  determineWinner: ->
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()

    if playerScore > dealerScore
      alert 'you won'
    else
      alert 'dealer won'




