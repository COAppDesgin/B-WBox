//
//  BoxBoy.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 7/11/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import SpriteKit
import Darwin

class TJCoin: SKSpriteNode, SKPhysicsContactDelegate {
    
    var coin: SKSpriteNode!
    
    init() {
        let size = CGSize(width: 25, height: 25)
        super.init(texture: SKTexture(imageNamed: "coin.png"), color: UIColor.clear, size:size)
        
        load()
        self.loadPhysicsBodyWithSize(size: size)
        startMoving()
        bounce()
    }
    
    func load() {
        
        self.coin = SKSpriteNode(texture: SKTexture(imageNamed: "coin.png"), size: CGSize(width: 25, height: 25))
        coin.position = CGPoint(x: 0, y: 0)
        addChild(coin)
        
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        
        coin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 25, height: 25))
        coin.physicsBody!.affectedByGravity = false
        coin.physicsBody!.allowsRotation = false
        coin.physicsBody!.categoryBitMask = BodyType.coin.rawValue
        coin.physicsBody!.collisionBitMask = 0
    
    }
    
    func bounce() {
        
        let moveUp = SKAction.moveBy(x: 0, y: scaleSurface * 25, duration: 0.5)
        let resetPosition = SKAction.moveBy(x: 0, y: scaleSurface * -25, duration: 0.5)
        let moveSequence = SKAction.sequence([moveUp, resetPosition])
        
        coin.run(SKAction.repeatForever(moveSequence))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving() {
        let moveLeft = SKAction.moveBy(x: -kDefaultXToMovePerSecond, y: 0, duration: 1)
        coin.run(SKAction.repeatForever(moveLeft), withKey: "move")
    }
    
    func stopMoving() {
        coin.removeAction(forKey: "move")
    }
}
