import SpriteKit
import PlaygroundSupport

public class ThirdPage: SKScene, SKPhysicsContactDelegate, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    public var liveViewSafeAreaGuide: UILayoutGuide = UILayoutGuide()
    
    
    var battery: SKSpriteNode!
    var head: SKSpriteNode!
    var body: SKSpriteNode!
    var leftArm: SKSpriteNode!
    var rightArm: SKSpriteNode!
    var leftLeg: SKSpriteNode!
    var rightLeg: SKSpriteNode!
    
    var yPosition: CGFloat!
    var originalSchale: CGFloat!
    
    public override func didMove(to view: SKView) {
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.friction = 0.0
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        yPosition = 1 + (frame.midY / 4)
        
        originalSchale = frame.size.height * 0.00025
        
        setupBackGround()
        populatePieces()
        MoveArms()
        moveLegs()
        
        var time = 5.0
        
        for _ in 1...10{
            DispatchQueue.main.asyncAfter(deadline: .now() + time) { // Change `2.0` to the desired number of seconds.
                self.MoveArms()
                self.moveLegs()
            }
            time += 5.0
        }

    }
    
    func setupBackGround() {
        // BackGround
        let bg = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "embedded-software-1.jpg")))
        bg.zPosition = -10
        bg.position = CGPoint(x: frame.midX, y: frame.midY)
        bg.alpha = 0.2
        bg.setScale(2.5)
        addChild(bg)

    }
    
    public func receive(_ message: PlaygroundValue) {
        switch message {
            
        case .string(let value) :
            if value == "arms" {
                MoveArms()
            }
            break
            
        default:
            print("Oh, my bad!")
            
        }
    }
    
    func MoveArms(){
        let angleClockwise : CGFloat = -2
        let rotateClockWise = SKAction.rotate(byAngle: angleClockwise, duration: 2)
        let repeatActionClockwise = SKAction.repeat(rotateClockWise, count: 1)
        
        let angleAntiClockwise : CGFloat = 2
        let rotateAntiClockwise = SKAction.rotate(byAngle: angleAntiClockwise, duration: 2)
        let repeatActionAntiClockwise = SKAction.repeat(rotateAntiClockwise, count: 1)
        
        rightArm.run(repeatActionAntiClockwise, completion: {
            self.rightArm.run(repeatActionClockwise)
        })
        leftArm.run(repeatActionClockwise, completion: {
            self.leftArm.run(repeatActionAntiClockwise)
        })
    }
    
    func moveLegs() {
        let angleClockwise : CGFloat = -.pi / 6
        let rotateClockWise = SKAction.rotate(byAngle: angleClockwise, duration: 2)
        let repeatActionClockwise = SKAction.repeat(rotateClockWise, count: 1)
        
        let angleAntiClockwise : CGFloat = .pi / 6
        let rotateAntiClockwise = SKAction.rotate(byAngle: angleAntiClockwise, duration: 2)
        let repeatActionAntiClockwise = SKAction.repeat(rotateAntiClockwise, count: 1)
        
        rightLeg.run(repeatActionAntiClockwise, completion: {
            self.rightLeg.run(repeatActionClockwise)
        })
        leftLeg.run(repeatActionClockwise, completion: {
            self.leftLeg.run(repeatActionAntiClockwise)
        })
    }
    
    
    func populatePieces() {
        //Head
        head = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Head_ON")))
        head.setScale(originalSchale)
        head.position = CGPoint(x: frame.midX, y: frame.midY + (frame.size.height / 2.5))
        head.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: head.size.width - 50, height: head.size.height - 50))
        head.physicsBody?.collisionBitMask = 0
        head.physicsBody?.categoryBitMask = Bitmask.head
        head.physicsBody?.contactTestBitMask = Bitmask.headSheet
        addChild(head)
        
        // Left Arm
        leftArm = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Arm_Left.png")))
        leftArm.setScale(originalSchale)
        leftArm.position = CGPoint(x: frame.midX - (frame.size.width / 13), y: frame.midY + (frame.size.height / 3.35))
        leftArm.anchorPoint = CGPoint(x:0.66 ,y: 0.859)
        leftArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftArm.size.width - 50, height: leftArm.size.height - 130))
        leftArm.physicsBody?.collisionBitMask = 0
        leftArm.physicsBody?.categoryBitMask = Bitmask.leftArm
        leftArm.physicsBody?.contactTestBitMask = Bitmask.leftArmSheet
        addChild(leftArm)
        
        // Right Arm
        rightArm = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Arm_Right.png")))
        rightArm.setScale(originalSchale)
        rightArm.position = CGPoint(x: frame.midX + (frame.size.width / 13), y: frame.midY + (frame.size.height / 3.35))
        rightArm.anchorPoint = CGPoint(x:0.33 ,y: 0.859)
        rightArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightArm.size.width - 50, height: rightArm.size.height - 130))
        rightArm.physicsBody?.collisionBitMask = 0
        rightArm.physicsBody?.categoryBitMask = Bitmask.rightArm
        rightArm.physicsBody?.contactTestBitMask = Bitmask.rightArmSheet
        addChild(rightArm)
        
        // Left Leg
        leftLeg = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "LEG")))
        leftLeg.setScale(originalSchale)
        leftLeg.position = CGPoint(x: frame.midX - (frame.size.width / 25), y: frame.midY + (frame.height * 0.051))
        leftLeg.anchorPoint = CGPoint(x: 0.5, y: 0.85)
        leftLeg.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftLeg.size.width - 50, height: leftLeg.size.height - 50))
        leftLeg.physicsBody?.collisionBitMask = 0
        leftLeg.physicsBody?.categoryBitMask = Bitmask.leftLeg
        leftLeg.physicsBody?.contactTestBitMask = Bitmask.leftLegSheet
        addChild(leftLeg)
        
        // Right Leg
        rightLeg = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "LEG")))
        rightLeg.setScale(originalSchale)
        rightLeg.position = CGPoint(x: frame.midX + (frame.size.width / 25), y: frame.midY + (frame.height * 0.051))
        rightLeg.anchorPoint = CGPoint(x: 0.5, y: 0.85)
        rightLeg.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightLeg.size.width - 50, height: rightLeg.size.height - 50))
        rightLeg.physicsBody?.collisionBitMask = 0
        rightLeg.physicsBody?.categoryBitMask = Bitmask.rightLeg
        rightLeg.physicsBody?.contactTestBitMask = Bitmask.leftLeg
        addChild(rightLeg)
        
        // Body
        body = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Body_ON+Battery")))
        body.setScale(originalSchale)
        body.position = CGPoint(x: frame.midX, y: frame.midY + (frame.size.height / 5.18))
        body.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: body.size.width - 100, height: body.size.height - 100))
        body.physicsBody?.collisionBitMask = 0
        body.physicsBody?.categoryBitMask = Bitmask.body
        body.physicsBody?.contactTestBitMask = Bitmask.bodySheet
        addChild(body)
    }
    
}
