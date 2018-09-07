//
//  Concentration.swift
//  Program_one
//
//  Created by Nulrybek Karshyga on 31.05.18.
//  Copyright © 2018 Nulrybek Karshyga. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    
    private(set) var flips = 0
    
    private(set) var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil {
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    mutating func chooseCard(at index: Int)
    {
        
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched && !cards[index].isFaceUp{
            flips += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //Check if cards match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }else if cards[index].hasBeenPicked == true || cards[matchIndex].hasBeenPicked == true {
                    score -= 1
                }
                
                cards[index].isFaceUp = true
                cards[matchIndex].hasBeenPicked = true
                cards[index].hasBeenPicked = true
                
            }else{
                //Either no cards or two cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func resetCards(){
        cards.removeAll()
    }
    
    //Initializes new game with number that is quantity of cards in the game multiplied by two
    init(numberOfPairsOfCards: Int)
    {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of ")
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
