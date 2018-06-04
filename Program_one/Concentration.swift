//
//  Concentration.swift
//  Program_one
//
//  Created by Nulrybek Karshyga on 31.05.18.
//  Copyright © 2018 Nulrybek Karshyga. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    
    func chooseCard(at index: Int)
    {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //Check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                //Either no cards or two cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    //Initializes new game with number that is quantity of cards in the game multiplied by two
    init(numberOfPairsOfCards: Int)
    {
        //Creates new card and another matching card with the same identifier number
        for _ in 0..<numberOfPairsOfCards
        {
            let card = Card()
            //Because Card is  a struct we can append matching card ot the cards array and by doing it create the copy
            //Structs get copied
            cards.append(card)
            cards.append(card)
        }
        //TODO: Shuffle the cards
        
        for _ in cards.indices{
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.append(cards.remove(at: randomIndex))
            
            
        }
    }
}
