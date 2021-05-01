//
//  GameScene.swift
//  Project11
//
//  Created by Kocfinans on 20.09.2020.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editingLabel: SKLabelNode!
    
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editingLabel.text = "Done"
            } else {
                editingLabel.text = "Edit"
            }
        }
    }
    
    var ballLimit = 5
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        editingLabel = SKLabelNode(fontNamed: "Chalkduster")
        editingLabel.text = "Edit"
        editingLabel.position = CGPoint(x: 80, y: 700)
        addChild(editingLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let objects = nodes(at: location)
        
        if objects.contains(editingLabel) {
            editingMode.toggle()
        } else {
            if editingMode {
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                box.name = "stick"
                
                addChild(box)
            } else {
                let ballColorArray = ["ballBlue", "ballCyan", "ballGreen", "ballPurple", "ballYellow", "ballRed"]
                
                let ball = SKSpriteNode(imageNamed: ballColorArray[Int.random(in: 0...5)])
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
                ball.position = CGPoint(x: location.x, y: CGFloat(700))
                ball.physicsBody?.restitution = 0.5
//                ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                ball.name = "ball"
        //        ball.physicsBody!.isDynamic = false
                addChild(ball)
                
                ballLimit -= 1
            }
        }
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.name = "bouncer"
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody!.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        addChild(slotBase)
        
        slotGlow.position = position
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 4)
        let spinForever = SKAction.repeatForever(spin)
        
        slotGlow.run(spinForever)
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 10
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 10
        }
    }
    
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

//        print(nodeA.name!, nodeB.name!)

        if contact.bodyA.node?.name == "ball" {
            collision(between: nodeA, object: nodeB)
        } else if contact.bodyB.node?.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }
        
        if nodeA.name == "stick" && ballLimit >= 0 {
            nodeA.removeFromParent()
        } else if nodeB.name == "stick" && ballLimit >= 0 {
            nodeB.removeFromParent()
        }
    }
}
