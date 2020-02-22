//
//  AddTutorialView.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/11/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import SwiftUI

struct AddTutorialView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    
    var body: some View {
        //NavigationView{
            Form{
                Section{
                    TextField("Tutorial Title", text: $title)
                }
                Section{
                    Button("Save Tutorial"){
                        let newTutorial = Tutorial(context: self.moc)
                        newTutorial.title = self.title
                        
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Tutorial")
        //}
        //.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        AddTutorialView()
    }
}
