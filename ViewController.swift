//
//  ViewController.swift
//  Image Recognition
//
//  Created by Jayven Nhan on 3/20/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    var steps: NSOrderedSet = []
    var currentStep: Step = Step()
    var currentStepIndex = 0
    var node = SCNNode()
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    let fadeDuration: TimeInterval = 5
    let rotateDuration: TimeInterval = 3
    let waitDuration: TimeInterval = 0.5
    
    @IBAction func pressedNext(_ sender: Any) {
        if(currentStepIndex < (steps.array.count - 1)){
            currentStepIndex = currentStepIndex+1
            currentStep = steps.array[currentStepIndex] as! Step
            updateDescriptionLabel()
        } else{
              // Create the alert controller
            let alertController = UIAlertController(title: "You're finished!", message: "You've finished the tutorial. Congrats! Feel free to explore this tutorial more, or go back to choose another.", preferredStyle: .alert)

              // Create the actions
            let okAction = UIAlertAction(title: "Done", style: UIAlertAction.Style.default) {
                  UIAlertAction in
                print("okay")
              }

              // Add the actions
              alertController.addAction(okAction)

              // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func pressedPrev(_ sender: Any) {
        if(currentStepIndex != 0){
            currentStepIndex = currentStepIndex-1
            currentStep = steps.array[currentStepIndex] as! Step
            updateDescriptionLabel()
        }
    }
    
    
    lazy var fadeAndSpinAction: SCNAction = {
        return .sequence([
            .move(by: SCNVector3(0, 0.05, 0), duration: 0),
            .fadeIn(duration: fadeDuration),
            .move(by: SCNVector3(0, -0.05, 0), duration: rotateDuration),
            .move(by: SCNVector3(0, 0, -0.01), duration: rotateDuration),
            .move(by: SCNVector3(0, 0, 0.01), duration: rotateDuration),
            //.rotateBy(x: 0, y: 0, z: CGFloat.pi * 360 / 180, duration: rotateDuration),
            .wait(duration: waitDuration),
            //.fadeOut(duration: fadeDuration)
            ])
    }()
    
    lazy var fadeAction: SCNAction = {
        return .sequence([
            .fadeOpacity(by: 0.8, duration: fadeDuration),
            .wait(duration: waitDuration),
            .fadeOut(duration: fadeDuration)
            ])
    }()
    
    lazy var treeNode: SCNNode = {
        guard let scene = SCNScene(named: "tree.scn"),
            let node = scene.rootNode.childNode(withName: "tree", recursively: false) else { return SCNNode() }
        let scaleFactor = 0.005
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        node.eulerAngles.x = -.pi / 2
        return node
    }()
    
    lazy var resistorNode: SCNNode = {
        guard let scene = SCNScene(named: "resistor2.scn"),
            let node = scene.rootNode.childNode(withName: "resistor2", recursively: false) else { return SCNNode() }
        let scaleFactor  = 0.0002
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        node.eulerAngles.x += -.pi / 2
        node.position = SCNVector3(0.023,0,0.015)
        return node
    }()
    
    lazy var mountainNode: SCNNode = {
        guard let scene = SCNScene(named: "mountain.scn"),
            let node = scene.rootNode.childNode(withName: "mountain", recursively: false) else { return SCNNode() }
        let scaleFactor  = 0.25
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        node.eulerAngles.x += -.pi / 2
        return node
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        configureLighting()
        currentStep = steps.array[0] as! Step
        updateDescriptionLabel()
    }
    
    func updateDescriptionLabel(){
        if(currentStep.wrappedComponentType == "Resistor"){
            sizeLabel.text = "Add a \(currentStep.wrappedResistance)Ω resistor between row \(currentStep.wrappedPos1Row) and row \(currentStep.wrappedPos2Row)"
        } else if (currentStep.wrappedComponentType == "Ground (GND)") {
        sizeLabel.text = "Add Ground (GND) to row \(currentStep.wrappedPos1Row)"
        } else{
            sizeLabel.text = "Add a \(currentStep.wrappedVoltage)V voltage source to row \(currentStep.wrappedPos1Row)"
        }
    }
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetTrackingConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    @IBAction func resetButtonDidTouch(_ sender: UIBarButtonItem) {
        resetTrackingConfiguration()
    }
    
    func resetTrackingConfiguration() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
        self.label.textColor = UIColor.black
        label.text = "Move camera around to detect images"
    }
}

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            guard let imageAnchor = anchor as? ARImageAnchor,
                let imageName = imageAnchor.referenceImage.name else { return }
            
            // TODO: Comment out code
            //            let planeNode = self.getPlaneNode(withReferenceImage: imageAnchor.referenceImage)
            //            planeNode.opacity = 0.0
            //            planeNode.eulerAngles.x = -.pi / 2
            //            planeNode.runAction(self.fadeAction)
            //            node.addChildNode(planeNode)
            
            // TODO: Overlay 3D Object
            let overlayNode = self.getNode(withImageName: imageName)
            overlayNode.opacity = 0
            overlayNode.position.y = 0
            overlayNode.runAction(self.fadeAndSpinAction)
            // overlayNode.runAction(self.fadeAndSpinAction)
            node.addChildNode(overlayNode)
            self.label.textColor = UIColor.black
            self.label.text = "Image detected: \"\(imageName)\""
        }
    }
    
    func getPlaneNode(withReferenceImage image: ARReferenceImage) -> SCNNode {
        let plane = SCNPlane(width: image.physicalSize.width,
                             height: image.physicalSize.height)
        let node = SCNNode(geometry: plane)
        return node
    }
    
    func getNode(withImageName name: String) -> SCNNode {
        //var node = SCNNode()
        //switch name {
        //case "Colorful Spark":
        node = resistorNode
        //case "ColorfulSpark-1":
          //  node = resistorNode
       // case "spark-slanted":
           // node = resistorNode
        //case "Snow Mountain":
          //  node = mountainNode
        //case "Trees In the Dark":
          //  node = treeNode
        //default:
          //  break
        
        return node
    }

}
    

