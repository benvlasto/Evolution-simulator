//
// Environment.swift
// Evolution simulator
//
// Created by Vlasto, Benedict (JDN) on 21/09/2020.
//

import Foundation

class Environment {

    // Reproductive chance is a double between 0 and 1 that represents the chance a creature will reproducee each generation. It is a constant per simulation.
    let reproductiveChance: Double

    // environmentColour is an integer in range 1...100. This is what the creatures' traitValues are compared against. If creature traitValue is very far from environmentColour, it is more likely to die.
    let environmentColour: Int

    // selectionPressure changes how punishing an environment is, and so how narrow/wide a creature distribution will be. Higher value of selection pressure gives narrower distribution.
    let selectionPressure: Double
    
    // Stores each generation of creatures during simulation
    var creatures: [Creature] = []
    
    // This is the array used in the summary screen to access the entire history of creatures. This allows every generation's distribution to be displayed in the summary screen bar chart.
    var populationHistory: [[Creature]] = []

    init(environmentColour: Int, reproductiveChance: Double, selectionPressure: Double, populationSize:
    Int) {
        self.environmentColour = environmentColour
        self.reproductiveChance = reproductiveChance
        self.selectionPressure = selectionPressure
        for _ in 1...populationSize {
        let creature = Creature(traitValue: nil)
            self.creatures.append(creature)
        }
        self.populationHistory.append(self.creatures)
    }

    func calculateCreaturesAdaptation(creature: Creature) -> Int {
        var difference = creature.traitValue - self.environmentColour
        if difference < 0 {
            difference = -difference
        }
        let adaptation = 100 - difference
        return adaptation
    }

    func calculateChanceOfDeath(creature: Creature) -> Double {
        let adaptation = Double(calculateCreaturesAdaptation(creature: creature))
        let dampingFactor = 0.2 * Double(self.creatures.count)
        let denominator = 1 + pow(2.71828, -self.selectionPressure * (adaptation - (80 + dampingFactor)))
        let chanceOfSurvival = 1/denominator
        return 1 - chanceOfSurvival
    }

    func advanceOneGeneration() -> String? {

        guard self.creatures.count > 0 else {
            return "extinct"
        }

        // Killing creatures
        var tempArray: [Creature] = []
        for i in 0 ..< self.creatures.count {
            let fraction = Double.random(in: 0...1)
            let chanceOfDeath = calculateChanceOfDeath(creature: self.creatures[i])
            if fraction > chanceOfDeath { // then keep creature alive
                tempArray.append(self.creatures[i])
            }
        }
        self.creatures = tempArray

        guard self.creatures.count > 0 else {
            return "extinct"
        }

        // Reproducing creatures
        for creature in self.creatures {
            let fraction = Double.random(in: 0...1)
            if fraction < self.reproductiveChance {
                self.creatures.append(creature.reproduce())
            }
        }

        self.populationHistory.append(self.creatures)
        return nil

    }
    
}