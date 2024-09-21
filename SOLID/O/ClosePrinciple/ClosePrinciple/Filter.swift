//
//  Filter.swift
//  ClosePrinciple
//
//  Created by dan phi on 21/09/2024.
//

import Foundation

enum Level: String {
    case easy = "easy"
    case medium = "medium"
    case difficult = "difficult"
}

enum Shape: String {
    case circle = "circle"
    case square = "square"
    case retangle = "retangle"
}

class Toys
{
  var name: String
  var shape: Shape
  var level: Level

  init(_ name: String, _ shape: Shape, _ level: Level)
  {
    self.name = name
    self.shape = shape
    self.level = level
  }
}

// tách rời điều kiện kiểm tra,iúp định nghĩa tiêu chí kiểm tra một cách linh hoạt
protocol Specification {
    associatedtype T
    func isSatisfied(_ item: T) -> Bool
}


protocol Filter {
    associatedtype T
    func filter<Spec: Specification>(_ item: [T], _ spec: Spec) -> [T] where Spec.T == T;
}

class ShapeSpecification: Specification {
    
    typealias T = Toys
    let shape: Shape
    init(shape: Shape) {
        self.shape = shape
    }
    func isSatisfied(_ item: Toys) -> Bool {
        return item.shape == shape
    }
}
