//
//  ViewController.swift
//  Dot-Tapper-AR
//
//  Created by Marc Castro on 11/28/21.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    
    var counter:Int = 0 {
        didSet {
            counterLabel.text = "\(counter)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        
        sceneView.session.run(configuration)
        addObject()
    }

    func addObject() {
        let virtualObject = SCNNode()
        virtualObject.name = "virtualObject"
        virtualObject.geometry = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0.1)
        virtualObject.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        virtualObject.geometry?.firstMaterial?.specular.contents = UIColor.orange
        let x = randomNumber(firstNum: -1.5, secondNum: 1.5)
        let y = randomNumber(firstNum: -1.5, secondNum: 1.5)
        virtualObject.position = SCNVector3(x,y,-1)
        self.sceneView.scene.rootNode.addChildNode(virtualObject)
    }
    
    func randomNumber(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: sceneView)
            
            let hitList = sceneView.hitTest(location, options: nil)
            
            if let hitObject = hitList.first {
                let node = hitObject.node
                
                if node.name == "virtualObject" {
                    counter += 1
                    node.removeFromParentNode()
                    addObject()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //dispose of any resources that can be recreated
    }
}

