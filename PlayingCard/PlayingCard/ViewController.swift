//
//  ViewController.swift
//  PlayingCard
//
//  Created by Павел on 6/30/20.
//  Copyright © 2020 Павел. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
   
    @IBOutlet weak var PlayingCardView: PlayingCardView!{
        didSet{
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            PlayingCardView.addGestureRecognizer(swipe)
            
            let pinch = UIPinchGestureRecognizer(target: PlayingCardView, action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGesture:)))
            PlayingCardView.addGestureRecognizer(pinch)
        }
    }
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state{
        case .ended: PlayingCardView.isFaceUp = !PlayingCardView.isFaceUp
        default: break
        }
    }
    
    @objc func nextCard(){
        if let card = deck.draw(){
            PlayingCardView.rank = card.rank.order
            print(card.rank.order)
            PlayingCardView.suit = card.suit.rawValue
            print(card.suit.rawValue)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }


}

