//
// Creature.swift
// Evolution simulator
//
// Created by Vlasto, Benedict (JDN) on 19/09/2020.
//

import Foundation

class Creature {

    // Trait value is an integer between 1 and 100 that represents how much of the trait being evolved a creature has, such as how fast/slow a creature is.
    var traitValue: Int

    // traitValue is not passed in when creatures are first initialised, but is passed in when creatures reproduce.
    // This is why traitValue is optional.
    init(traitValue: Int?) {
        if let creatureTraitValue = traitValue {
            self.traitValue = creatureTraitValue
        } else {
            self.traitValue = Int.random(in: 1...100)
            //self.traitValue = 90
        }
    }

    func reproduce() -> Creature {

        let mutationVariable = Int.random(in: -10...10)
        var childTraitValue = self.traitValue + mutationVariable

        // if statements handle the case of childTraitValue being outside bounds of 1...100
        if childTraitValue > 100 {
            childTraitValue = 200 - (mutationVariable + self.traitValue)
        } else if childTraitValue < 1 {
            childTraitValue = 2 - (mutationVariable + self.traitValue)
        }

        let newCreature = Creature(traitValue: childTraitValue)
        return newCreature

    }
    
}