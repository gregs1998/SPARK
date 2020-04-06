//
//  ViewStepEdit.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/12/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import SwiftUI
import CoreData
import Foundation

struct StepEditView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    let step:Step
    
    func encodeStep(){
        do {
            let jsonData = try JSONEncoder().encode(step)
            print(jsonData)
            print("stop")
        } catch {
            print("Error fetching data from CoreData")
        }
    }
    
    @State private var showError = false
    
    @State private var description = ""
    @State private var pos1Column = ""
    @State private var pos1Row = ""
    @State private var pos2Column = ""
    @State private var pos2Row = ""
    @State private var componentType = ""
    @State private var resistance = ""
    @State private var voltage = ""
    
    let componentTypes = ["Resistor", "Power Source (Vcc)", "Ground (GND)"]
    
    func stepToJSON(){
            do {
                let jsonData = try JSONEncoder().encode(step)
                print (jsonData)
                
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted

                let data = try encoder.encode(step)
                print(String(data: data, encoding: .utf8)!)
                
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = self.moc
                let newStep: Step? = try? decoder.decode(Step.self, from: jsonData)
                print(newStep?.descrip ?? "error")
            } catch {
                print("Error fetching data from CoreData")
            }
    }
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    self.step.descrip = self.description
                    self.step.componentType = self.componentType
                    if(!(self.step.pos1Row == self.pos1Row && self.step.pos1Column == self.pos1Column)){
                        if(self.step.wrappedTutorial.getPositionsConflict(coordinates: "\(self.pos1Column)\(self.pos1Row)")){
                            self.showError = true
                        }
                        else{
                            self.step.pos1Row = self.pos1Row
                            self.step.pos1Column = self.pos1Column
                            self.step.pos2Row = self.pos2Row
                            self.step.pos2Column = self.pos2Column
                            self.step.resistance = self.resistance
                            self.step.voltage = self.voltage
                            try? self.moc.save()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    else{
                        self.step.pos1Row = self.pos1Row
                        self.step.pos1Column = self.pos1Column
                        self.step.pos2Row = self.pos2Row
                        self.step.pos2Column = self.pos2Column
                        self.step.resistance = self.resistance
                        self.step.voltage = self.voltage
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }){
                    Text("Done")
                        .foregroundColor(Color.blue)
                }.padding(.top, 5)
                    .padding(.trailing, 15)
            }
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
                if(self.step.wrappedComponentType == "Resistor"){
                    Section(header: Text("Position 2")){
                        VStack{
                            HStack{
                                TextField("Position 2 Column", text: $pos2Column)
                                    .keyboardType(.alphabet)
                                TextField("Position 2 Row", text: $pos2Row)
                                    .keyboardType(.numberPad)
                            }
                        }
                    }
                    Section(header: Text("Resistance")){
                        HStack{
                            TextField("Resistance", text: $resistance)
                                .keyboardType(.numberPad)
                        }
                    }
                }
                if(self.step.wrappedComponentType == "Voltage Source (Vcc)"){
                    Section(header: Text("Voltage")){
                        HStack{
                            TextField("Voltage", text: $voltage)
                                .keyboardType(.numberPad)
                        }
                    }
                }
            }.onAppear(){
                self.stepToJSON()
            }
        .navigationBarItems(trailing: Button("Done"){
//            self.step.descrip = self.description
//            self.step.componentType = self.componentType
//            if(!(self.step.pos1Row == self.pos1Row && self.step.pos1Column == self.pos1Column)){
//                if(self.step.wrappedTutorial.getPositionsConflict(coordinates: "\(self.pos1Column)\(self.pos1Row)")){
//                    self.showError = true
//                }
//                else{
//                    self.step.pos1Row = self.pos1Row
//                    self.step.pos1Column = self.pos1Column
//                    self.step.pos2Row = self.pos2Row
//                    self.step.pos2Column = self.pos2Column
//                    try? self.moc.save()
//                    self.presentationMode.wrappedValue.dismiss()
//                }
//            }
//            else{
//                self.step.pos1Row = self.pos1Row
//                self.step.pos1Column = self.pos1Column
//                self.step.pos2Row = self.pos2Row
//                self.step.pos2Column = self.pos2Column
//                try? self.moc.save()
//                self.presentationMode.wrappedValue.dismiss()
//            }
        })
            .alert(isPresented: $showError) {
                Alert(title: Text("Position Conflict"), message: Text("You have already added a step with a component at position \(self.pos1Column)\(self.pos1Row)"), dismissButton: .default(Text("OK")){
                    self.showError=false
                    })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            self.description = self.step.wrappedDescrip
            self.componentType = self.step.wrappedComponentType
            self.pos1Row = self.step.wrappedPos1Row
            self.pos1Column = self.step.wrappedPos1Column
            self.pos2Row = self.step.wrappedPos2Row
            self.pos2Column = self.step.wrappedPos2Column
            self.resistance = self.step.wrappedResistance
            self.voltage = self.step.wrappedVoltage
        })
    }
    }
}

//
//struct StepEditView_: PreviewProvider {
//    static var previews: some View {
//        StepEditView()
//    }
//}
