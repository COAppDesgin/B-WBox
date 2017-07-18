//
//  Constants.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 6/29/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import Foundation
import UIKit


//Configuration Variables
let kTJGroundHeight: CGFloat = 20

//Initial Variables
let kDefaultXToMovePerSecond: CGFloat = 320

//Collision Detection
enum BodyType: UInt32 {
    case hero = 1
    case wall = 2
    case ground = 4
    case surface = 8
    case coin = 16
    case border = 32
}

//Game Variables
let kNumberOfPointsPerLevel = 5
let kLevelGenerationTimes: [TimeInterval] = [1, 0.9, 0.8, 0.7, 0.7, 0.6, 0.6, 0.6, 0.5, 0.5, 0.5, 0.5, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1,]
