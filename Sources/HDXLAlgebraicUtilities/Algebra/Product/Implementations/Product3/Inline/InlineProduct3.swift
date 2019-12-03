//
//  InlineProduct3.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: InlineProduct3 - Definition
// -------------------------------------------------------------------------- //

/// Product-3 that stores all values "inline" as a struct.
/// When no types participate in ARC this is usually a good choice; when some
/// or all types participate in ARC the COW implementation may be preferable,
/// but even then it'll be extremely situation-specific.
@frozen
public struct InlineProduct3<A,B,C> {
  
  public var a: A
  public var b: B
  public var c: C
  
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(isValidOrIndifferent(a))
    pedantic_assert(isValidOrIndifferent(b))
    pedantic_assert(isValidOrIndifferent(c))
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self.a = a
    self.b = b
    self.c = c
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: InlineProduct3 - Reflection Support
// -------------------------------------------------------------------------- //

internal extension InlineProduct3 {
  
  @inlinable
  static var shortTypeName: String {
    get {
      return "InlineProduct3"
    }
  }
  
  @inlinable
  static var completeTypeName: String {
    get {
      return "\(self.shortTypeName)<\(self.typeParameterNames)>"
    }
  }
  
  @inlinable
  static var typeParameterNames: String {
    get {
      return [
        String(reflecting: A.self),
        String(reflecting: B.self),
        String(reflecting: C.self)
        ].joined(separator: ", ")
    }
  }
  
  @inlinable
  var componentDescriptions: String {
    get {
      return [
        String(describing: self.a),
        String(describing: self.b),
        String(describing: self.c)
      ].joined(separator: ", ")
    }
  }

  @inlinable
  var componentDebugDescriptions: String {
    get {
      return [
        "a: \(String(reflecting: self.a))",
        "b: \(String(reflecting: self.b))",
        "c: \(String(reflecting: self.c))"
      ].joined(separator: ", ")
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: InlineProduct3 - AlgebraicProduct3
// -------------------------------------------------------------------------- //

extension InlineProduct3 : AlgebraicProduct3 {
  
  public typealias ArityPosition = Arity3Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool {
    get {
      return true
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: InlineProduct3 - Validatable
// -------------------------------------------------------------------------- //

extension InlineProduct3 : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      guard
        isValidOrIndifferent(self.a),
        isValidOrIndifferent(self.b),
        isValidOrIndifferent(self.c) else {
          return false
      }
      return true
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: InlineProduct3 - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension InlineProduct3 : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "(\(self.componentDescriptions))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: InlineProduct3 - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension InlineProduct3 : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "\(type(of: self).completeTypeName)(\(self.componentDebugDescriptions))"
    }
  }
  
}
