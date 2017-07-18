//
//  TJWall.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 6/29/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import SpriteKit

class TJWall : SKSpriteNode {
    
    let WALL_WIDTH: CGFloat = 30
    let WALL_HEIGHT: CGFloat = CGFloat(arc4random_uniform(60) + 40)
    let WALL_COLOR = UIColor.init(red: 142/255, green: 40/255, blue: 0/255, alpha: 1)
    
    init() {
        let size = CGSize(width: WALL_WIDTH, height: WALL_HEIGHT)
        super.init(texture: nil, color: WALL_COLOR, size: CGSize(width: WALL_WIDTH, height: WALL_HEIGHT))
        
        loadPhysicsBodyWithSize(size: size)
        startMoving()
        
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = BodyType.wall.rawValue
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving() {
        let moveLeft = SKAction.moveBy(x: -kDefaultXToMovePerSecond, y: 0, duration: 1)
        run(SKAction.repeatForever(moveLeft))
    }
    
    func stopMoving() {
        removeAllActions()
    }
    
    
    
    
}
