//
//  TJPointsLabel.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 6/29/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class TJPointsLabel: SKLabelNode{
    
    var number = 0
    
    init(num: Int) {
        super.init()
        
        fontColor = UIColor.black
        fontSize = 24
        
        number = num
        text = "\(num)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func increment() {
        number += 1
        text = "\(number)"
    }
    
    func sendy() {
        number += 10
        text = "\(number)"
    }
    
    func setTo(num: Int) {
        self.number = num
        text = "\(self.number)"
    }
    
}
