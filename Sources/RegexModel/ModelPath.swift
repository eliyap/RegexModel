//
//  ModelPath.swift
//  
//
//  Created by Secret Asian Man Dev on 30/6/22.
//

import Foundation

/// Recursive tree path copied from the PaneLess project.
indirect enum ModelPath {
    case target
    case child(index: Int, subpath: ModelPath)
}

extension ComponentModel {
    subscript(_ path: ModelPath) -> ComponentModel {
        get {
            switch path {
            case .target:
                return self
            
            case .child(let index, let subpath):
                switch self {
                case .string:
                    fatalError("Cannot index into leaf node \(self)")
                
                case .zeroOrMore(let zeroOrMoreParameter):
                    return zeroOrMoreParameter.components[index][subpath]

                case .oneOrMore(let oneOrMoreParameter):
                    return oneOrMoreParameter.components[index][subpath]

                case .optionally(let optionallyParameter):
                    return optionallyParameter.components[index][subpath]

                case .repeat(let repeatParameter):
                    return repeatParameter.components[index][subpath]

                case .choiceOf(let choiceOfParameter):
                    return choiceOfParameter.components[index][subpath]
                }
            }
        }
        set {
            switch path {
            case .target:
                self = newValue
            
            case .child(let index, let subpath):
                switch self {
                case .string:
                    fatalError("Cannot index into leaf node \(self)")

                case .zeroOrMore(var zeroOrMoreParameter):
                    zeroOrMoreParameter.components[index][subpath] = newValue
                    self = .zeroOrMore(zeroOrMoreParameter)
                
                case .oneOrMore(var oneOrMoreParameter):
                    oneOrMoreParameter.components[index][subpath] = newValue
                    self = .oneOrMore(oneOrMoreParameter)

                case .optionally(var optionallyParameter):
                    optionallyParameter.components[index][subpath] = newValue
                    self = .optionally(optionallyParameter)

                case .repeat(var repeatParameter):
                    repeatParameter.components[index][subpath] = newValue
                    self = .repeat(repeatParameter)

                case .choiceOf(var choiceOfParameter):
                    choiceOfParameter.components[index][subpath] = newValue
                    self = .choiceOf(choiceOfParameter)
                }
            }
        }
    }
}
