//
//  ContentView.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/11/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Tutorial.entity(), sortDescriptors: []) var tutorials: FetchedResults<Tutorial>
    
    enum ActiveSheet {
       case add, browser
    }
    
    @State private var showingSheet = false
    //@State private var showingBrowser = false
    @State private var showingViewChoice = false
    @State private var activeSheet = ActiveSheet.add
    
    func deleteTutorial(at offsets: IndexSet){
        for offset in offsets{
            let tutorial = tutorials[offset]
            moc.delete(tutorial)
        }
        try? moc.save()
    }
    
    var body: some View {
        //NavigationView{
        List{
            ForEach(tutorials, id: \.self) { tutorial in
                NavigationLink(destination: StepsView(currentTutorial: tutorial)){
                    VStack(alignment: .leading){
                        Text(tutorial.title ?? "Unknown")
                            .fontWeight(.bold)
                        Text("Number of steps: \(tutorial.step!.count)")
                    }
                }
            }
            .onDelete(perform: deleteTutorial)
        }
        .navigationBarTitle("Tutorials")
        .navigationBarItems(trailing:
            HStack{
                Button(action:{
                    self.activeSheet = ActiveSheet.browser
                    self.showingSheet.toggle()
                }){Image(systemName: "square.and.arrow.down")
                    .foregroundColor(Color.blue)
                }
                Spacer()
                Button(action: {
                    self.activeSheet = ActiveSheet.add
                    self.showingSheet.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
        )
            .sheet(isPresented: self.$showingSheet){
                if(self.activeSheet == ActiveSheet.add){
            AddTutorialView().environment(\.managedObjectContext, self.moc)
                } else {
                    DocumentPicker().environment(\.managedObjectContext, self.moc)
                }
        }
//        .sheet(isPresented: self.$showingBrowser){
//            DocumentPicker().environment(\.managedObjectContext, self.moc)
//        }
        
    }
    
    
    //}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
