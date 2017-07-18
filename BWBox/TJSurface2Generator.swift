//
//  TJSurface2Generator.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 7/6/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import SpriteKit

class TJSurface2Generator: SKSpriteNode {
    
    var generationTimer: Timer?
    var surfaces2 = [TJSurface]()
    var surface2Trackers = [TJSurface]()
    
    
    func startGeneratingSurface(seconds: TimeInterval){
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(TJSurface2Generator.generateSurface), userInfo: nil, repeats: true)
    }
    
    func stopGenerating() {
        generationTimer?.invalidate()
    }
    
    func generateSurface() {
        
        if randSurface == 0 {
            scaleSurface = -1
        } else {
            scaleSurface = 1
        }
        
        let surface2 = TJSurface()
        surface2.position.x = size.width/2 + surface2.size.width/2
        surface2.position.y = scaleSurface * (kTJGroundHeight/2 + surface2.size.height/2 + CGFloat(arc4random_uniform(25) + 150))
        surfaces2.append(surface2)
        surface2Trackers.append(surface2)
        
        addChild(surface2)
    }
    
    func stopSurface() {
        stopGenerating()
        for surface2 in surfaces2 {
            surface2.stopMoving()
        }
    }
    
    
}
