//
//  CardsViewController.swift
//  PlayingCard
//
//  Created by Павел on 7/1/20.
//  Copyright © 2020 Павел. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    private var deck = PlayingCardDeck()
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        var cards = [PlayingCard]()
        for _ in 1...(((cardViews.count+1)/2)){
            let card = deck.draw()!
            cards += [card, card]
        }
        for cardView in cardViews{
            cardView.isFaceUp = false
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
            cardBehavior.addItem(cardView)
            
        }
    }
    

    @IBOutlet private var cardViews: [PlayingCardView]!
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    lazy var cardBehavior = CardsBehavior(in: animator)
    
    
    private var faceUpCardViews: [PlayingCardView] {
        return cardViews.filter {$0.isFaceUp && !$0.isHidden}
    }
    
    private var faceUpCardViewsMatched: Bool{
        return faceUpCardViews.count == 2 && faceUpCardViews[0].rank == faceUpCardViews[1].rank && faceUpCardViews[0].suit == faceUpCardViews[1].suit
          
    }
    
    @objc func flipCard(_ recognizer: UITapGestureRecognizer){
        switch recognizer.state{
        case .ended:
            if let chosenCardView = recognizer.view as? PlayingCardView{
                cardBehavior.removeItem(chosenCardView)
                UIView.transition(with: chosenCardView,
                                  duration: 0.5,
                                  options: [.transitionFlipFromLeft],
                                  animations: {
                    chosenCardView.isFaceUp = !chosenCardView.isFaceUp
                },
                    completion: { finished in
                        if self.faceUpCardViewsMatched {
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: 0.5,
                                delay: 0,
                                options: [],
                                animations: {
                                    self.faceUpCardViews.forEach{
                                        $0.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
                                    }
                            },
                                completion: {position in
                                    UIViewPropertyAnimator.runningPropertyAnimator(
                                        withDuration: 0.5,
                                        delay: 0,
                                        options: [],
                                        animations: {
                                             self.faceUpCardViews.forEach{
                                                $0.isHidden = true
                                                $0.alpha = 1
                                                $0.transform = .identity
                                                                               }
                                    },
                                     completion: {position in
                                        self.faceUpCardViews.forEach{
                                            $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                            $0.alpha = 0
                                        }
                                        }
                                    )
                            }
                            )
                        } else
                        if self.faceUpCardViews.count == 2{
                            self.faceUpCardViews.forEach { cardView in
                                UIView.transition(with: cardView,
                                                  duration: 0.5,
                                                  options: [.transitionFlipFromLeft],
                                                  animations: {
                                    cardView.isFaceUp = false
                                },
                                                  completion: { finished in
                                                    self.cardBehavior.addItem(cardView)
                                }
                                )
                        }
                        } else {
                            if !chosenCardView.isFaceUp{
                                self.cardBehavior.addItem(chosenCardView)
                            }
                        }
                }
             )
            }
        default: break
        }
    }
    

}

extension CGFloat {
    var arc4random: CGFloat {
        return self * (CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max))
    }
}
