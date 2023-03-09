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
    
    self.xScale = 1
    self.yScale = 1
    self.anchorPoint = CGPoint(x: 300 , y: 300)
    self.position = CGPoint(x: 300 , y: 300)
    self.zPosition = 2
            
    let body:SKPhysicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0, size: texture.size() )
            
    self.physicsBody = body
    self.physicsBody?.allowsRotation = false
    self.physicsBody?.isDynamic = true
    self.physicsBody?.affectedByGravity = true
    self.physicsBody?.collisionBitMask = CollisionType.player.rawValue
    self.physicsBody?.categoryBitMask = CollisionType.turtle2.rawValue
    self.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
}
        
required init?(coder aDecoder: NSCoder) {
            fatalError("LOL NO")
}
        
func moveTurtle2(){
            let movement = SKAction.move(to: CGPoint(), duration: 5.0)
    run(SKAction.repeat(movement, count: 1))
            //run (SKAction.repeatForever(movement))
        }
    
func boundsCheckPlayer(playableArea: CGRect){
        let bottomLeft = CGPoint(x: 0, y: CGRectGetMinY(playableArea))
        let topRight = CGPoint(x: playableArea.size.width, y: CGRectGetMaxY(playableArea))

        if(self.position.x <= bottomLeft.x){
            self.position.x = bottomLeft.x + self.size.width
            // velocity.x = -velocity.x
        }

        if(self.position.x >= topRight.x){
            self.position.x = topRight.x - self.size.width
            // velocity.x = -velocity.x
        }

        if(self.position.y <= bottomLeft.y){
            self.position.y = bottomLeft.y + self.size.height
            // velocity.y = -velocity.y
        }

        if(self.position.y >= topRight.y){
            self.position.y = topRight.y - self.size.height
            // velocity.y = -velocity.y
        }
    }

}
