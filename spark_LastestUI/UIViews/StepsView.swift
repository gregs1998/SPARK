//
//  StepsView.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/11/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import SwiftUI
import CoreData
import FileProvider

struct StepsView: View {
    // let currentTutorial: Tutorial
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
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
    
    func tutorialToJSON(){
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted

                let data = try encoder.encode(currentTutorial)
                print(String(data: data, encoding: .utf8)!)
                
                let url = self.getDocumentsDirectory().appendingPathComponent("\(currentTutorial.title ?? "tutorial").json")
                
                do {
                    // try String(data:data,encoding:.utf8)!.write
                    try String(data:data,encoding:.utf8)!.write(to: url, atomically: true, encoding: String.Encoding.utf8)
//                    let input = try String(contentsOf: url)
//                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
                
                //print(backAgain.title)
                print("stop")
            } catch {
                print("Error fetching data from CoreData")
            }
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
                        NavigationLink(destination: ARView(steps: currentTutorial.unwrappedStep)){
                            Text("Start in AR")
                            .foregroundColor(Color.blue)
                        }
                    }
                }
            }
            Spacer()
        }
        .navigationBarTitle("Steps")
        .navigationBarItems(trailing: HStack{
            Button(action:{
                self.tutorialToJSON()
            }){Image(systemName: "square.and.arrow.up")
                .foregroundColor(Color.blue)
            }
            Spacer()
            Button(action: {
            self.showingAddScreen.toggle()
        }) {
            Image(systemName: "plus")
        }
        })
        // }
        //.navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: $showingAddScreen){
                AddStepsView(tutorialToAddStep: self.currentTutorial).environment(\.managedObjectContext, self.moc)
        }.onAppear(perform: {
            // print(self.currentTutorial)
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
