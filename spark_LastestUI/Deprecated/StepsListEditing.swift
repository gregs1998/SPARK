//
//  StepsList.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/12/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import SwiftUI

struct StepsListEditing: View {
    @Environment(\.managedObjectContext) var moc
    var fetchRequest: FetchRequest<Step>
    
    var isEditing:Bool = true

    init(tutorial: Tutorial) {
        fetchRequest = FetchRequest<Step>(entity: Step.entity(), sortDescriptors: [NSSortDescriptor(key: "stepNum", ascending: true)], predicate: NSPredicate(format: "tutorial == %@", tutorial))
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
                    NavigationLink(destination: StepEditView(step: step)){
                    StepTextView(step: step)
//                VStack(alignment: .leading){
//                    Text("\(step.wrappedDescrip) (Step #\(step.stepNum))")
//                        .fontWeight(.bold)
//                    Text("\(step.wrappedComponentType)")
//                    Text("\(step.wrappedPos1Column) \(step.wrappedPos1Row)")
//                    if(step.wrappedComponentType == "Resistor"){
//                        Text("\(step.wrappedPos2Column) \(step.wrappedPos2Row)")
//                    }
//                }
                    }
                }.onDelete(perform: deleteStep)
            }
        }
    }

//struct StepsList_Previews: PreviewProvider {
//    static var previews: some View {
//        //StepsList()
//        Text("Hello!")
//    }
//}
