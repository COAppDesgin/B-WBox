//
//  BoxBoy.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 6/28/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import SpriteKit
import Darwin

var isJumping = false

class TJBoxBoy: SKSpriteNode, SKPhysicsContactDelegate {
    
    var body: SKSpriteNode!
    var arm: SKSpriteNode!
    var rightFoot: SKSpriteNode!
    var leftFoot: SKSpriteNode!
    var isUpsideDown = false
    var physicsWorld = SKPhysicsWorld()


    init() {
        let size = CGSize(width: 32, height: 32)
        super.init(texture: nil, color: UIColor.clear, size:size)
        
        loadAppearance()
        addPhysicsWorld()
        loadPhysicsBodyWithSize(size: size)
        
    }
    
    func loadAppearance() {
        
        self.body = SKSpriteNode(color: UIColor.black, size: CGSize(width: 32, height: 32))
        body.position = CGPoint(x: 0, y: 0)
        addChild(body)
        }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        let guy: SKPhysicsBody = SKPhysicsBody(rectangleOf: size)
        guy.affectedByGravity = true
        guy.categoryBitMask = BodyType.hero.rawValue
        guy.contactTestBitMask = BodyType.ground.rawValue | BodyType.wall.rawValue | BodyType.surface.rawValue | BodyType.coin.rawValue | BodyType.border.rawValue
        guy.collisionBitMask = BodyType.surface.rawValue | BodyType.ground.rawValue
        
        self.physicsBody = guy
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flip() {
        
        isUpsideDown = !isUpsideDown
        
        var scale: CGFloat!
        if isUpsideDown {
            scale = -1
        } else {
            scale = 1
        }
        
        if isJumping == false {
            let translate = SKAction.moveBy(x: 0, y: scale*(size.height + kTJGroundHeight), duration: 0.1)
            let flip = SKAction.scaleY(to: scale, duration: 0.1)
            
            run(translate)
            run(flip)

        } else {}
    }
    
    func fall() {
        if isUpsideDown {
            physicsBody?.applyImpulse(CGVector(dx: -10, dy: -30))
        } else {
            physicsBody?.applyImpulse(CGVector(dx: -10, dy: 30))
        }
        
        let rotateBack = SKAction.rotate(byAngle: CGFloat(Double.pi)/2, duration: 0.4)
        run(rotateBack)
    }
    
    func breath() {
        
        let breathOut = SKAction.resize(byWidth: 10, height: 10, duration: 1)
        let breathIn = SKAction.resize(byWidth: -10, height: -10, duration: 1)
        let breath = SKAction.sequence([breathOut, breathIn])
        body.run(SKAction.repeatForever(breath))
        
    }
    
    func addPhysicsWorld() {
        //Add physics world
        
        physicsWorld.contactDelegate = self
    }
    
    func jump() {
        var scale: CGFloat!
        if isUpsideDown {
            scale = -1
        } else {
            scale = 1
        }
        if isJumping == false {
            physicsBody?.applyImpulse(CGVector(dx: 0, dy: scale*25))
            isJumping = true
            let rotateBack = SKAction.rotate(byAngle: -CGFloat(Double.pi)*2, duration: 0.45)
            self.run(rotateBack)
        } else {
        }
    }
    
    func stop() {
        body.removeAllActions()
    }
}















