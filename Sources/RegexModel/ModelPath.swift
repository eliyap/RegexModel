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
 
    /// Appends `other` as to the end of `self`, removing the leaf `.target` node.
    public func appending(_ other: ModelPath) -> ModelPath {
        switch self {
        case .target:
            /// Special case: tree has depth 1.
            return other
        
        case .child(let index, let subpath):
            switch subpath {
            case .target:
                /// Replace `.target` with new subpath.
                return .child(index: index, subpath: other)
            
            case .child:
                /// Recurse.
                return .child(index: index, subpath: subpath.appending(other))
            }
        }
    }
    
    /// Checks whether one path is "contained" by another.
    /// Paths are considered to contain themselves.
    public func isSubpathOf(_ other: ModelPath) -> Bool {
        switch (self, other) {
        case (.target, .target), (.child, .target):
            return true
        
        case (.target, .child):
            return false
            
        case (.child(let idx, let subpath), .child(let otherIdx, let otherSubpath)):
            guard idx == otherIdx else { return false }
            return subpath.isSubpathOf(otherSubpath)
        }
    }
}

extension ComponentModel {
    public subscript(_ path: ModelPath) -> ComponentModel {
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
    
    /// - Parameters:
    ///   - component: component to insert
    ///   - path: path to insert at
    public mutating func insert(_ component: ComponentModel, at path: ModelPath) -> Void {
        /// Should always be handled by parents or grandparents, never the child directly.
        guard case .child(let index, let subpath) = path else {
            Swift.debugPrint(self)
            fatalError("Illegal state")
        }

        if case .child(_, let childSubpath) = subpath {
            /// Recursively ask child to handle it.
            self[.child(index: index, subpath: .target)].insert(component, at: childSubpath)
            return
        }

        switch self {
        case .string, .anchor:
            fatalError("\(self) has no children to insert into!")
        
        case .zeroOrMore(var params):
            params.components.insert(component, at: index)
            self = .zeroOrMore(params)
            
        case .oneOrMore(var params):
            params.components.insert(component, at: index)
            self = .oneOrMore(params)
            
        case .optionally(var params):
            params.components.insert(component, at: index)
            self = .optionally(params)
            
        case .repeat(var params):
            params.components.insert(component, at: index)
            self = .repeat(params)
            
        case .lookahead(var params):
            params.components.insert(component, at: index)
            self = .lookahead(params)
            
        case .choiceOf(var params):
            params.components.insert(component, at: index)
            self = .choiceOf(params)
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
