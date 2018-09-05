//
//  ViewController.swift
//  Program_one
//
//  Created by Nulrybek Karshyga on 27.05.18.
//  Copyright © 2018 Nulrybek Karshyga. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1)/2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
        
    }
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount+game.score)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card is not in the array")
        }
        
    }
    
    private  func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for:card,theme: &theme), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    
    
    @IBAction func newGameStarter(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        flipCount = 0
        updateViewFromModel()
    }
    
    
    
    @IBOutlet weak var gameTheme: UISegmentedControl!
    var theme = [String]()

    @IBAction func gameThemeChanger(_ sender: UISegmentedControl) {
        switch gameTheme.selectedSegmentIndex {
        case 0: theme = helloweenTheme
        case 1: theme = nightTheme
        case 2: theme = smilingTheme
        case 3: theme = machineTheme
        default: break
        }
    }
    
    var helloweenTheme = ["💀","👽","👺","🤡","🐊","🦅","👹","😈","🤖","🎃","🕺"]
    var nightTheme = ["🌠","🌄","🌇","🎆","🌌","🔮","🌚","🌘","🌛","💥","⭐️"]
    var smilingTheme = ["😀","😁","😆","🤣","🤩","🙃","😍","😇","😝","🤪","🤓"]
    var machineTheme = ["🤖","🚗","🚕","🚙","🚌","🏎","🚓","🚑","🚜","🚒","🚆"]
    
        
    
   
    private var emoji = Dictionary<Card, String>()
    
    private func emoji(for card : Card, theme: inout [String]) -> String{
        if emoji[card] == nil ,theme.count > 0 {
            emoji[card] = theme.remove(at: theme.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int{
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(-self)))
        }else{
            return 0
        }
    }
    
}

