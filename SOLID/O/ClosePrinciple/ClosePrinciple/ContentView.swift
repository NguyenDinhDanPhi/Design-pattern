//
//  ContentView.swift
//  ClosePrinciple
//
//  Created by dan phi on 21/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State var levelSelection = "easy"
    let levelOption = ["easy", "medium", "difficult"]
    @State var shapeSelection = "cirle"
    let shapeOption = ["cirle", "Retangle", "square"]
    
    var body: some View {
        HStack {
            VStack {
                Text("Pick level:")
                Picker(selection: $levelSelection,label: Text("Level")) {
                    ForEach(levelOption, id: \.self) { level in
                        Text("\(level)")
                            .tag("\(level)")
                    }
                }
            }
            .padding(.horizontal, 50)
            Spacer()
            VStack {
                Text("Pick Shape:")
                Picker(selection: $levelSelection,label: Text("Shape")) {
                    ForEach(shapeOption, id: \.self) { shape in
                        Text("\(shape)")
                            .tag("\(shape)")
                    }
                }
            }
            .padding(.horizontal, 50)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
