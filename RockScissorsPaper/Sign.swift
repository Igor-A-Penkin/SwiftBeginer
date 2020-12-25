//
//  Sign.swift
//  RockScissorsPaper
//
//  Created by Игорь Пенкин on 18.09.2020.
//  Copyright © 2020 Igor-A-Penkin. All rights reserved.
//

import Foundation
import GameplayKit

let randomChoice = GKRandomDistribution(lowestValue: 0, highestValue: 2)

func randomSign() -> Sign {
    let sign = randomChoice.nextInt()
    if sign == 0 {
        return .rock
    } else if sign == 1 {
        return .paper
    } else {
        return .scissors
    }
}

enum Sign {
    case rock
    case paper
    case scissors
    
    var emoji: String {
        switch self {
        case .paper:
            return "📄"
        case .rock:
            return "💎"
        case .scissors:
            return "✂️"
        }
    }
    
    func getResult(for oposite: Sign) -> GameState {
        switch (self, oposite) {
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            return .win
        case (.scissors, .rock), (.rock, .paper), (.paper, .scissors):
            return .lose
        default:
            return .draw
        }
    }
}
