//
//  ContentView.swift
//  ClosePrinciple
//
//  Created by dan phi on 21/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State var levelSelection: Level = .none
    let levelOption: [Level] = [.none ,.easy, .medium, .difficult]
    @State var shapeSelection: Shape = .none
    let shapeOption:[Shape] = [.none ,.circle, .rectangle, .square]
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
            .frame(height: 300)
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
                
                var specifications: [AnySpecification<Toys>] = []
                
                // Thêm tiêu chí mức độ nếu không phải là none
                if levelSelection != .none {
                    specifications.append(AnySpecification<Toys> { (toy: Toys) in
                        toy.level == levelSelection
                    })
                }

                if shapeSelection != .none {
                    specifications.append(AnySpecification<Toys> { (toy: Toys) in
                        toy.shape == shapeSelection
                    })
                }
                
                // Xử lý lọc dựa trên số lượng tiêu chí
                switch specifications.count {
                case 0:
                    // Hiển thị tất cả đồ chơi nếu không có tiêu chí nào được chọn
                    result = toys
                case 1:
                    // Áp dụng tiêu chí đầu tiên nếu chỉ có một tiêu chí được chọn
                    result = filter.filter(toys, specifications.first!)
                default:
                    // Kết hợp các tiêu chí bằng AndSpecification và bao bọc trong AnySpecification
                    var combinedSpec = AnySpecification(AndSpecification(specifications[0], specifications[1]))
                    
                    // Kết hợp các tiêu chí bổ sung nếu có nhiều hơn hai
                    for spec in specifications.dropFirst(2) {
                        combinedSpec = AnySpecification(AndSpecification(combinedSpec, spec))
                    }
                    
                    // Lọc đồ chơi bằng tiêu chí kết hợp
                    result = filter.filter(toys, combinedSpec)
                }
            }, label: {
                Text("Filter")
            })
            .padding()
            .frame(width: 100, height: 25)
            .background(.red)
            
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
