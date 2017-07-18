//
//  TJSurfaceGenerator.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 7/5/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import SpriteKit

var scaleSurface: CGFloat = 0
let randSurface = arc4random_uniform(2)


class TJSurfaceGenerator: SKSpriteNode {
    
    var generationTimer: Timer?
    var surfaces = [TJSurface]()
    var surfaceTrackers = [TJSurface]()
    
    func startGeneratingSurface(seconds: TimeInterval){
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(TJSurfaceGenerator.generateSurface), userInfo: nil, repeats: true)
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
        
        let surface = TJSurface()
        surface.position.x = size.width/2 + surface.size.width/2
        surface.position.y = scaleSurface * (kTJGroundHeight/2 + surface.size.height/2 + CGFloat(arc4random_uniform(25) + 50))
        surfaces.append(surface)
        surfaceTrackers.append(surface)
        
        addChild(surface)
    }
    
    func stopSurface() {
        stopGenerating()
        for surface in surfaces {
            surface.stopMoving()
        }
    }
    
    
}
