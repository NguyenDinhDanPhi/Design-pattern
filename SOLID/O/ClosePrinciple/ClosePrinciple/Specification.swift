//
//  Specification.swift
//  ClosePrinciple
//
//  Created by dan phi on 23/09/2024.
//

import Foundation

// tách rời điều kiện kiểm tra,iúp định nghĩa tiêu chí kiểm tra một cách linh hoạt
protocol Specification {
    associatedtype T
    func isSatisfied(_ item: T) -> Bool
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

class LevelSpecification: Specification {
    typealias T = Toys
    let level: Level
    init(level: Level) {
        self.level = level
    }
    func isSatisfied(_ item: Toys) -> Bool {
        return item.level == level
    }
}

class AndSpecification<T,
  SpecA: Specification,
  SpecB: Specification> : Specification
  where SpecA.T == SpecB.T, T == SpecA.T, T == SpecB.T
{
  let first: SpecA
  let second: SpecB
  init(_ first: SpecA, _ second: SpecB)
  {
    self.first = first
    self.second = second
  }
  func isSatisfied(_ item: T) -> Bool
  {
    return first.isSatisfied(item) && second.isSatisfied(item)
  }
}

