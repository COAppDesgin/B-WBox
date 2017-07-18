//
//  TJCloudGenerator.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 6/29/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import SpriteKit

class TJCloudGenerator: SKSpriteNode {
    
    let CLOUD_WIDTH: CGFloat = 125
    let CLOUD_HEIGHT: CGFloat = 55
    
    var generationTimer: Timer!
    
    func populate(num:Int) {
        for _ in 0 ..< num {
            let cloud = TJCloud(size: CGSize(width: CLOUD_WIDTH, height: CLOUD_HEIGHT))
            let x = CGFloat(arc4random_uniform(UInt32(size.width))) - size.width/2
            let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
            
            cloud.position = CGPoint(x: x, y: y)
            cloud.zPosition = -9
            addChild(cloud)
        }
    }
    
    func startGeneratingWithSpawnTime(seconds: TimeInterval) {
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(TJCloudGenerator.generateCloud), userInfo: nil, repeats: true)
    }
    
    func stopGenerating() {
        generationTimer.invalidate()
    }
    
    func generateCloud() {
        let x = size.width/2 + CLOUD_WIDTH/2
        let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
        let cloud = TJCloud(size: CGSize(width: CLOUD_WIDTH, height: CLOUD_HEIGHT))
        
        cloud.position = CGPoint(x: x, y: y)
        cloud.zPosition = -9
        addChild(cloud)
    }
    
}
