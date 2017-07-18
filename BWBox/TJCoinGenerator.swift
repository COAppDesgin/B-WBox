//
//  TJCoinGenerator.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 7/12/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import SpriteKit


class TJCoinGenerator: SKSpriteNode {
    
    var generationTimer: Timer?
    var coins = [TJCoin]()
    var coinTrackers = [TJCoin]()
    
    func startGeneratingCoins(seconds: TimeInterval){
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(TJCoinGenerator.generateCoin), userInfo: nil, repeats: true)
    }
    
    func stopGenerating() {
        generationTimer?.invalidate()
    }
    
    func generateCoin() {
        
        if randSurface == 0 {
            scaleSurface = -1
        } else {
            scaleSurface = 1
        }
        
        let coin = TJCoin()
        coin.position.x = size.width/2 + coin.size.width/2
        coin.position.y = scaleSurface * (kTJGroundHeight/2 + coin.size.height/2 + CGFloat(arc4random_uniform(25) + 175))
        coins.append(coin)
        coinTrackers.append(coin)
        
        addChild(coin)
    }
    
    func count() {
        let moveUp = SKAction.moveBy(x: 0, y: 1000, duration: 0.8)
        run(moveUp)

        let when = DispatchTime.now() + 0.8
        DispatchQueue.main.asyncAfter(deadline: when) {
            //self.removeFromParent()
            let moveDown = SKAction.moveBy(x: 0, y: -1000, duration: 0.8)
            self.run(moveDown)
        }
    }
    
    func stopCoin() {
        stopGenerating()
        for coin in coins {
            coin.stopMoving()
        }
    }
    
    
}
