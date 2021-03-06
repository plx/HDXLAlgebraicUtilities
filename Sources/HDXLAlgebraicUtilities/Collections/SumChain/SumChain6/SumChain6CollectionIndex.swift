//
//  SumChain6CollectionIndex.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: SumChain6CollectionIndex - Definition
// -------------------------------------------------------------------------- //

@frozen
public struct SumChain6CollectionIndex<
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection,
  F:Collection> {
  
  @usableFromInline
  internal typealias Storage = SumChain6CollectionIndexStorage<A,B,C,D,E,F>

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
  internal static var endIndex: SumChain6CollectionIndex<A,B,C,D,E,F> {
    get {
      return SumChain6CollectionIndex<A,B,C,D,E,F>(
        storage: .end
      )
    }
  }
}

// -------------------------------------------------------------------------- //
// MARK: SumChain6CollectionIndex - Componentwise Constructors
// -------------------------------------------------------------------------- //

internal extension SumChain6CollectionIndex {
  
  @inlinable
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

}

// -------------------------------------------------------------------------- //
// MARK: SumChain6CollectionIndex - Reflection Support
// -------------------------------------------------------------------------- //

internal extension SumChain6CollectionIndex {
  
  @inlinable
  static var shortTypeName: String {
    get {
      return "SumChain6CollectionIndex"
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
        String(reflecting: F.self)
        ].joined(separator: ", ")
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain6CollectionIndex - Validatable
// -------------------------------------------------------------------------- //

extension SumChain6CollectionIndex : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      return self.storage.isValid
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain6CollectionIndex - Equatable
// -------------------------------------------------------------------------- //

extension SumChain6CollectionIndex : Equatable {
  
  @inlinable
  public static func ==(
    lhs: SumChain6CollectionIndex<A,B,C,D,E,F>,
    rhs: SumChain6CollectionIndex<A,B,C,D,E,F>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage == rhs.storage
  }

}

// -------------------------------------------------------------------------- //
// MARK: SumChain6CollectionIndex - Comparable
// -------------------------------------------------------------------------- //

extension SumChain6CollectionIndex : Comparable {
  
  @inlinable
  public static func <(
    lhs: SumChain6CollectionIndex<A,B,C,D,E,F>,
    rhs: SumChain6CollectionIndex<A,B,C,D,E,F>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage < rhs.storage
  }
  
  @inlinable
  public static func >(
    lhs: SumChain6CollectionIndex<A,B,C,D,E,F>,
    rhs: SumChain6CollectionIndex<A,B,C,D,E,F>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage > rhs.storage
  }
  
  @inlinable
  public static func <=(
    lhs: SumChain6CollectionIndex<A,B,C,D,E,F>,
    rhs: SumChain6CollectionIndex<A,B,C,D,E,F>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage <= rhs.storage
  }

  @inlinable
  public static func >=(
    lhs: SumChain6CollectionIndex<A,B,C,D,E,F>,
    rhs: SumChain6CollectionIndex<A,B,C,D,E,F>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage >= rhs.storage
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain6CollectionIndex - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension SumChain6CollectionIndex : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return self.storage.description
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain6CollectionIndex - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension SumChain6CollectionIndex : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "\(type(of: self).completeTypeName)(storage: \(String(reflecting: self.storage)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain6CollectionIndexStorage - Definition
// -------------------------------------------------------------------------- //

@usableFromInline
internal enum SumChain6CollectionIndexStorage<
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection,
  F:Collection> {
  
  @usableFromInline
  internal typealias Position = Sum6<A.Index,B.Index,C.Index,D.Index,E.Index,F.Index>
  
  case position(Position)
  case end

}

// -------------------------------------------------------------------------- //
// MARK: SumChain6CollectionIndexStorage - Reflection Support
// -------------------------------------------------------------------------- //

internal extension SumChain6CollectionIndexStorage {
  
  @inlinable
  static var shortTypeName: String {
    get {
      return "SumChain6CollectionIndexStorage"
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
        String(reflecting: F.self)
        ].joined(separator: ", ")
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain6CollectionIndexStorage - Validatable
// -------------------------------------------------------------------------- //

extension SumChain6CollectionIndexStorage : Validatable {
  
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
// MARK: SumChain6CollectionIndexStorage - Equatable
// -------------------------------------------------------------------------- //

extension SumChain6CollectionIndexStorage : Equatable {
  
  @inlinable
  internal static func ==(
    lhs: SumChain6CollectionIndexStorage<A,B,C,D,E,F>,
    rhs: SumChain6CollectionIndexStorage<A,B,C,D,E,F>) -> Bool {
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
// MARK: SumChain6CollectionIndexStorage - Comparable
// -------------------------------------------------------------------------- //

extension SumChain6CollectionIndexStorage : Comparable {
  
  @inlinable
  internal static func <(
    lhs: SumChain6CollectionIndexStorage<A,B,C,D,E,F>,
    rhs: SumChain6CollectionIndexStorage<A,B,C,D,E,F>) -> Bool {
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
    lhs: SumChain6CollectionIndexStorage<A,B,C,D,E,F>,
    rhs: SumChain6CollectionIndexStorage<A,B,C,D,E,F>) -> Bool {
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
    lhs: SumChain6CollectionIndexStorage<A,B,C,D,E,F>,
    rhs: SumChain6CollectionIndexStorage<A,B,C,D,E,F>) -> Bool {
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
    lhs: SumChain6CollectionIndexStorage<A,B,C,D,E,F>,
    rhs: SumChain6CollectionIndexStorage<A,B,C,D,E,F>) -> Bool {
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
// MARK: SumChain6CollectionIndexStorage - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension SumChain6CollectionIndexStorage : CustomStringConvertible {
  
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
// MARK: SumChain6CollectionIndexStorage - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension SumChain6CollectionIndexStorage : CustomDebugStringConvertible {
  
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
