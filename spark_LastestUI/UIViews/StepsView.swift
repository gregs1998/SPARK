//
//  StepsView.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/11/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import SwiftUI
import CoreData

struct StepsView: View {
    // let currentTutorial: Tutorial
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingAlert = false
    @State private var isEditing = false
    
    let currentTutorial: Tutorial
    
    @State private var showingAddScreen = false
    
    func deleteStep(at offsets: IndexSet){
        for offset in offsets{
            let step = currentTutorial.step![offset] as! NSManagedObject
            moc.delete(step)
        }
        try? moc.save()
        self.presentationMode.wrappedValue.dismiss()
        
    }
    
    var body: some View {
        // NavigationView{
        VStack{
            Form{
                Section{
                    StepsList(tutorial: currentTutorial, isEditing: self.$isEditing)
                }
                Section{
                    VStack{
                        NavigationLink(destination: ARView()){
                            Text("Start in AR")
                            .foregroundColor(Color.blue)
                        }
                    }
                }
            }
            Spacer()
        }
        .navigationBarTitle("Steps")
        .navigationBarItems(trailing:
            Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            }
        )
        // }
        //.navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: $showingAddScreen){
                AddStepsView(tutorialToAddStep: self.currentTutorial).environment(\.managedObjectContext, self.moc)
        }.onAppear(perform: {
            print(self.currentTutorial)
            print("stop here")
        })
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        let tutorial = Tutorial()
        tutorial.title = "Example"
        
        return NavigationView{
            StepsView(currentTutorial: tutorial)
        }
    }
}
