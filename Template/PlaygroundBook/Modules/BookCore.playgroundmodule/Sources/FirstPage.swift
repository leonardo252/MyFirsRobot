import SpriteKit
import PlaygroundSupport

public class FirstPage: SKScene, SKPhysicsContactDelegate, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    public var liveViewSafeAreaGuide: UILayoutGuide = UILayoutGuide()

    var head: SKSpriteNode!
    var body: SKSpriteNode!
    var leftArm: SKSpriteNode!
    var rightArm: SKSpriteNode!
    var leftLeg: SKSpriteNode!
    var rightLeg: SKSpriteNode!
    
    var headSheet: SKSpriteNode!
    var bodySheet: SKSpriteNode!
    var leftArmSheet: SKSpriteNode!
    var rightArmSheet: SKSpriteNode!
    var leftLegSheet: SKSpriteNode!
    var rightLegSheet: SKSpriteNode!
    
    var allPicesPosicioned = false
    var movingPiece = false
    var offset: CGPoint!
    var yPosition: CGFloat!
    
    var originalSchale: CGFloat!
    let newSchale: CGFloat = 0.08
//    let originalSchale: CGFloat = 0.45
    let alfaSheet: CGFloat = 0.4
    
    public override func didMove(to view: SKView) {
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.friction = 0.0
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        yPosition = 1 + (frame.midY / 4)
        
        originalSchale = frame.size.height * 0.00025
        
        setupBackGround()
        
        setupSheet()
            
        populatePieces()
        
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !allPicesPosicioned else { return }
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNodes = nodes(at: touchLocation)
        
        for node in touchedNodes {
            
            switch node {
            case head:
                node.setScale(originalSchale)
                movingPiece = true
                node.zPosition = 10
                offset = CGPoint(x: touchLocation.x - node.position.x, y: touchLocation.y - node.position.y)
            case body:
                node.setScale(originalSchale)
                movingPiece = true
                node.zPosition = 10
                offset = CGPoint(x: touchLocation.x - node.position.x, y: touchLocation.y - node.position.y)
            case leftArm:
                node.setScale(originalSchale)
                movingPiece = true
                node.zPosition = 10
                offset = CGPoint(x: touchLocation.x - node.position.x, y: touchLocation.y - node.position.y)
            case rightArm:
                node.setScale(originalSchale)
                movingPiece = true
                node.zPosition = 10
                offset = CGPoint(x: touchLocation.x - node.position.x, y: touchLocation.y - node.position.y)
            case leftLeg:
                node.setScale(originalSchale)
                movingPiece = true
                node.zPosition = 10
                offset = CGPoint(x: touchLocation.x - node.position.x, y: touchLocation.y - node.position.y)
            case rightLeg:
                node.setScale(originalSchale)
                movingPiece = true
                node.zPosition = 10
                offset = CGPoint(x: touchLocation.x - node.position.x, y: touchLocation.y - node.position.y)
            default:
                return
            }
            break
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !allPicesPosicioned && movingPiece else { return }
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNodes = nodes(at: touchLocation)
        let newPostion = CGPoint(x: touchLocation.x , y: touchLocation.y )
        
        for node in touchedNodes {
            switch node {
            case head:
                head.run(SKAction.move(to: newPostion, duration: 0.001))
                
            case body:
                body.run(SKAction.move(to: newPostion, duration: 0.001))
                
            case leftArm:
                leftArm.run(SKAction.move(to: newPostion, duration: 0.001))
                
            case rightArm:
                rightArm.run(SKAction.move(to: newPostion, duration: 0.001))
                
            case leftLeg:
                leftLeg.run(SKAction.move(to: newPostion, duration: 0.001))
                
            case rightLeg:
                rightLeg.run(SKAction.move(to: newPostion, duration: 0.001))
                
            default:
                return
            }
            break
        }
    }
    
//      public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//          guard let touch = touches.first else { return }
//
//      }
    
    func setupBackGround() {
        // BackGround
        let bg = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "embedded-software-1.jpg")))
        bg.zPosition = -10
        bg.position = CGPoint(x: frame.midX, y: frame.midY)
        bg.setScale(2.5)
        bg.alpha = 0.2
        addChild(bg)
        
        //Area of Pieces
        let pieces = SKSpriteNode()
        pieces.size = CGSize(width: frame.width, height: frame.height / 4)
        pieces.position = CGPoint(x: frame.midX, y: yPosition)
        pieces.color = .lightGray
        pieces.alpha = 0.5
        pieces.zPosition = -9
        addChild(pieces)
    }
    
    func setupSheet() {
        //Head Sheet
        headSheet = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Head")))
        headSheet.setScale(originalSchale)
        headSheet.position = CGPoint(x: frame.midX, y: frame.midY + (frame.size.height / 2.5))
        headSheet.alpha = alfaSheet
        headSheet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: headSheet.size.width - 30, height: headSheet.size.height - 30))
        headSheet.physicsBody?.collisionBitMask = 0
        headSheet.physicsBody?.categoryBitMask = Bitmask.headSheet
        headSheet.physicsBody?.contactTestBitMask = Bitmask.head
        addChild(headSheet)
        
        // Left Leg Sheet
        leftLegSheet = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "LEG")))
        leftLegSheet.setScale(originalSchale)
        leftLegSheet.position = CGPoint(x: frame.midX - (frame.size.width / 25), y: frame.midY - (frame.height / 25))
        leftLegSheet.alpha = alfaSheet
        leftLegSheet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftLegSheet.size.width - 30, height: leftLegSheet.size.height - 40))
        leftLegSheet.physicsBody?.collisionBitMask = 0
        leftLegSheet.physicsBody?.categoryBitMask = Bitmask.leftLegSheet
        leftLegSheet.physicsBody?.contactTestBitMask = Bitmask.leftLeg
        addChild(leftLegSheet)
        
        // Right Leg Sheet
        rightLegSheet = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "LEG")))
        rightLegSheet.setScale(originalSchale)
        rightLegSheet.position = CGPoint(x: frame.midX + (frame.size.width / 25), y: frame.midY - (frame.height / 25))
        rightLegSheet.alpha = alfaSheet
        rightLegSheet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightLegSheet.size.width - 30, height: rightLegSheet.size.height - 40))
        rightLegSheet.physicsBody?.collisionBitMask = 0
        rightLegSheet.physicsBody?.categoryBitMask = Bitmask.rightLegSheet
        rightLegSheet.physicsBody?.contactTestBitMask = Bitmask.rightLeg
        addChild(rightLegSheet)
        
        // Left Arm Sheet
        leftArmSheet = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Arm_Left")))
        leftArmSheet.setScale(originalSchale)
        leftArmSheet.position = CGPoint(x: frame.midX - (frame.size.width / 10), y: frame.midY + (frame.size.height / 5.4))
        leftArmSheet.alpha = alfaSheet
        leftArmSheet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftArmSheet.size.width - 30, height: leftArmSheet.size.height - 110))
        leftArmSheet.physicsBody?.collisionBitMask = 0
        leftArmSheet.physicsBody?.categoryBitMask = Bitmask.leftArmSheet
        leftArmSheet.physicsBody?.contactTestBitMask = Bitmask.leftArm
        addChild(leftArmSheet)
        
        // Right Arm Sheet
        rightArmSheet = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Arm_Right")))
        rightArmSheet.setScale(originalSchale)
        rightArmSheet.position = CGPoint(x: frame.midX + (frame.size.width / 10), y: frame.midY + (frame.size.height / 5.4))
        rightArmSheet.alpha = alfaSheet
        rightArmSheet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightArmSheet.size.width - 30, height: rightArmSheet.size.height - 110))
        rightArmSheet.physicsBody?.collisionBitMask = 0
        rightArmSheet.physicsBody?.categoryBitMask = Bitmask.rightArmSheet
        rightArmSheet.physicsBody?.contactTestBitMask = Bitmask.rightArm
        addChild(rightArmSheet)
        
        // Body Sheet
        bodySheet = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Body_OFF")))
        bodySheet.setScale(originalSchale)
        bodySheet.position = CGPoint(x: frame.midX, y: frame.midY + (frame.size.height / 5.18))
        bodySheet.alpha = alfaSheet
        bodySheet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bodySheet.size.width - 70, height: bodySheet.size.height - 70))
        bodySheet.physicsBody?.collisionBitMask = 0
        bodySheet.physicsBody?.categoryBitMask = Bitmask.bodySheet
        bodySheet.physicsBody?.contactTestBitMask = Bitmask.body
        addChild(bodySheet)
    }
    
    func populatePieces() {
        // Body
        body = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Body_OFF")))
        body.setScale(newSchale)
        body.position = CGPoint(x: frame.midX - (frame.midX / 2.5), y: yPosition)
        body.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: body.size.width - 70, height: body.size.height - 70))
        body.physicsBody?.collisionBitMask = 0
        body.physicsBody?.categoryBitMask = Bitmask.body
        body.physicsBody?.contactTestBitMask = Bitmask.bodySheet
        addChild(body)
        
        //Head
        head = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Head")))
        head.setScale(newSchale)
        head.position = CGPoint(x: frame.midX + (frame.midX / 2.5), y: yPosition)
        head.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: head.size.width - 30, height: head.size.height - 30))
        head.physicsBody?.collisionBitMask = 0
        head.physicsBody?.categoryBitMask = Bitmask.head
        head.physicsBody?.contactTestBitMask = Bitmask.headSheet
        addChild(head)
        
        // Left Arm
        leftArm = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Arm_Left")))
        leftArm.setScale(newSchale)
        leftArm.position = CGPoint(x: frame.midX - (frame.midX / 5), y: yPosition)
        leftArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftArm.size.width - 30, height: leftArm.size.height - 110))
        leftArm.physicsBody?.collisionBitMask = 0
        leftArm.physicsBody?.categoryBitMask = Bitmask.leftArm
        leftArm.physicsBody?.contactTestBitMask = Bitmask.leftArmSheet
        addChild(leftArm)
        
        // Right Arm
        rightArm = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Arm_Right")))
        rightArm.setScale(newSchale)
        rightArm.position = CGPoint(x: frame.midX - (frame.midX / 16), y: yPosition)
        rightArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightArm.size.width - 30, height: rightArm.size.height - 110))
        rightArm.physicsBody?.collisionBitMask = 0
        rightArm.physicsBody?.categoryBitMask = Bitmask.rightArm
        rightArm.physicsBody?.contactTestBitMask = Bitmask.rightArmSheet
        addChild(rightArm)
        
        // Left Leg
        leftLeg = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "LEG")))
        leftLeg.setScale(newSchale)
        leftLeg.position = CGPoint(x: frame.midX + (frame.midX / 10), y: yPosition)
        leftLeg.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftLeg.size.width - 30, height: leftLeg.size.height - 40))
        leftLeg.physicsBody?.collisionBitMask = 0
        leftLeg.physicsBody?.categoryBitMask = Bitmask.leftLeg
        leftLeg.physicsBody?.contactTestBitMask = Bitmask.leftLegSheet
        addChild(leftLeg)
        
        // Right Leg
        rightLeg = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "LEG")))
        rightLeg.setScale(newSchale)
        rightLeg.position = CGPoint(x: frame.midX + (frame.midX / 4.5), y: yPosition)
        rightLeg.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightLeg.size.width - 30, height: rightLeg.size.height - 40))
        rightLeg.physicsBody?.collisionBitMask = 0
        rightLeg.physicsBody?.categoryBitMask = Bitmask.rightLeg
        rightLeg.physicsBody?.contactTestBitMask = Bitmask.leftLeg
        addChild(rightLeg)
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == contact.bodyB.categoryBitMask {
            posiNewPiece(bodyA: contact.bodyA.node as! SKSpriteNode, bodyB: contact.bodyB.node as! SKSpriteNode)
        }
    }
    
    func posiNewPiece(bodyA: SKSpriteNode, bodyB: SKSpriteNode) {
        bodyB.removeFromParent()
        bodyA.alpha = 1
        
    }
    
}

