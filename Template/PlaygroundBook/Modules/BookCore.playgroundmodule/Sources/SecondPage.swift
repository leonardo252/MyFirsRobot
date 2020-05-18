import SpriteKit

public class SecondPage: SKScene, SKPhysicsContactDelegate {
    
    var battery: SKSpriteNode!
    var batterySheet: SKSpriteNode!
    
    var head: SKSpriteNode!
    var body: SKSpriteNode!
    var leftArm: SKSpriteNode!
    var rightArm: SKSpriteNode!
    var leftLeg: SKSpriteNode!
    var rightLeg: SKSpriteNode!
    
    var allPicesPosicioned = false
    var movingPiece = false
    var offset: CGPoint!
    var yPosition: CGFloat!
    
    let newSchale: CGFloat = 0.08
    var originalSchale: CGFloat!
    let alfaPices: CGFloat = 1
    let alfaSheet: CGFloat = 0.4
    
    public override func didMove(to view: SKView) {
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.friction = 0.0
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        yPosition = 1 + (frame.midY / 4)
        
        originalSchale = frame.size.height * 0.00025
        
        setupBackGround()
        populatePieces()
        setupSheet()
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !allPicesPosicioned else { return }
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNodes = nodes(at: touchLocation)
        
        for node in touchedNodes {
            if node == battery {
                node.setScale(originalSchale)
                movingPiece = true
                node.zPosition = 10
                offset = CGPoint(x: touchLocation.x - node.position.x, y: touchLocation.y - node.position.y)
            }else {
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
            case battery:
                battery.run(SKAction.move(to: newPostion, duration: 0.001))
            default:
                return
            }
            break
        }
    }
    
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == contact.bodyB.categoryBitMask {
            posiNewPiece(bodyA: contact.bodyA.node as! SKSpriteNode, bodyB: contact.bodyB.node as! SKSpriteNode)
        }
    }
    
    func posiNewPiece(bodyA: SKSpriteNode, bodyB: SKSpriteNode) {
        bodyA.removeFromParent()
        bodyB.removeFromParent()
        body.texture = SKTexture(image: #imageLiteral(resourceName: "Body_ON+Battery"))
        head.texture = SKTexture(image: #imageLiteral(resourceName: "Head_ON"))
    }
    
    func setupBackGround() {
        // BackGround
        let bg = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "embedded-software-1.jpg")))
        bg.zPosition = -10
        bg.position = CGPoint(x: frame.midX, y: frame.midY)
        bg.alpha = 0.2
        bg.setScale(2.5)
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
    
    func populatePieces() {
        //Head
        head = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Head")))
        head.setScale(originalSchale)
        head.position = CGPoint(x: frame.midX, y: frame.midY + (frame.size.height / 2.5))
        head.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: head.size.width - 50, height: head.size.height - 50))
        head.physicsBody?.collisionBitMask = 0
        head.physicsBody?.categoryBitMask = Bitmask.head
        head.physicsBody?.contactTestBitMask = Bitmask.headSheet
        addChild(head)
        
        // Left Arm
        leftArm = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Arm_Left")))
        leftArm.setScale(originalSchale)
        leftArm.position = CGPoint(x: frame.midX - (frame.size.width / 10), y: frame.midY + (frame.size.height / 5.4))
        leftArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftArm.size.width - 50, height: leftArm.size.height - 130))
        leftArm.physicsBody?.collisionBitMask = 0
        leftArm.physicsBody?.categoryBitMask = Bitmask.leftArm
        leftArm.physicsBody?.contactTestBitMask = Bitmask.leftArmSheet
        addChild(leftArm)
        
        // Right Arm
        rightArm = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Arm_Right")))
        rightArm.setScale(originalSchale)
        rightArm.position = CGPoint(x: frame.midX + (frame.size.width / 10), y: frame.midY + (frame.size.height / 5.4))
        rightArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightArm.size.width - 50, height: rightArm.size.height - 130))
        rightArm.physicsBody?.collisionBitMask = 0
        rightArm.physicsBody?.categoryBitMask = Bitmask.rightArm
        rightArm.physicsBody?.contactTestBitMask = Bitmask.rightArmSheet
        addChild(rightArm)
        
        // Left Leg
        leftLeg = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "LEG")))
        leftLeg.setScale(originalSchale)
        leftLeg.position = CGPoint(x: frame.midX - (frame.size.width / 25), y: frame.midY - (frame.height / 25))
        leftLeg.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftLeg.size.width - 50, height: leftLeg.size.height - 50))
        leftLeg.physicsBody?.collisionBitMask = 0
        leftLeg.physicsBody?.categoryBitMask = Bitmask.leftLeg
        leftLeg.physicsBody?.contactTestBitMask = Bitmask.leftLegSheet
        addChild(leftLeg)
        
        // Right Leg
        rightLeg = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "LEG")))
        rightLeg.setScale(originalSchale)
        rightLeg.position = CGPoint(x: frame.midX + (frame.size.width / 25), y: frame.midY - (frame.height / 25))
        rightLeg.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightLeg.size.width - 50, height: rightLeg.size.height - 50))
        rightLeg.physicsBody?.collisionBitMask = 0
        rightLeg.physicsBody?.categoryBitMask = Bitmask.rightLeg
        rightLeg.physicsBody?.contactTestBitMask = Bitmask.leftLeg
        addChild(rightLeg)
        
        // Body
        body = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Body_OFF")))
        body.setScale(originalSchale)
        body.position = CGPoint(x: frame.midX, y: frame.midY + (frame.size.height / 5.18))
        body.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: body.size.width - 100, height: body.size.height - 100))
        body.physicsBody?.collisionBitMask = 0
        body.physicsBody?.categoryBitMask = Bitmask.body
        body.physicsBody?.contactTestBitMask = Bitmask.bodySheet
        addChild(body)
        
        // Battery
        battery = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Battery")))
        battery.setScale(newSchale)
        battery.position = CGPoint(x: frame.midX, y: yPosition)
        battery.alpha = alfaPices
        battery.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: battery.size.width - 10, height: battery.size.height - 50))
        battery.physicsBody?.collisionBitMask = 0
        battery.physicsBody?.categoryBitMask = Bitmask.battery
        battery.physicsBody?.contactTestBitMask = Bitmask.batterySheet
        addChild(battery)
        
    }
    
    func setupSheet() {
        
        batterySheet = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Battery")))
        batterySheet.setScale(originalSchale)
        let batX = frame.midX + (frame.size.width / 22.0)
        let batY = frame.midY + (frame.size.height / 5.1)
        batterySheet.position = CGPoint(x: batX , y: batY)
        batterySheet.alpha = alfaSheet
        batterySheet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: batterySheet.size.width - 10, height: batterySheet.size.height - 50))
        batterySheet.physicsBody?.collisionBitMask = 0
        batterySheet.physicsBody?.categoryBitMask = Bitmask.batterySheet
        batterySheet.physicsBody?.contactTestBitMask = Bitmask.batterySheet
        addChild(batterySheet)
        
    }
}
