//
//  TJBorder.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 7/12/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import SpriteKit

class TJBorder : SKSpriteNode {
    
    let WALL_WIDTH: CGFloat = 10
    let WALL_HEIGHT: CGFloat = 800
    
    init() {
        let size = CGSize(width: WALL_WIDTH, height: WALL_HEIGHT)
        super.init(texture: nil, color: UIColor.black, size: CGSize(width: WALL_WIDTH, height: WALL_HEIGHT))
        
        loadPhysicsBodyWithSize(size: size)
        self.position = CGPoint(x: 0, y: 0)
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = BodyType.border.rawValue
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        //self.physicsBody?.collisionBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
