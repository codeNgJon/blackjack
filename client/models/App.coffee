#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bust', =>
      @bust()

    @get('dealerHand').on 'determineWinner', =>
      @determineWinner()

    @get('dealerHand').on 'bust', =>
      @dealerBust()

    @get('playerHand').on 'stand', =>
      @get('dealerHand').initDealer()


  determineWinner: ->
    playerScore = @get('playerHand').bestScore()
    dealerScore = @get('dealerHand').bestScore()
    if playerScore >= dealerScore
      alert 'you won'
    else
      alert 'dealer won'

  bust: ->
    alert 'you lost'

  dealerBust: ->
    alert 'dealer busted. you win'

## make winner a variable to cut down on how many outcome methods


