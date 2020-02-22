//
//  StepTextView.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/13/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import SwiftUI

struct StepTextView: View {
    
    let step:Step
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(step.wrappedDescrip) (Step #\(step.stepNum))")
                .fontWeight(.bold)
            Text("\(step.wrappedComponentType)")
            Text("\(step.wrappedPos1Column) \(step.wrappedPos1Row)")
            if(step.wrappedComponentType == "Resistor"){
                Text("\(step.wrappedPos2Column) \(step.wrappedPos2Row)")
            }
        }
    }
}

//struct StepTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        StepTextView()
//    }
//}
