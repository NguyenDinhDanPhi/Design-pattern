//
//  ContentView.swift
//  ClosePrinciple
//
//  Created by dan phi on 21/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State var levelSelection: Level = .easy
    let levelOption: [Level] = [.easy, .medium, .difficult]
    @State var shapeSelection: Shape = .circle
    let shapeOption:[Shape] = [.circle, .rectangle, .square]
    @State var filter = FilterToys()
    @State var isShowFilter = false
    @State var result: [Toys]?
    var toys: [Toys] = [
        Toys(name: "Toy 1", shape: .circle, level: .easy),
        Toys(name: "Toy 2", shape: .rectangle, level: .medium),
        Toys(name: "Toy 3", shape: .square, level: .difficult),
        Toys(name: "Toy 4", shape: .rectangle, level: .easy),
        Toys(name: "Toy 5", shape: .circle, level: .medium),
        Toys(name: "Toy 6", shape: .square, level: .difficult),
        Toys(name: "Toy 7", shape: .circle, level: .easy),
        Toys(name: "Toy 8", shape: .rectangle, level: .medium),
        Toys(name: "Toy 9", shape: .square, level: .difficult),
        Toys(name: "Toy 10", shape: .rectangle, level: .easy),
        Toys(name: "Toy 11", shape: .square, level: .medium),
        Toys(name: "Toy 12", shape: .circle, level: .difficult),
        Toys(name: "Toy 13", shape: .square, level: .easy),
        Toys(name: "Toy 14", shape: .rectangle, level: .medium),
        Toys(name: "Toy 15", shape: .square, level: .difficult)
    ]
    var body: some View {
        VStack {
            Text("List of Toys")
            List(toys, id: \.self) { item in
                Text("\(item.name) - \(item.shape.rawValue) - \(item.level.rawValue)")
            }
            .frame(height: 400)
            Text("Choose Specification to filter")
                .padding(.vertical)
            HStack {
                VStack {
                    Text("Pick level:")
                    Picker(selection: $levelSelection,label: Text("Level")) {
                        ForEach(levelOption, id: \.self) { level in
                            Text("\(level.rawValue)")
                                .tag(level)
                                .frame(width: 200)
                        }
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
                VStack {
                    Text("Pick Shape:")
                    Picker(selection: $shapeSelection,label: Text("Shape")) {
                        ForEach(shapeOption, id: \.self) { shape in
                            Text("\(shape.rawValue)")
                                .tag(shape)
                                .frame(width: 200)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
            }
            Button(action: {
                isShowFilter = true
                result = filter.filter(toys, AndSpecification(LevelSpecification(level: levelSelection), ShapeSpecification(shape: shapeSelection)))
                print("haha \(	result)")
            }, label: {
                Text("FIlter")
            })
            .padding()
            .background(.red)
            .padding(.top)
            
            Text("Toy after FIlter")
            if isShowFilter, let result = result {
                List(result, id: \.self) { item in
                    Text("\(item.name) - \(item.shape.rawValue) - \(item.level.rawValue)")
                }
                .frame(height: 300)
            } else {
                VStack{}.frame(height: 300)
            }
        }
        .padding(.top, 100)
    }
}

#Preview {
    ContentView()
}
