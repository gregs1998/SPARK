//
//  ChoiceView.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/11/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import SwiftUI

struct ChoiceView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingAlert = false
    
    let tutorial: Tutorial
    
    var body: some View {
        Form{
            NavigationLink(destination: StepsView(currentTutorial: tutorial)){
                Text("Edit Tutorial")
            }
            Button(action:{
                self.showingAlert = true
            }){
                Text("Show in AR")
                    .foregroundColor(Color.blue)
            }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Oops!"), message: Text("AR functionality is not yet implemented, but we're working on it."), dismissButton: .default(Text("Got it!")))
        }
        }.navigationBarTitle("Tutorial \(tutorial.title ?? "Unknown")")
            .onAppear(perform: {
                print(self.tutorial)
                print("break")
            })
    }
}

struct ChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        let tutorial = Tutorial()
        tutorial.title = "Example"
        
        return NavigationView{
            StepsView(currentTutorial: tutorial)
        }
    }
}
