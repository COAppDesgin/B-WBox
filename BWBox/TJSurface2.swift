//
//  TJSurface2.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 7/6/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import SpriteKit

class TJSurface2 : SKSpriteNode {
    
    let SURFACE_WIDTH: CGFloat = CGFloat(arc4random_uniform(201) + 400)
    let SURFACE_HEIGHT: CGFloat = kTJGroundHeight
    let COLOR_ONE = UIColor(red: 159/255, green: 201/255, blue: 244/255, alpha: 1)
    let COLOR_TWO = UIColor(red: 45/255, green: 86/255, blue: 130/255, alpha: 1)
    
    init() {
        let size = CGSize(width: SURFACE_WIDTH, height: SURFACE_HEIGHT)
        
        let rand = arc4random_uniform(2)
        var segmentColor: UIColor!
        
        if rand == 0 {
            segmentColor = COLOR_ONE
        } else {
            segmentColor = COLOR_TWO
        }
        
        super.init(texture: nil, color: segmentColor, size: CGSize(width: SURFACE_WIDTH, height: SURFACE_HEIGHT))
        
        loadPhysicsBodyWithSize(size: size)
        startMoving()
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = BodyType.ground.rawValue
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
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
