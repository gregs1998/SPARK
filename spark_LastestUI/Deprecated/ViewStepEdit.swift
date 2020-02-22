//
//  ViewStepEdit.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/13/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import SwiftUI

struct ViewStepEdit: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var fetchRequest: FetchRequest<Step>
    
    var body: some View {
        ForEach(fetchRequest.wrappedValue, id:\.self){ step in
            NavigationLink(destination: StepEditView(step:step)){
                StepTextView(step: step)
            }
        }.onDelete(perform: deleteStep)
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
}

//struct ViewStepEdit_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewStepEdit()
//    }
//}
