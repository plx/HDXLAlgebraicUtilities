//
//  StapleValue.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: StapleValue - Definition
// -------------------------------------------------------------------------- //

/// Struct holding a `value` to which we've stapled "leading" and "trailing" values.
public struct StapleValue<Leading,Value,Trailing> {
  
  public var leading: Leading
  public var value: Value
  public var trailing: Trailing
  
  @inlinable
  public init(
    leading: Leading,
    value: Value,
    trailing: Trailing) {
    // /////////////////////////////////////////////////////////////////////////
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self.leading = leading
    self.value = value
    self.trailing = trailing
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: StapleValue - Core API
// -------------------------------------------------------------------------- //

public extension StapleValue {
  
  @inlinable
  var asTuple: (Leading,Value,Trailing) {
    get {
      return (
        self.leading,
        self.value,
        self.trailing
      )
    }
  }
  
}


// -------------------------------------------------------------------------- //
// MARK: StapleValue - Validatable
// -------------------------------------------------------------------------- //

extension StapleValue : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      guard
        isValidOrIndifferent(self.leading),
        isValidOrIndifferent(self.value),
        isValidOrIndifferent(self.trailing) else {
          return false
      }
      return true
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: StapleValue - Equatable
// -------------------------------------------------------------------------- //

extension StapleValue : Equatable
  where
  Leading:Equatable,
  Value:Equatable,
  Trailing:Equatable {
      
  @inlinable
  public static func ==(
    lhs: StapleValue<Leading,Value,Trailing>,
    rhs: StapleValue<Leading,Value,Trailing>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    guard
      lhs.leading == rhs.leading,
      lhs.value == rhs.value,
      lhs.trailing == rhs.trailing else {
        return false
    }
    return true
  }
  
  
}

// -------------------------------------------------------------------------- //
// MARK: StapleValue - Hashable
// -------------------------------------------------------------------------- //

extension StapleValue : Hashable
  where
  Leading:Hashable,
  Value:Hashable,
  Trailing:Hashable {

  @inlinable
  public func hash(into hasher: inout Hasher) {
    self.leading.hash(into: &hasher)
    self.value.hash(into: &hasher)
    self.trailing.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: StapleValue - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension StapleValue : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "(\(String(describing: self.leading)), \(String(describing: self.value)), \(String(describing: self.trailing)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: StapleValue - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension StapleValue : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "StapleValue<\(String(reflecting: Leading.self)),\(String(reflecting: Value.self)),\(String(reflecting: Trailing.self))>(leading: \(String(reflecting: self.leading)), value: \(String(reflecting: self.value)), trailing: \(String(reflecting: self.trailing)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: StapleValue - Codable
// -------------------------------------------------------------------------- //

extension StapleValue : Codable
  where
  Leading:Codable,
  Value:Codable,
  Trailing:Codable {
  
  // synthesized OK
}

// -------------------------------------------------------------------------- //
// MARK: StapleValue - Identifiable
// -------------------------------------------------------------------------- //

extension StapleValue : Identifiable where Value:Identifiable {
  
  public typealias ID = Value.ID
  
  @inlinable
  public var id: ID {
    get {
      return self.value.id
    }
  }
  
}

