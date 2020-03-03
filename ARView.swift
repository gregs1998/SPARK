//
//  ARView.swift
//  
//
//  Created by Greg Schloemer on 2/17/20.
//

import SwiftUI

struct ARView: View {
    
    let steps: NSOrderedSet
    
    var body: some View {
        CustomController(steps: steps)
    }
}

//struct ARView_Previews: PreviewProvider {
//    static var previews: some View {
//        ARView()
//    }
//}

struct CustomController: UIViewControllerRepresentable {
    
    let steps: NSOrderedSet
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CustomController>) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller: ViewController = storyboard.instantiateViewController(identifier: "arView") as! ViewController
        controller.steps = steps
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CustomController>) {
        //
    }
    
}
