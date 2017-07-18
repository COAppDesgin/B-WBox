//
//  TJWallGenerator.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 6/29/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import SpriteKit

class TJWallGenerator: SKSpriteNode {
    
    var generationTimer: Timer?
    var walls = [TJWall]()
    var wallTrackers = [TJWall]()
    
    func startGeneratingWalls(seconds: TimeInterval){
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(TJWallGenerator.generateWall), userInfo: nil, repeats: true)
    }
    
    func stopGenerating() {
        generationTimer?.invalidate()
    }
    
    func generateWall() {
        
        var scale: CGFloat
        let rand = arc4random_uniform(2)
        if rand == 0 {
            scale = -1
        } else {
            scale = 1
        }
        
        let wall = TJWall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale * (kTJGroundHeight/2 + wall.size.height/2)
        walls.append(wall)
        wallTrackers.append(wall)
        
        addChild(wall)
    }
    
    func stopWalls() {
        stopGenerating()
        for wall in walls {
            wall.stopMoving()
        }
    }
    
    
}
