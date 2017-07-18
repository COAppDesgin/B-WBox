//
//  GameScene.swift
//  BWBox
//
//  Created by Tyler Jordan Cagle on 6/28/17.
//  Copyright © 2017 AppDesign. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var movingGround: TJMovingGround!
    var hero: TJBoxBoy!
    var cloudGenerator: TJCloudGenerator!
    var wallGenerator:  TJWallGenerator!
    var border: TJBorder!
    var surfaceGenerator: TJSurfaceGenerator!
    var surface2Generator: TJSurface2Generator!
    var coinGenerator: TJCoinGenerator!
    var coin: TJCoin!

    
    var isStarted = false
    var isGameOver = false
    var isUpsideDown = false
    var halfSquat = false
    
    var currentLevel = 0
    
     override func didMove(to view: SKView) {
        
        backgroundColor = UIColor(red: 157/255, green: 159/255, blue: 151/255, alpha: 1)

        addMovingGround()
        addHero()
        addClouds()
        addWalls()
        addBorder()
        addStartLabel()
        addPhysicsWorld()
        addPointsLabel()
        loadScore()
        addSurface()
        addCoin()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view!.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view!.addGestureRecognizer(swipeDown)
        
            }

    
    func addMovingGround() {
        //Add ground
        
        movingGround = TJMovingGround(size: CGSize(width: view!.frame.width, height: kTJGroundHeight))
        movingGround.position = CGPoint(x: 0, y: view!.frame.size.height/2)
        addChild(movingGround)
    }
    
    func addHero() {
        //Add hero
        
        hero = TJBoxBoy()
        hero.position = CGPoint(x: 70, y: movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
        hero.breath()
    }
    
    func addClouds() {
        //Add clouds
        
        cloudGenerator = TJCloudGenerator(color: UIColor.clear, size: view!.frame.size)
        cloudGenerator.position = view!.center
        addChild(cloudGenerator)
        cloudGenerator.populate(num: 7)
        cloudGenerator.startGeneratingWithSpawnTime(seconds: 5)
    }
    
    func addWalls() {
        //Add walls
        
        wallGenerator = TJWallGenerator(color: UIColor.clear, size: view!.frame.size)
        wallGenerator.position = view!.center
        addChild(wallGenerator)
    }
    
    func addBorder() {
        //Add border
        
        border = TJBorder()
        border.position = CGPoint(x: -40, y: 325)
        addChild(border)
    }
    
    func addSurface() {
        //Add surfaces
        
        surfaceGenerator = TJSurfaceGenerator(color: UIColor.clear, size: view!.frame.size)
        surfaceGenerator.position = view!.center
        addChild(surfaceGenerator)
        
        surface2Generator = TJSurface2Generator(color: UIColor.clear, size: view!.frame.size)
        surface2Generator.position = view!.center
        addChild(surface2Generator)

    }
    
    func addStartLabel() {
        //Add start label
        
        let tapToStartLabel = SKLabelNode(text: "Tap to Start!")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.fontName = "ArialRoundedMTBold"
        tapToStartLabel.position.x = view!.center.x
        tapToStartLabel.position.y = view!.center.y + 80
        tapToStartLabel.fontColor = UIColor.black
        tapToStartLabel.fontSize = 28
        addChild(tapToStartLabel)
        tapToStartLabel.run(blinkAnimation())
    }
    
    func addPointsLabel() {
        let pointsLabel = TJPointsLabel(num: 0)
        pointsLabel.name = "pointsLabel"
        pointsLabel.fontName = "ArialRoundedMTBold"
        pointsLabel.position = CGPoint(x: 30, y: view!.frame.size.height - 35)
        pointsLabel.zPosition = 20
        addChild(pointsLabel)
        
        let highscoreLabel = TJPointsLabel(num: 0)
        highscoreLabel.name = "highscoreLabel"
        highscoreLabel.fontName = "ArialRoundedMTBold"
        highscoreLabel.position = CGPoint(x: view!.frame.size.width - 30, y: view!.frame.size.height - 35)
        addChild(highscoreLabel)
        
        let highScoreTextLabel = SKLabelNode(text: "Highscore: ")
        highScoreTextLabel.name = "highScoreTextLabel"
        highScoreTextLabel.fontColor = UIColor.black
        highScoreTextLabel.fontSize = 18
        highScoreTextLabel.fontName = "ArialRoundedMTBold"
        highScoreTextLabel.position = CGPoint(x: -63, y: 2)
        highscoreLabel.addChild(highScoreTextLabel)
        
    }
    
    func addPhysicsWorld() {
        //Add physics world
        
        physicsWorld.contactDelegate = self
    }
    
    func loadScore() {
        let defaults = UserDefaults.standard
        let highscoreLabel = childNode(withName: "highscoreLabel") as! TJPointsLabel
        highscoreLabel.setTo(num: defaults.integer(forKey: "highscore"))
    }
    
    func moveScore() {
        let moveCenter = SKAction.move(to: CGPoint(x: view!.frame.width/2, y: view!.frame.height/2 + 70), duration: 0.5)
        let pointsLabel = childNode(withName: "pointsLabel")
        
        pointsLabel?.run(moveCenter)
        
    }
    
    func  addCoin() {
        //Add coin

        coin = TJCoin()
        coinGenerator = TJCoinGenerator(color: UIColor.clear, size: view!.frame.size)
        coinGenerator.position = view!.center
        addChild(coinGenerator)
    }
    
    
    //MARK: Game Cycle
    
    func start() {
        isStarted = true
        
        let tapToStartLabel = childNode(withName: "tapToStartLabel")
        tapToStartLabel?.removeFromParent()
        
        hero.stop()
        movingGround.start()
        surfaceGenerator.startGeneratingSurface(seconds: 5)
        surface2Generator.startGeneratingSurface(seconds: 6)
        wallGenerator.startGeneratingWalls(seconds: 1)
        coinGenerator.startGeneratingCoins(seconds: 7)
    }
    
    func gameOver() {
        isGameOver = true
        
        //Stop everything
        wallGenerator.stopWalls()
        movingGround.stop()
        hero.stop()
        surfaceGenerator.stopSurface()
        surface2Generator.stopSurface()
        coinGenerator.stopCoin()
        moveScore()
        border.removeFromParent()
        
        
        //Create game over label
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.fontColor = UIColor.black
        gameOverLabel.fontName = "ArialRoundedMTBold"
        gameOverLabel.position.y = view!.center.y + 100
        gameOverLabel.position.x = view!.frame.width/2
        gameOverLabel.fontSize = 28
        gameOverLabel.zPosition = 4
        addChild(gameOverLabel)
        gameOverLabel.run(blinkAnimation())
        
        //Update highscore
        let pointsLabel = childNode(withName: "pointsLabel") as! TJPointsLabel
        let highscoreLabel = childNode(withName: "highscoreLabel") as! TJPointsLabel

        
        if (highscoreLabel.number) < (pointsLabel.number) {
            highscoreLabel.setTo(num: (pointsLabel.number))
            
            //Save the highscore
            let defaults = UserDefaults.standard
            defaults.set(highscoreLabel.number, forKey: "highscore")
        
        }
    }
    
    
    func restart() {
        cloudGenerator.stopGenerating()
        
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .aspectFill
        
        view!.presentScene(newScene)
        isGameOver = false
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isGameOver {
            restart()
        }
        else if !isStarted {
            start()
        } else {
            hero.jump()
            
        }
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.down:
                if isUpsideDown == false && isJumping == false {
                    hero.flip()
                    isUpsideDown = !isUpsideDown
                    let when = DispatchTime.now() + 0.08
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        self.physicsWorld.gravity = CGVector(dx: 0, dy: 9.8)
                    }
                }
            case UISwipeGestureRecognizerDirection.up:
                if isUpsideDown == true && isJumping == false {
                    hero.flip()
                    isUpsideDown = !isUpsideDown
                    let when = DispatchTime.now() + 0.08
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
                    }

                }
            default:
                break
            }
        }
    }
    
     override func update(_ currentTime: TimeInterval) {
        //Called before each frame is rendered
        
        if wallGenerator.wallTrackers.count > 0 {
            let wall = wallGenerator.wallTrackers[0]
            
            let wallLocation = wallGenerator.convert(wall.position, to: self)
            if wallLocation.x < hero.position.x {
                wallGenerator.wallTrackers.remove(at: 0)
        
                let pointsLabel = childNode(withName: "pointsLabel") as! TJPointsLabel
                pointsLabel.increment()
                
                if pointsLabel.number % kNumberOfPointsPerLevel == 0 {
                    currentLevel += 1
                    wallGenerator.stopGenerating()
                    wallGenerator.startGeneratingWalls(seconds: kLevelGenerationTimes[currentLevel])
                }
            }
        }
        if surfaceGenerator.surfaceTrackers.count > 0 {
            let surface = surfaceGenerator.surfaceTrackers[0]
            
            let surfaceLocation = surfaceGenerator.convert(surface.position, to: self)
            if surfaceLocation.x < hero.position.x {
                surfaceGenerator.surfaceTrackers.remove(at: 0)
            }
        }
        if surface2Generator.surface2Trackers.count > 0 {
            let surface2 = surface2Generator.surface2Trackers[0]
            
            let surface2Location = surface2Generator.convert(surface2.position, to: self)
            if surface2Location.x < hero.position.x {
                surface2Generator.surface2Trackers.remove(at: 0)
            }
        }
        
        if hero.position.y > view!.frame.height || hero.position.y < -view!.frame.height && !isGameOver {
            hero.position.y = -hero.position.y
        }
        
        if halfSquat == true {
            halfSquat = false
            let pointsLabel = childNode(withName: "pointsLabel") as! TJPointsLabel
            pointsLabel.sendy()
        }
        
        if hero.position.x < 70 || hero.position.x > 70 {
            if !isGameOver && !isUpsideDown {
                let moveBox = SKAction.moveTo(x: 70, duration: 3)
                hero.run(moveBox)
            } else {}
        } else {}
        
    }
    
    //MARK: SKContactPhysicsDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        isJumping = false

        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
        case BodyType.hero.rawValue | BodyType.wall.rawValue :
            hero.fall()
            self.gameOver()
            break
        case BodyType.hero.rawValue | BodyType.border.rawValue :
            self.gameOver()
            break
        case BodyType.hero.rawValue | BodyType.surface.rawValue:
            if isUpsideDown == false {
                self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
            } else if isUpsideDown == true {
                self.physicsWorld.gravity = CGVector(dx: 0, dy: 9.8)
            } else {}
            break
        case BodyType.hero.rawValue | BodyType.coin.rawValue :
            if isGameOver == false {
                coinGenerator.count()
                halfSquat = true
            }
            break
        default:
            return
        }
    }
    
    
    //MARK: Animaiton
    func blinkAnimation() -> SKAction {
        let duration = 0.8
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: duration)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatForever(blink)
    }
    
}




