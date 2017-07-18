//
//  TJCloud.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 6/29/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import SpriteKit

class TJCloud: SKShapeNode {
    
    init(size: CGSize) {
        super.init()
        let path = CGPath(ellipseIn: CGRect(x:0, y:0, width: size.width, height: size.height), transform: nil)
        self.path = path
        fillColor = UIColor.white
        
        startMoving()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving() {
        let moveLeft = SKAction.moveBy(x: -10, y: 0, duration: 1)
        run(SKAction.repeatForever(moveLeft))
    }
    
}
