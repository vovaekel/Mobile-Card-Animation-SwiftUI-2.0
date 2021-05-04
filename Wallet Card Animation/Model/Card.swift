//
//  Card.swift
//  Wallet Card Animation
//
//  Created by Владимир Калиниченко on 03.05.2021.
//

import SwiftUI

struct Card: Identifiable {
    
    var id = UUID().uuidString
    var cardHolder: String
    var cardNumber: String
    var cardValidity: String
    var cardImage: String
    
}

var cards = [

    Card(cardHolder: "IJUSTINE", cardNumber: "1234 8889 8273 0299", cardValidity: "21-09-2022", cardImage: "Card_9"),
    Card(cardHolder: "KAVYYA", cardNumber: "2932 3293 8902 2938", cardValidity: "22-07-2023", cardImage: "Card_8"),
    Card(cardHolder: "JENNA EZARIC", cardNumber: "1239 3484 3940 3492", cardValidity: "10-08-2021", cardImage: "Card_7"),
    Card(cardHolder: "Vova", cardNumber: "2389 2283 9090 2392", cardValidity: "23-09-2025", cardImage: "Card_9")

]
