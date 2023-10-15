//
// AnimationScene.swift
// Evolution simulator
//
// Created by Vlasto, Benedict (JDN) on 16/11/2020.
//

// This class controls what is displayed in the simulation page animation

import UIKit
import SpriteKit

class AnimationScene: SKScene {

    var environment: Environment?
    var borders: [SKShapeNode] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // This initialiser is called if a CGSize is provided in the AnimationScene call, which it always is
    override init(size: CGSize) {
        super.init(size: size)
    }

    func setBackgroundColour() {
        let colour = CGFloat(Double(environment!.environmentColour)/100)
        //backgroundColor = UIColor(red: 0.961, green: 0.784-0.259*colour, blue: 0.259, alpha: 1)
        backgroundColor = UIColor(red: colour, green: colour, blue: colour, alpha: 1)
    }

    func placeCreatures() {
        borders = []
        for child in children {
            child.removeFromParent()
        }
        for creature in environment!.creatures {
            let sprite = SKSpriteNode(color: colourSprite(creature: creature), size: CGSize(width: 20,
            height: 20))
            sprite.position = randomSpritePosition()
            addChild(sprite)
            drawBorder(position: sprite.position, creature: creature)
        }
    }

    func randomSpritePosition() -> CGPoint {
        let xPos = CGFloat(arc4random_uniform(UInt32(self.size.width - 20))) + 10
        let yPos = CGFloat(arc4random_uniform(UInt32(self.size.height - 20))) + 10
        return CGPoint(x: xPos, y: yPos)
    }
    
    func colourSprite(creature: Creature) -> UIColor {
        let colour = CGFloat(Double(creature.traitValue) / 100)
        //let colour = UIColor(red: 0.961, green: 0.784-0.259*colourValue, blue: 0.259, alpha: 1)
        let spriteColour = UIColor(red: colour, green: colour, blue: colour, alpha: 1)
        return spriteColour
    }
    
    func drawBorder(position: CGPoint, creature: Creature) {
        // Box around creature has same dimensions as creature
        let borderNode = SKShapeNode(rectOf: CGSize(width: 20, height: 20))
        // Box is centred on the creature
        borderNode.position = position
        156
        borderNode.fillColor = .clear
        borderNode.lineWidth = 2
        borderNode.strokeColor = .clear

        // checks if creature colour is within 1 of the environment background
        if -1...1 ~= creature.traitValue - environment!.environmentColour {
            borderNode.strokeColor = .red
        }

        addChild(borderNode)
        borders.append(borderNode)
    }
    
    func hideBorders() {
        for border in borders {
            border.isHidden = true
        }
    }
    
    func showBorders() {
        for border in borders {
            border.isHidden = false
        }
    }

}