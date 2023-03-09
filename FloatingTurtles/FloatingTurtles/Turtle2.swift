//
//  Turtle2.swift
//  FloatingTurtles
//
//  Created by Valerie on 09.03.23.
//

import Foundation
import SpriteKit


class Turtle2: SKSpriteNode{
    
        init(){
            let texture = SKTexture(imageNamed: "turtle2")
            super.init(texture: texture, color: .white, size: texture.size())
            
            //let turtle2 = SKSpriteNode(imageNamed: "turtle2")
           
            self.xScale = 0.5
            self.yScale = 0.5
            self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.zPosition = 1
            
            let body:SKPhysicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0, size: texture.size() )
            
            self.physicsBody = body
            self.physicsBody?.allowsRotation = false
            self.physicsBody?.isDynamic = true
            self.physicsBody?.affectedByGravity = true
            self.physicsBody?.collisionBitMask = CollisionType.player.rawValue
            self.physicsBody?.categoryBitMask = CollisionType.turtle2.rawValue
            self.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
            
            /*turtle2.name = "turtle2"
            turtle2.physicsBody = SKPhysicsBody(texture: turtle2.texture!, size: turtle2.texture!.size())
            turtle2.physicsBody!.categoryBitMask = CollisionType.turtle2.rawValue
            turtle2.physicsBody!.collisionBitMask = CollisionType.player.rawValue
            turtle2.physicsBody!.contactTestBitMask = CollisionType.player.rawValue
            turtle2.physicsBody?.isDynamic = false*/
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("LOL NO")
        }
        
        func configureMovement(_ moveStraight: Bool){
            let path = UIBezierPath()
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: -10000, y: 0))
        }

}
