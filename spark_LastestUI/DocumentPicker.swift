//
//  DocumentPicker.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 4/8/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import SwiftUI
import Foundation
import CoreData

struct DocumentPickerView: UIViewControllerRepresentable {
    
    @Environment(\.managedObjectContext) var moc
    //    @State private var pickedUrl = URL(fileURLWithPath: "")
    
    //    let contents = try Data(contentsOf: urls[0])
    //    _ = jsonToTutorial(data: contents, moc: self.moc)
    //    try? self.moc.save()
    
    func makeCoordinator() -> DocumentPickerView.Coordinator {
        let coordinator = DocumentPickerView.Coordinator(parent1: self)
        return coordinator
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPickerView>) -> UIDocumentPickerViewController {
        
        let picker = UIDocumentPickerViewController(documentTypes: ["public.json"], in: .open)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPickerView>) {
        //
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate{
        
        var parent: DocumentPickerView
        @Environment(\.managedObjectContext) var moc
        
        init(parent1: DocumentPickerView){
            parent = parent1
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]){
            do{
                let contents = try Data(contentsOf: urls[0])
                _ = jsonToTutorial(data: contents, moc: parent.moc)
                try? parent.moc.save()
            } catch{
                print("oops")
            }
        }
    }
}

struct DocumentPicker: View{
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        DocumentPickerView().environment(\.managedObjectContext, self.moc)
    }
}

struct DocumentPicker_Previews: PreviewProvider {
    static var previews: some View {
        DocumentPicker()
    }
}
