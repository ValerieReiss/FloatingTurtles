//
//  GameScene.swift
//  FloatingTurtles
//
//  Created by Valerie on 08.03.23.
//
import CoreMotion
import SpriteKit
import GameplayKit

enum CollisionType: UInt32 {
    case player = 1
    case turtle2 = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
 
    //let player = SKSpriteNode(imageNamed: "turtle")
    //let turtle2 = SKSpriteNode(imageNamed: "turtle2")
    
    var player = Player()
    var turtle2 = Turtle2()
    var scoreLabel: SKLabelNode!
    var hearts = 0

    var lastUpdateTime:TimeInterval = 0
    var dt:TimeInterval = 0

    var currentTouchPosition: CGPoint  = CGPointZero
    var beginningTouchPosition:CGPoint = CGPointZero
    var currentPlayerPosition: CGPoint = CGPointZero

    var playableRectArea:CGRect = CGRectZero

    override func didMove(to view: SKView) {
        
        let backgroundImage = SKSpriteNode(imageNamed: "background")
        backgroundImage.anchorPoint = CGPointMake(0.5, 0.5)
        backgroundImage.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        backgroundImage.zPosition = -20
        self.addChild(backgroundImage)
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame)-200, y: CGRectGetMidY(self.frame)+150)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        scoreLabel.text = "\(hearts)"
        
        addChild(turtle2)
        turtle2.position = CGPoint(x: CGRectGetMidX(self.frame)+200, y: CGRectGetMidY(self.frame))
        
        addChild(player)
        player.position = CGPoint(x: CGRectGetMidX(self.frame)-200, y: CGRectGetMidY(self.frame))
        
        let maxAspectRatio:CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRectArea = CGRect(x: 0, y: playableMargin,
                                              width: size.width,
                                              height: playableHeight)
        
        currentTouchPosition = CGPointZero
        beginningTouchPosition = CGPointZero
        currentPlayerPosition = CGPoint(x: CGRectGetMidX(self.frame)-200, y: CGRectGetMidY(self.frame))
                
        player.position = currentPlayerPosition
    }
 
    func didBegin(_ contact: SKPhysicsContact){
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if nodeA.name == "player"{
            print("------------------------------------player")
            if let hearty = SKEmitterNode(fileNamed: "Hearty"){
                        hearty.position = nodeA.position
                        addChild(hearty)
                    }
            hearts += 1
            scoreLabel.text = "\(hearts)"
        } else if nodeA.name == "turtle2"{
            print("-------------------------------------turtle2")
        } else {
            print("still not")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch: AnyObject in touches {
                currentTouchPosition = touch.location(in:self)
            }
            let dxVectorValue = (-1) * (beginningTouchPosition.x - currentTouchPosition.x)
            let dyVectorValue = (-1) * (beginningTouchPosition.y - currentTouchPosition.y)
            player.movePlayerBy(dxVectorValue: dxVectorValue, dyVectorValue: dyVectorValue, duration: dt)
        }

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            player.removeAllActions()
            player.stopMoving()
        }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch: AnyObject in touches {
                beginningTouchPosition = touch.location(in:self)
                currentTouchPosition = beginningTouchPosition
            }
        }

        override func update(_ currentTime: CFTimeInterval) {
            currentPlayerPosition = player.position
            if lastUpdateTime > 0 {dt = currentTime - lastUpdateTime}
            else {dt = 0}
            lastUpdateTime = currentTime
            player.boundsCheckPlayer(playableArea: playableRectArea)
        }

    func stopMoving() {
        let delayTime: TimeInterval = 0.5  // 0.5 second pause
        let stopAction: SKAction = SKAction.run{
            self.physicsBody?.velocity = CGVectorMake(0, 0)
        }
        let pause: SKAction = SKAction.wait(forDuration: delayTime)
        let stopSequence: SKAction = SKAction.sequence([pause,stopAction])
        self.run(stopSequence)
    }
    
}
