//
//  LeadingStapleValue.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: LeadingStapleValue - Definition
// -------------------------------------------------------------------------- //

/// Struct holding a `value` to which we've stapled a "leading" value.
public struct LeadingStapleValue<Leading,Value> {
  
  public var leading: Leading
  public var value: Value
  
  @inlinable
  public init(
    leading: Leading,
    value: Value) {
    // /////////////////////////////////////////////////////////////////////////
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self.leading = leading
    self.value = value
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LeadingStapleValue - Core API
// -------------------------------------------------------------------------- //

public extension LeadingStapleValue {
  
  @inlinable
  var asTuple: (Leading,Value) {
    get {
      return (
        self.leading,
        self.value
      )
    }
  }
  
}


// -------------------------------------------------------------------------- //
// MARK: LeadingStapleValue - Validatable
// -------------------------------------------------------------------------- //

extension LeadingStapleValue : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      guard
        isValidOrIndifferent(self.leading),
        isValidOrIndifferent(self.value) else {
          return false
      }
      return true
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LeadingStapleValue - Equatable
// -------------------------------------------------------------------------- //

extension LeadingStapleValue : Equatable
  where
  Leading:Equatable,
  Value:Equatable {
      
  @inlinable
  public static func ==(
    lhs: LeadingStapleValue<Leading,Value>,
    rhs: LeadingStapleValue<Leading,Value>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    guard
      lhs.leading == rhs.leading,
      lhs.value == rhs.value else {
        return false
    }
    return true
  }
  
  
}

// -------------------------------------------------------------------------- //
// MARK: LeadingStapleValue - Hashable
// -------------------------------------------------------------------------- //

extension LeadingStapleValue : Hashable
  where
  Leading:Hashable,
  Value:Hashable {

  @inlinable
  public func hash(into hasher: inout Hasher) {
    self.leading.hash(into: &hasher)
    self.value.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LeadingStapleValue - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension LeadingStapleValue : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "(\(String(describing: self.leading)), \(String(describing: self.value)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LeadingStapleValue - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension LeadingStapleValue : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "LeadingStapleValue<\(String(reflecting: Leading.self)),\(String(reflecting: Value.self))>(leading: \(String(reflecting: self.leading)), value: \(String(reflecting: self.value)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LeadingStapleValue - Codable
// -------------------------------------------------------------------------- //

extension LeadingStapleValue : Codable
  where
  Leading:Codable,
  Value:Codable {
  
  // synthesized OK
}

// -------------------------------------------------------------------------- //
// MARK: LeadingStapleValue - Identifiable
// -------------------------------------------------------------------------- //

extension LeadingStapleValue : Identifiable where Value:Identifiable {
  
  public typealias ID = Value.ID
  
  @inlinable
  public var id: ID {
    get {
      return self.value.id
    }
  }
  
}

