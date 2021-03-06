//
//  Chain4CollectionIndex.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: Chain4CollectionIndex - Definition
// -------------------------------------------------------------------------- //

@frozen
public struct Chain4CollectionIndex<
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection> {
  
  @usableFromInline
  internal typealias Storage = Chain4CollectionIndexStorage<A,B,C,D>

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
  internal static var endIndex: Chain4CollectionIndex<A,B,C,D> {
    get {
      return Chain4CollectionIndex<A,B,C,D>(
        storage: .end
      )
    }
  }
}

// -------------------------------------------------------------------------- //
// MARK: Chain4CollectionIndex - Componentwise Constructors
// -------------------------------------------------------------------------- //

internal extension Chain4CollectionIndex {
  
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

}

// -------------------------------------------------------------------------- //
// MARK: Chain4CollectionIndex - Reflection Support
// -------------------------------------------------------------------------- //

internal extension Chain4CollectionIndex {
  
  @inlinable
  static var shortTypeName: String {
    get {
      return "Chain4CollectionIndex"
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
        String(reflecting: D.self)
      ].joined(separator: ", ")
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain4CollectionIndex - Validatable
// -------------------------------------------------------------------------- //

extension Chain4CollectionIndex : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      return self.storage.isValid
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain4CollectionIndex - Equatable
// -------------------------------------------------------------------------- //

extension Chain4CollectionIndex : Equatable {
  
  @inlinable
  public static func ==(
    lhs: Chain4CollectionIndex<A,B,C,D>,
    rhs: Chain4CollectionIndex<A,B,C,D>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage == rhs.storage
  }

}

// -------------------------------------------------------------------------- //
// MARK: Chain4CollectionIndex - Comparable
// -------------------------------------------------------------------------- //

extension Chain4CollectionIndex : Comparable {
  
  @inlinable
  public static func <(
    lhs: Chain4CollectionIndex<A,B,C,D>,
    rhs: Chain4CollectionIndex<A,B,C,D>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage < rhs.storage
  }
  
  @inlinable
  public static func >(
    lhs: Chain4CollectionIndex<A,B,C,D>,
    rhs: Chain4CollectionIndex<A,B,C,D>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage > rhs.storage
  }
  
  @inlinable
  public static func <=(
    lhs: Chain4CollectionIndex<A,B,C,D>,
    rhs: Chain4CollectionIndex<A,B,C,D>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage <= rhs.storage
  }

  @inlinable
  public static func >=(
    lhs: Chain4CollectionIndex<A,B,C,D>,
    rhs: Chain4CollectionIndex<A,B,C,D>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage >= rhs.storage
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain4CollectionIndex - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain4CollectionIndex : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return self.storage.description
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain4CollectionIndex - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain4CollectionIndex : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "\(type(of: self).completeTypeName)(storage: \(String(reflecting: self.storage)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain4CollectionIndexStorage - Definition
// -------------------------------------------------------------------------- //

@usableFromInline
internal enum Chain4CollectionIndexStorage<
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection> {
  
  @usableFromInline
  internal typealias Position = Sum4<A.Index,B.Index,C.Index,D.Index>
  
  case position(Position)
  case end

}

// -------------------------------------------------------------------------- //
// MARK: Chain4CollectionIndexStorage - Reflection Support
// -------------------------------------------------------------------------- //

internal extension Chain4CollectionIndexStorage {
  
  @inlinable
  static var shortTypeName: String {
    get {
      return "Chain4CollectionIndexStorage"
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
        String(reflecting: D.self)
        ].joined(separator: ", ")
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain4CollectionIndexStorage - Validatable
// -------------------------------------------------------------------------- //

extension Chain4CollectionIndexStorage : Validatable {
  
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
// MARK: Chain4CollectionIndexStorage - Equatable
// -------------------------------------------------------------------------- //

extension Chain4CollectionIndexStorage : Equatable {
  
  @inlinable
  internal static func ==(
    lhs: Chain4CollectionIndexStorage<A,B,C,D>,
    rhs: Chain4CollectionIndexStorage<A,B,C,D>) -> Bool {
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
// MARK: Chain4CollectionIndexStorage - Comparable
// -------------------------------------------------------------------------- //

extension Chain4CollectionIndexStorage : Comparable {
  
  @inlinable
  internal static func <(
    lhs: Chain4CollectionIndexStorage<A,B,C,D>,
    rhs: Chain4CollectionIndexStorage<A,B,C,D>) -> Bool {
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
    lhs: Chain4CollectionIndexStorage<A,B,C,D>,
    rhs: Chain4CollectionIndexStorage<A,B,C,D>) -> Bool {
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
    lhs: Chain4CollectionIndexStorage<A,B,C,D>,
    rhs: Chain4CollectionIndexStorage<A,B,C,D>) -> Bool {
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
    lhs: Chain4CollectionIndexStorage<A,B,C,D>,
    rhs: Chain4CollectionIndexStorage<A,B,C,D>) -> Bool {
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
// MARK: Chain4CollectionIndexStorage - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain4CollectionIndexStorage : CustomStringConvertible {
  
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
// MARK: Chain4CollectionIndexStorage - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension Chain4CollectionIndexStorage : CustomDebugStringConvertible {
  
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
