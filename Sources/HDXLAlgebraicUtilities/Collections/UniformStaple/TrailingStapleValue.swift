//
//  TrailingStapleValue.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: TrailingStapleValue - Definition
// -------------------------------------------------------------------------- //

/// Struct holding a `value` to which we've stapled a "trailing" value.
public struct TrailingStapleValue<Value,Trailing> {
  
  public var value: Value
  public var trailing: Trailing
  
  @inlinable
  public init(
    value: Value,
    trailing: Trailing) {
    // /////////////////////////////////////////////////////////////////////////
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self.value = value
    self.trailing = trailing
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: TrailingStapleValue - Core API
// -------------------------------------------------------------------------- //

public extension TrailingStapleValue {
  
  @inlinable
  var asTuple: (Value,Trailing) {
    get {
      return (
        self.value,
        self.trailing
      )
    }
  }
  
}


// -------------------------------------------------------------------------- //
// MARK: TrailingStapleValue - Validatable
// -------------------------------------------------------------------------- //

extension TrailingStapleValue : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      guard
        isValidOrIndifferent(self.value),
        isValidOrIndifferent(self.trailing) else {
          return false
      }
      return true
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: TrailingStapleValue - Equatable
// -------------------------------------------------------------------------- //

extension TrailingStapleValue : Equatable
  where
  Value:Equatable,
  Trailing:Equatable {
      
  @inlinable
  public static func ==(
    lhs: TrailingStapleValue<Value,Trailing>,
    rhs: TrailingStapleValue<Value,Trailing>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    guard
      lhs.value == rhs.value,
      lhs.trailing == rhs.trailing else {
        return false
    }
    return true
  }
  
  
}

// -------------------------------------------------------------------------- //
// MARK: TrailingStapleValue - Hashable
// -------------------------------------------------------------------------- //

extension TrailingStapleValue : Hashable
  where
  Value:Hashable,
  Trailing:Hashable {

  @inlinable
  public func hash(into hasher: inout Hasher) {
    self.value.hash(into: &hasher)
    self.trailing.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: TrailingStapleValue - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension TrailingStapleValue : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "(\(String(describing: self.value)), \(String(describing: self.trailing)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: TrailingStapleValue - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension TrailingStapleValue : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "TrailingStapleValue<\(String(reflecting: Value.self)),\(String(reflecting: Trailing.self))>(value: \(String(reflecting: self.value)), trailing: \(String(reflecting: self.trailing)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: TrailingStapleValue - Codable
// -------------------------------------------------------------------------- //

extension TrailingStapleValue : Codable
  where
  Value:Codable,
  Trailing:Codable {
  
  // synthesized OK
}

// -------------------------------------------------------------------------- //
// MARK: TrailingStapleValue - Identifiable
// -------------------------------------------------------------------------- //

extension TrailingStapleValue : Identifiable where Value:Identifiable {
  
  public typealias ID = Value.ID
  
  @inlinable
  public var id: ID {
    get {
      return self.value.id
    }
  }
  
}

