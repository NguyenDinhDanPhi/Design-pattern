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
    case rectangle = "retangle"
}

protocol Filter {
    associatedtype T
    func filter<Spec: Specification>(_ item: [T], _ spec: Spec) -> [T] where Spec.T == T;
}


class FilterToys: Filter {
    typealias T = Toys
   
    func filter<Spec>(_ item: [Toys], _ spec: Spec) -> [Toys] where Spec : Specification, Toys == Spec.T {
        var result = [Toys]()
        for i in item {
            if spec.isSatisfied(i) {
                result.append(i)
            }
        }
        return result
    }
}
