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
    
//    func stepToJSON(){
//            do {
//
////                guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
////                    fatalError("Failed to retrieve managed object context")
////                }
//
//                let jsonData = try JSONEncoder().encode(step)
//                print (jsonData)
//
//                let encoder = JSONEncoder()
//                encoder.outputFormatting = .prettyPrinted
//
//                let data = try encoder.encode(step)
//                print(String(data: data, encoding: .utf8)!)
//
//                let newStep:Step = Step(context: self.moc)
//
////                case tutorial
////                case stepNum
//
//                if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any] {
//                    print(json)
//                    if let pos2Row = json["pos2Row"] as? String{
//                        newStep.pos2Row = pos2Row
//                    }
//                    if let pos1Row = json["pos1Row"] as? String{
//                        newStep.pos1Row = pos1Row
//                    }
//                    if let descrip = json["descrip"] as? String{
//                        newStep.descrip = descrip
//                    }
//                    if let componentType = json["componentType"] as? String{
//                        newStep.componentType = componentType
//                    }
//                    if let pos1Column = json["pos1Column"] as? String{
//                        newStep.pos1Column = pos1Column
//                    }
//                    if let pos2Column = json["pos2Column"] as? String{
//                        newStep.pos2Column = pos2Column
//                    }
//                    if let resistance = json["resistance"] as? String{
//                        newStep.resistance = resistance
//                    }
//                    if let voltage = json["voltage"] as? String{
//                        newStep.voltage = voltage
//                    }
//                    if let id = json["id"] as? UUID{
//                        newStep.id = id
//                    }
//                    if let stepNum = json["stepNum"] as? Int16{
//                        newStep.stepNum = stepNum
//                    }
//                }
//
//                print(newStep)
//
////                let decoder = JSONDecoder(context: self.moc)
////                let newStep = try? decoder.decode([Step].self, from: data)
////                try? moc.save()
////                print(newStep?[0].descrip ?? "error")
//
//            } catch {
//                print("Error fetching step from CoreData")
//            }
//    }
    
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
//                self.stepToJSON()
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
