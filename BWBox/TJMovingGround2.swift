//
//  TJMovingGround2.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 7/3/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import SpriteKit

class TJMovingGround2: SKSpriteNode {
    
    let NUMBER_OF_SEGMENTS = 20
    let COLOR_ONE = UIColor(red: 159/255, green: 201/255, blue: 244/255, alpha: 1)
    let COLOR_TWO = UIColor(red: 45/255, green: 86/255, blue: 130/255, alpha: 1)
    
    init(size: CGSize){
        super.init(texture: nil, color:UIColor.brown, size: CGSize(width: size.width*2, height: kTJGroundHeight))
        loadPhysicsBodyWithSize(size: CGSize(width: size.width*2, height: kTJGroundHeight))
        
        anchorPoint = CGPoint(x: 0, y: 100)
        
        for i in 0 ..< NUMBER_OF_SEGMENTS {
            var segmentColor: UIColor!
            if i % 2 == 0 {
                segmentColor = COLOR_ONE
            } else {
                segmentColor = COLOR_TWO
            }
            
            let segment = SKSpriteNode(color: segmentColor, size: CGSize(width: self.size.width/CGFloat(NUMBER_OF_SEGMENTS), height: self.size.height))
            segment.anchorPoint = CGPoint(x: 0, y: 0.5)
            segment.position = CGPoint(x: CGFloat(i)*segment.size.width, y: 0)
            addChild(segment)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been initialized")
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width*2, height: kTJGroundHeight))
        physicsBody?.contactTestBitMask = ground2Category
        physicsBody?.affectedByGravity = false
    }
    
    func start() {
        
        let adjustedDuration = TimeInterval(frame.size.width / kDefaultXToMovePerSecond)
        
        let moveLeft = SKAction.moveBy(x: -frame.size.width/2, y: 0, duration: TimeInterval(adjustedDuration/2))
        
        let resetPosition = SKAction.moveTo(x: 0, duration: 0)
        let moveSequence = SKAction.sequence([moveLeft, resetPosition])
        
        run(SKAction.repeatForever(moveSequence))
    }
    
    func stop() {
        removeAllActions()
    }
    
}
