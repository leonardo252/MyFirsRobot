import PlaygroundSupport
import UIKit

public class MyPage: UIViewController {
    lazy var eimagemEu: UIImageView = {
        
       
        let imageT = UIImageView(image: #imageLiteral(resourceName: "MyImage.jpeg"))
        imageT.layer.cornerRadius = 200
        imageT.layer.masksToBounds = true
        imageT.contentMode = .scaleAspectFit
        imageT.translatesAutoresizingMaskIntoConstraints = false
        imageT.layer.borderWidth = 5
        let myColor = UIColor.white
        imageT.layer.borderColor = myColor.cgColor
        return imageT
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(eimagemEu)
        eimagemEu.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        eimagemEu.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eimagemEu.widthAnchor.constraint(equalToConstant: 300).isActive = true
        eimagemEu.heightAnchor.constraint(equalToConstant: 510).isActive = true
        
        let image = UIImage(named: "embedded-software-1.jpg")
        view.backgroundColor = UIColor(patternImage: image!)
        
        
    }
    

  

}
