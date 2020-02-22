//
//  StepsList.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/12/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import SwiftUI

var colors: [UIColor] = []
var colorNames: [String] = []

struct StepsList: View {
    @Environment(\.managedObjectContext) var moc
    var fetchRequest: FetchRequest<Step>
    
    @Binding var isEditing: Bool
    @State private var showEditView = false
    @State private var stepToEdit = Step()
    
    init(tutorial: Tutorial, isEditing: Binding<Bool>) {
        fetchRequest = FetchRequest<Step>(entity: Step.entity(), sortDescriptors: [NSSortDescriptor(key: "stepNum", ascending: true)], predicate: NSPredicate(format: "tutorial == %@", tutorial))
        self._isEditing = isEditing
    }
    
    func deleteStep(at offsets: IndexSet){
        for offset in offsets{
            let step = fetchRequest.wrappedValue[offset]
            for i in (offset+1)..<fetchRequest.wrappedValue.count{
                fetchRequest.wrappedValue[i].stepNum = fetchRequest.wrappedValue[i].stepNum-1
            }
            moc.delete(step)
        }
        try? moc.save()
    }
    
    
    var body: some View {
        List{
            ForEach(fetchRequest.wrappedValue, id:\.self){ step in
                //NavigationLink(destination: StepEditView(step: step)){
//                    StepTextView(step: step)
                HStack(alignment: .center){
                    VStack(alignment: .leading){
                        Text("\(step.wrappedDescrip) (Step #\(step.stepNum))")
                            .fontWeight(.bold)
                            .lineLimit(nil)
                        Text("\(step.wrappedComponentType)")
                        Text("\(step.wrappedPos1Column) \(step.wrappedPos1Row)")
                        if(step.wrappedComponentType == "Resistor"){
                            //colorNames = dispResCode(resVal: step.wrappedResistance)
                            Text("\(step.wrappedPos2Column) \(step.wrappedPos2Row)")
                            Text("\(step.wrappedResistance)Ω")
                            dispResCode(resVal: step.wrappedResistance)
                        }
                        if(step.wrappedComponentType == "Voltage Source (Vcc)"){
                        Text("\(step.wrappedVoltage)V")
                        }
                    }
                    Spacer()
                    Button(action:{
                        self.showEditView.toggle()
                        self.stepToEdit = step
                        }) {
                            Image(systemName: "info.circle")
                    }
                }
                //}
            }.onDelete(perform: deleteStep)
        }
        .sheet(isPresented: $showEditView, content:{
            StepEditView(step: self.stepToEdit)
        })
    }
}

struct StepsList_Previews: PreviewProvider {
    static var previews: some View {
        //StepsList()
        Text("Hello!")
    }
}
