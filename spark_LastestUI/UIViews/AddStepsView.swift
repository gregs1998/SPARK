//
//  StepsView.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/11/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import SwiftUI

struct AddStepsView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var keyboard = KeyboardResponder()

    
    @State private var showError = false
    
    @State private var description = ""
    @State private var pos1Column = ""
    @State private var pos1Row = ""
    @State private var pos2Column = ""
    @State private var pos2Row = ""
    @State private var componentType = ""
    @State private var voltage = ""
    @State private var resistance = ""
    
    let tutorialToAddStep: Tutorial
    
    let componentTypes = ["Resistor", "Voltage Source (Vcc)", "Ground (GND)"]
    
    var body: some View {
        NavigationView{
            //KeyboardGuardian{
            Form{
                Section{
                    TextField("Step Description", text: $description)
                    Picker("Component Type", selection: $componentType){
                        ForEach(componentTypes, id:\.self){
                            Text($0)
                        }
                    }
                }
                Section(header: Text("Position 1")){
                    HStack{
                        TextField("Position 1 Column", text: $pos1Column)
                            .keyboardType(.alphabet)
                        TextField("Position 1 Row", text: $pos1Row)
                            .keyboardType(.numberPad)
                    }
                }
                if(self.componentType == "Resistor"){
                    Section(header: Text("Position 2")){
                        HStack{
                                TextField("Position 2 Column", text: $pos2Column)
                                    .keyboardType(.alphabet)
                                TextField("Position 2 Row", text: $pos2Row)
                                    .keyboardType(.numberPad)
                        }
                    }
                    Section{
                        TextField("Resistance", text: $resistance)
                            .keyboardType(.numberPad)
                    }
                }
                if(self.componentType == "Voltage Source (Vcc)"){
                    Section{
                        TextField("Voltage", text: $voltage)
                            .keyboardType(.numberPad)
                    }
                }
            }.padding()
            .padding(.bottom, keyboard.currentHeight)
            .edgesIgnoringSafeArea(.bottom)
            .animation(.easeOut(duration: 0.16))
            .navigationBarTitle("Add Step")
            .navigationBarItems(trailing: Button("Done"){
                let newStep = Step(context: self.moc)
                //self.tutorialToAddStep.stepCount = self.tutorialToAddStep.stepCount+1
                newStep.descrip = self.description
                newStep.componentType = self.componentType
                newStep.pos1Row = self.pos1Row
                newStep.pos1Column = self.pos1Column
                newStep.pos2Row = self.pos2Row
                newStep.pos2Column = self.pos2Column
                newStep.resistance = self.resistance
                newStep.voltage = self.voltage
                newStep.stepNum = Int16(self.tutorialToAddStep.unwrappedStep.count+1)
                
                if(self.tutorialToAddStep.getPositionsConflict(coordinates: "\(self.pos1Column)\(self.pos1Row)")){
                    self.showError = true
                }else{
                    newStep.tutorial = self.tutorialToAddStep
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Position Conflict"), message: Text("You have already added a step with a component at position \(self.pos1Column)\(self.pos1Row)"), dismissButton: .default(Text("OK")){
                self.showError=false
                })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    //}
}

struct AddStepsView_Previews: PreviewProvider {
    static var previews: some View {
        let tutorial = Tutorial()
        tutorial.title = "Example"
        
        return NavigationView{
            StepsView(currentTutorial: tutorial)
        }
    }
}
