//
//  HomeView.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/11/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationView{
            VStack{
                Image("sparkLogo")
                NavigationLink(destination: ContentView()) {
                        Text("Tutorials")
                    }
                        .foregroundColor(Color.blue)
                        .font(.system(size: 40))
                        .padding(.horizontal, 35)
                        .padding(.vertical, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 3)
                        )
                Button("", action:{

                })
                Spacer()
            }
        }.onAppear(perform: startSpeech)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

func startSpeech(){
    let speaker = speechModel()
    speaker.speak(textToSay: "Welcome to SPARK, your personal circuit building application.")
    
    //test.JSONstuff()
//    let bob = dispResCode(resVal: "100")
//    print(bob)
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

func dispResCode(resVal: String)->HStack<TupleView<(Text,Text,Text)>>{
    var currentColor = UIColor.black
    var colorName = ""
    var colorListing = "("
    var timesThrough = 0;
    
    var colors: [UIColor] = []
    var colorNames: [String] = []
    
    if(resVal.isEmpty){
        let errorStack = HStack{
            Text("Error")
                .foregroundColor(Color(UIColor.systemPink))
            Text("Error")
            .foregroundColor(Color(UIColor.systemPink))
            Text("Error")
            .foregroundColor(Color(UIColor.systemPink))
        }
        return errorStack
    }
    
    for char in resVal{
        switch char{
        case "0":
            currentColor = UIColor.black
            colorName = "Black"
        case "1":
            currentColor = UIColor.brown
            colorName = "Brown"
        case "2":
            currentColor = UIColor.red
            colorName = "Red"
        case "3":
            currentColor = UIColor.orange
            colorName = "Orange"
        case "4":
            currentColor = UIColor.yellow
            colorName = "Yellow"
        case "5":
            currentColor = UIColor.green
            colorName = "Green"
        case "6":
            currentColor = UIColor.blue
            colorName = "Blue"
        case "7":
            currentColor = UIColor.purple
            colorName = "Purple"
        case "8":
            currentColor = UIColor.gray
            colorName = "Gray"
        default:
            currentColor = UIColor.white
            colorName = "White"
        }
        colorListing += colorName
        colorListing += " "
        timesThrough += 1
        colors.append(currentColor)
        colorNames.append(colorName)
        if(timesThrough == 2){
            break
        }
    }
    
    switch (resVal.count - 2){
    case 0:
        currentColor = UIColor.black
        colorName = "Black"
    case 1:
        currentColor = UIColor.brown
        colorName = "Brown"
    case 2:
        currentColor = UIColor.red
        colorName = "Red"
    case 3:
        currentColor = UIColor.orange
        colorName = "Orange"
    case 4:
        currentColor = UIColor.yellow
        colorName = "Yellow"
    case 5:
        currentColor = UIColor.green
        colorName = "Green"
    case 6:
        currentColor = UIColor.blue
        colorName = "Blue"
    case 7:
        currentColor = UIColor.purple
        colorName = "Purple"
    case 8:
        currentColor = UIColor.gray
        colorName = "Gray"
    default:
        currentColor = UIColor.white
        colorName = "White"
    }
    
    
    let lastChar = resVal.last ?? "0"
    
    switch lastChar{
    case "k":
        colorName = "Orange"
        currentColor = UIColor.orange
    case "M":
        colorName = "Blue"
        currentColor = UIColor.blue
    default:
        break
    }
    
    if(resVal.count == 2 && (resVal.last == "k" || resVal.last == "M")){
        colors[1] = UIColor.black
        colorNames[1] = "Black"
        var number = 0
        switch resVal.last{
        case "k":
            number = 3
        default:
            number = 6
        }
        number -= 1
        
        switch number{
        case 0:
            currentColor = UIColor.black
            colorName = "Black"
        case 1:
            currentColor = UIColor.brown
            colorName = "Brown"
        case 2:
            currentColor = UIColor.red
            colorName = "Red"
        case 3:
            currentColor = UIColor.orange
            colorName = "Orange"
        case 4:
            currentColor = UIColor.yellow
            colorName = "Yellow"
        case 5:
            currentColor = UIColor.green
            colorName = "Green"
        case 6:
            currentColor = UIColor.blue
            colorName = "Blue"
        case 7:
            currentColor = UIColor.purple
            colorName = "Purple"
        case 8:
            currentColor = UIColor.gray
            colorName = "Gray"
        default:
            currentColor = UIColor.white
            colorName = "White"
        }
    }
    
    colors.append(currentColor)
    colorNames.append(colorName)
    colorListing += colorName
    colorListing += ")"
    print(colorListing)
    
    let text = HStack{
        Text(colorNames[0])
        .foregroundColor(Color(colors[0]))
        Text(colorNames[1])
        .foregroundColor(Color(colors[1]))
        Text(colorNames[2])
        .foregroundColor(Color(colors[2]))
    }
    
    return text
}


func dispResCodeWorking(resVal: String)->String{
    var currentColor = UIColor.black
    var colorName = ""
    var colorListing = "("
    var timesThrough = 0;
    
    var colors: [UIColor] = []
    var colorNames: [String] = []
        
    for char in resVal{
        switch char{
        case "0":
            currentColor = UIColor.black
            colorName = "Black"
        case "1":
            currentColor = UIColor.brown
            colorName = "Brown"
        case "2":
            currentColor = UIColor.red
            colorName = "Red"
        case "3":
            currentColor = UIColor.orange
            colorName = "Orange"
        case "4":
            currentColor = UIColor.yellow
            colorName = "Yellow"
        case "5":
            currentColor = UIColor.green
            colorName = "Green"
        case "6":
            currentColor = UIColor.blue
            colorName = "Blue"
        case "7":
            currentColor = UIColor.purple
            colorName = "Purple"
        case "8":
            currentColor = UIColor.gray
            colorName = "Gray"
        default:
            currentColor = UIColor.white
            colorName = "White"
        }
        colorListing += colorName
        colorListing += " "
        timesThrough += 1
        colors.append(currentColor)
        colorNames.append(colorName)
        if(timesThrough == 2){
            break
        }
    }
    
    switch (resVal.count - 2){
    case 0:
        currentColor = UIColor.black
        colorName = "Black"
    case 1:
        currentColor = UIColor.brown
        colorName = "Brown"
    case 2:
        currentColor = UIColor.red
        colorName = "Red"
    case 3:
        currentColor = UIColor.orange
        colorName = "Orange"
    case 4:
        currentColor = UIColor.yellow
        colorName = "Yellow"
    case 5:
        currentColor = UIColor.green
        colorName = "Green"
    case 6:
        currentColor = UIColor.blue
        colorName = "Blue"
    case 7:
        currentColor = UIColor.purple
        colorName = "Purple"
    case 8:
        currentColor = UIColor.gray
        colorName = "Gray"
    default:
        currentColor = UIColor.white
        colorName = "White"
    }
    colors.append(currentColor)
    
    let lastChar = resVal.last ?? "0"
    
    switch lastChar{
    case "k":
        colorName = "Orange"
    case "M":
        colorName = "Blue"
    default:
        break
    }
    
    colorNames.append(colorName)
    colorListing += colorName
    colorListing += ")"
    print(colorListing)
    

    
    return colorListing
}
