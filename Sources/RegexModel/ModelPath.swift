//
//  ModelPath.swift
//  
//
//  Created by Secret Asian Man Dev on 30/6/22.
//

import Foundation

/// Recursive tree path copied from the PaneLess project.
public indirect enum ModelPath {
    case target
    case child(index: Int, subpath: ModelPath)
    
    public func appending(_ other: ModelPath) -> ModelPath {
        switch self {
        case .target:
            return other
        case .child(let index, let subpath):
            switch subpath {
            case .target:
                return .child(index: index, subpath: other)
            case .child:
                return .child(index: index, subpath: subpath.appending(other))
            }
        }
    }
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

                case .anchor:
                    fatalError("Cannot index into leaf node \(self)")
                
                case .zeroOrMore(let zeroOrMoreParameter):
                    return zeroOrMoreParameter.components[index][subpath]

                case .oneOrMore(let oneOrMoreParameter):
                    return oneOrMoreParameter.components[index][subpath]

                case .optionally(let optionallyParameter):
                    return optionallyParameter.components[index][subpath]

                case .repeat(let repeatParameter):
                    return repeatParameter.components[index][subpath]

                case .lookahead(let lookaheadParameter):
                    return lookaheadParameter.components[index][subpath]

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

                case .anchor:
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

                case .lookahead(var lookaheadParameter):
                    lookaheadParameter.components[index][subpath] = newValue
                    self = .lookahead(lookaheadParameter)
                
                case .choiceOf(var choiceOfParameter):
                    choiceOfParameter.components[index][subpath] = newValue
                    self = .choiceOf(choiceOfParameter)
                }
            }
        }
    }
}

public extension ComponentModel {
    /// Finds the path of the component with given `id`, if any.
    func path(for id: String) -> ModelPath? {
        if id == self.id {
            return .target
        }
        
        let components: [ComponentModel]
        
        switch self {
        case .string:
            return nil
        
        case .anchor:
            return nil
        
        case .zeroOrMore(let zeroOrMoreParameter):
            components = zeroOrMoreParameter.components
        
        case .oneOrMore(let oneOrMoreParameter):
            components = oneOrMoreParameter.components
        
        case .optionally(let optionallyParameter):
            components = optionallyParameter.components
        
        case .repeat(let repeatParameter):
            components = repeatParameter.components
        
        case .lookahead(let lookaheadParameter):
            components = lookaheadParameter.components
        
        case .choiceOf(let choiceOfParameter):
            components = choiceOfParameter.components
        }
        
        for (idx, child) in components.enumerated() {
            guard let subPath = child.path(for: id) else { continue }
            return .child(index: idx, subpath: subPath)
        }
        
        return nil
    }
}
