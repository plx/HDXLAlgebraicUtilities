//
//  Chain2CollectionIndex.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndex - Definition
// -------------------------------------------------------------------------- //

@frozen
public struct Chain2CollectionIndex<
  A:Collection,
  B:Collection> {
  
  @usableFromInline
  internal typealias Storage = Chain2CollectionIndexStorage<A,B>

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
  internal static var endIndex: Chain2CollectionIndex<A,B> {
    get {
      return Chain2CollectionIndex<A,B>(
        storage: .end
      )
    }
  }
}

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndex - Componentwise Constructors
// -------------------------------------------------------------------------- //

internal extension Chain2CollectionIndex {
  
  @usableFromInline
  init(a: A.Index) {
    self.init(position: .a(a))
  }

  @inlinable
  init(b: B.Index) {
    self.init(position: .b(b))
  }

}

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndex - Reflection Support
// -------------------------------------------------------------------------- //

internal extension Chain2CollectionIndex {
  
  @inlinable
  static var shortTypeName: String {
    get {
      return "Chain2CollectionIndex"
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
        String(reflecting: B.self)
        ].joined(separator: ", ")
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndex - Validatable
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndex : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      return self.storage.isValid
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndex - Equatable
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndex : Equatable {
  
  @inlinable
  public static func ==(
    lhs: Chain2CollectionIndex<A,B>,
    rhs: Chain2CollectionIndex<A,B>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage == rhs.storage
  }

}

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndex - Comparable
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndex : Comparable {
  
  @inlinable
  public static func <(
    lhs: Chain2CollectionIndex<A,B>,
    rhs: Chain2CollectionIndex<A,B>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage < rhs.storage
  }
  
  @inlinable
  public static func >(
    lhs: Chain2CollectionIndex<A,B>,
    rhs: Chain2CollectionIndex<A,B>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage > rhs.storage
  }
  
  @inlinable
  public static func <=(
    lhs: Chain2CollectionIndex<A,B>,
    rhs: Chain2CollectionIndex<A,B>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage <= rhs.storage
  }

  @inlinable
  public static func >=(
    lhs: Chain2CollectionIndex<A,B>,
    rhs: Chain2CollectionIndex<A,B>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage >= rhs.storage
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndex - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndex : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return self.storage.description
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndex - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndex : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "\(type(of: self).completeTypeName)(storage: \(String(reflecting: self.storage)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndexStorage - Definition
// -------------------------------------------------------------------------- //

@usableFromInline
internal enum Chain2CollectionIndexStorage<
  A:Collection,
  B:Collection> {
  
  @usableFromInline
  internal typealias Position = Sum2<A.Index,B.Index>
  
  case position(Position)
  case end

}

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndexStorage - Reflection Support
// -------------------------------------------------------------------------- //

internal extension Chain2CollectionIndexStorage {
  
  @inlinable
  static var shortTypeName: String {
    get {
      return "Chain2CollectionIndexStorage"
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
        String(reflecting: B.self)
        ].joined(separator: ", ")
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndexStorage - Validatable
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndexStorage : Validatable {
  
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
// MARK: Chain2CollectionIndexStorage - Equatable
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndexStorage : Equatable {
  
  @inlinable
  internal static func ==(
    lhs: Chain2CollectionIndexStorage<A,B>,
    rhs: Chain2CollectionIndexStorage<A,B>) -> Bool {
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
// MARK: Chain2CollectionIndexStorage - Comparable
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndexStorage : Comparable {
  
  @inlinable
  internal static func <(
    lhs: Chain2CollectionIndexStorage<A,B>,
    rhs: Chain2CollectionIndexStorage<A,B>) -> Bool {
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
    lhs: Chain2CollectionIndexStorage<A,B>,
    rhs: Chain2CollectionIndexStorage<A,B>) -> Bool {
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
    lhs: Chain2CollectionIndexStorage<A,B>,
    rhs: Chain2CollectionIndexStorage<A,B>) -> Bool {
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
    lhs: Chain2CollectionIndexStorage<A,B>,
    rhs: Chain2CollectionIndexStorage<A,B>) -> Bool {
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
// MARK: Chain2CollectionIndexStorage - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndexStorage : CustomStringConvertible {
  
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
// MARK: Chain2CollectionIndexStorage - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndexStorage : CustomDebugStringConvertible {
  
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
