//
//  Chain9CollectionIndex.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndex - Definition
// -------------------------------------------------------------------------- //

@frozen
public struct Chain9CollectionIndex<
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection,
  F:Collection,
  G:Collection,
  H:Collection,
  I:Collection> {
  
  @usableFromInline
  internal typealias Storage = Chain9CollectionIndexStorage<A,B,C,D,E,F,G,H,I>

  @usableFromInline
  internal typealias Position = Storage.Position

  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(storage.isValid)
    defer { pedantic_assert(storage.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self.storage = storage
  }
  
  @inlinable
  internal init(position: Position) {
    self.init(
      storage: .position(position)
    )
  }
  
  @inlinable
  internal static var endIndex: Chain9CollectionIndex<A,B,C,D,E,F,G,H,I> {
    get {
      return Chain9CollectionIndex<A,B,C,D,E,F,G,H,I>(
        storage: .end
      )
    }
  }
}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndex - Componentwise Constructors
// -------------------------------------------------------------------------- //

internal extension Chain9CollectionIndex {
  
  @usableFromInline
  init(a: A.Index) {
    self.init(position: .a(a))
  }

  @inlinable
  init(b: B.Index) {
    self.init(position: .b(b))
  }

  @inlinable
  init(c: C.Index) {
    self.init(position: .c(c))
  }

  @inlinable
  init(d: D.Index) {
    self.init(position: .d(d))
  }

  @inlinable
  init(e: E.Index) {
    self.init(position: .e(e))
  }

  @inlinable
  init(f: F.Index) {
    self.init(position: .f(f))
  }

  @inlinable
  init(g: G.Index) {
    self.init(position: .g(g))
  }

  @inlinable
  init(h: H.Index) {
    self.init(position: .h(h))
  }

  @inlinable
  init(i: I.Index) {
    self.init(position: .i(i))
  }

}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndex - Reflection Support
// -------------------------------------------------------------------------- //

internal extension Chain9CollectionIndex {
  
  @inlinable
  static var shortTypeName: String {
    get {
      return "Chain9CollectionIndex"
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
        String(reflecting: C.self),
        String(reflecting: D.self),
        String(reflecting: E.self),
        String(reflecting: F.self),
        String(reflecting: G.self),
        String(reflecting: H.self),
        String(reflecting: I.self)
        ].joined(separator: ", ")
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndex - Validatable
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndex : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      return self.storage.isValid
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndex - Equatable
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndex : Equatable {
  
  @inlinable
  public static func ==(
    lhs: Chain9CollectionIndex<A,B,C,D,E,F,G,H,I>,
    rhs: Chain9CollectionIndex<A,B,C,D,E,F,G,H,I>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage == rhs.storage
  }

}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndex - Comparable
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndex : Comparable {
  
  @inlinable
  public static func <(
    lhs: Chain9CollectionIndex<A,B,C,D,E,F,G,H,I>,
    rhs: Chain9CollectionIndex<A,B,C,D,E,F,G,H,I>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage < rhs.storage
  }
  
  @inlinable
  public static func >(
    lhs: Chain9CollectionIndex<A,B,C,D,E,F,G,H,I>,
    rhs: Chain9CollectionIndex<A,B,C,D,E,F,G,H,I>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage > rhs.storage
  }
  
  @inlinable
  public static func <=(
    lhs: Chain9CollectionIndex<A,B,C,D,E,F,G,H,I>,
    rhs: Chain9CollectionIndex<A,B,C,D,E,F,G,H,I>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage <= rhs.storage
  }

  @inlinable
  public static func >=(
    lhs: Chain9CollectionIndex<A,B,C,D,E,F,G,H,I>,
    rhs: Chain9CollectionIndex<A,B,C,D,E,F,G,H,I>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage >= rhs.storage
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndex - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndex : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return self.storage.description
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndex - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndex : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "\(type(of: self).completeTypeName)(storage: \(String(reflecting: self.storage)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndexStorage - Definition
// -------------------------------------------------------------------------- //

@usableFromInline
internal enum Chain9CollectionIndexStorage<
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection,
  F:Collection,
  G:Collection,
  H:Collection,
  I:Collection> {
  
  @usableFromInline
  internal typealias Position = Sum9<A.Index,B.Index,C.Index,D.Index,E.Index,F.Index,G.Index,H.Index,I.Index>
  
  case position(Position)
  case end

}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndexStorage - Reflection Support
// -------------------------------------------------------------------------- //

internal extension Chain9CollectionIndexStorage {
  
  @inlinable
  static var shortTypeName: String {
    get {
      return "Chain9CollectionIndexStorage"
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
        String(reflecting: C.self),
        String(reflecting: D.self),
        String(reflecting: E.self),
        String(reflecting: F.self),
        String(reflecting: G.self),
        String(reflecting: H.self),
        String(reflecting: I.self)
        ].joined(separator: ", ")
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndexStorage - Validatable
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndexStorage : Validatable {
  
  @inlinable
  internal var isValid: Bool {
    get {
      switch self {
      case .position(let position):
        return position.isValid
      case .end:
        return true
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndexStorage - Equatable
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndexStorage : Equatable {
  
  @inlinable
  internal static func ==(
    lhs: Chain9CollectionIndexStorage<A,B,C,D,E,F,G,H,I>,
    rhs: Chain9CollectionIndexStorage<A,B,C,D,E,F,G,H,I>) -> Bool {
    switch (lhs, rhs) {
    case (.position(let l), .position(let r)):
      return l == r
    case (.end, .end):
      return true
    default:
      return false
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndexStorage - Comparable
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndexStorage : Comparable {
  
  @inlinable
  internal static func <(
    lhs: Chain9CollectionIndexStorage<A,B,C,D,E,F,G,H,I>,
    rhs: Chain9CollectionIndexStorage<A,B,C,D,E,F,G,H,I>) -> Bool {
    switch (lhs, rhs) {
    case (.position(let l), .position(let r)):
      return l.isPseudoLessThan(r)
    case (.position(_), .end):
      return true
    case (.end, .position(_)):
      return false
    case (.end, .end):
      return false
    }
  }

  @inlinable
  internal static func >(
    lhs: Chain9CollectionIndexStorage<A,B,C,D,E,F,G,H,I>,
    rhs: Chain9CollectionIndexStorage<A,B,C,D,E,F,G,H,I>) -> Bool {
    switch (lhs, rhs) {
    case (.position(let l), .position(let r)):
      return l.isPseudoGreaterThan(r)
    case (.position(_), .end):
      return false
    case (.end, .position(_)):
      return true
    case (.end, .end):
      return false
    }
  }

  @inlinable
  internal static func <=(
    lhs: Chain9CollectionIndexStorage<A,B,C,D,E,F,G,H,I>,
    rhs: Chain9CollectionIndexStorage<A,B,C,D,E,F,G,H,I>) -> Bool {
    switch (lhs, rhs) {
    case (.position(let l), .position(let r)):
      return l.isPseudoLessThanOrEqual(r)
    case (.position(_), .end):
      return true
    case (.end, .position(_)):
      return false
    case (.end, .end):
      return true
    }
  }

  @inlinable
  internal static func >=(
    lhs: Chain9CollectionIndexStorage<A,B,C,D,E,F,G,H,I>,
    rhs: Chain9CollectionIndexStorage<A,B,C,D,E,F,G,H,I>) -> Bool {
    switch (lhs, rhs) {
    case (.position(let l), .position(let r)):
      return l.isPseudoGreaterThanOrEqual(r)
    case (.position(_), .end):
      return false
    case (.end, .position(_)):
      return true
    case (.end, .end):
      return true
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndexStorage - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndexStorage : CustomStringConvertible {
  
  @inlinable
  internal var description: String {
    get {
      switch self {
      case .position(let position):
        return ".position(\(String(describing: position)))"
      case .end:
        return ".end"
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndexStorage - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndexStorage : CustomDebugStringConvertible {
  
  @inlinable
  internal var debugDescription: String {
    get {
      switch self {
      case .position(let position):
        return "\(type(of: self).completeTypeName).position(\(String(reflecting: position)))"
      case .end:
        return "\(type(of: self).completeTypeName).end"
      }
    }
  }
  
}
