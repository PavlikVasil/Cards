//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Павел on 6/30/20.
//  Copyright © 2020 Павел. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible{
    
    var suit: Suit
    var rank: Rank
    
    var description: String {return "\(rank) \(suit)"}
    
    enum Suit: String, CustomStringConvertible{
        
        case spades = "♠️"
        case hearts = "♥️"
        case diamonds = "♦️"
        case clubs = "♣️"
        
        static var all = [Suit.spades,.hearts,.diamonds,.clubs]
        
        var description: String{ return rawValue}
    }
    
    enum Rank: CustomStringConvertible{
        var description: String{
            switch self{
            case .ace: return "A"
            case .numeric(let pips): return String(pips)
            case .face(let kind): return kind
            }
        }
        
        case ace
        case face(String)
        case numeric(pipcount: Int)
        
        var order: Int{
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            
            for pips in 2...10{
                allRanks.append(Rank.numeric(pipcount: pips))
            }
            allRanks += [Rank.face("J"), .face("Q"), .face("K")]
            return allRanks
        }
    }
    
}
