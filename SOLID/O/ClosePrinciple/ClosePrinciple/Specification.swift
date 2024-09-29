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

struct AnySpecification<T>: Specification {
    private let _isSatisfied: (T) -> Bool
    
    init<S: Specification>(_ specification: S) where S.T == T {
        self._isSatisfied = specification.isSatisfied
    }
    
    init(_ closure: @escaping (T) -> Bool) {
            self._isSatisfied = closure
        }
    
    func isSatisfied(_ item: T) -> Bool {
        return _isSatisfied(item)
    }
}
