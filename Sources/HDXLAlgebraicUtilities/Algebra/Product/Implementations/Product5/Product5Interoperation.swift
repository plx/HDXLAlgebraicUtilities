//
//  Product5Interoperation.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MAR: COWProduct5 <- InlineProduct5
// -------------------------------------------------------------------------- //

public extension COWProduct5 {
  
  /// Equivalent, package-supplied "inline" implementation.
  typealias InlineEquivalent = InlineProduct5<A,B,C,D,E>
  
  /// Direct conversion from compatible equivalent.
  /// Exists to *perhaps* be more-efficient than protocol-default componentwise initializer.
  @inlinable
  init(_ other: InlineEquivalent) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(other.isValid)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self.init(
      storage: Storage(
        storage: other
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MAR: InlineProduct5 <- COWProduct5
// -------------------------------------------------------------------------- //

public extension InlineProduct5 {
  
  /// Equivalent, package-supplied "COW" implementation.
  typealias COWEquivalent = COWProduct5<A,B,C,D,E>
  
  /// Direct conversion from compatible equivalent.
  /// Exists to *perhaps* be more-efficient than protocol-default componentwise initializer.
  @inlinable
  init(_ other: COWEquivalent) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(other.isValid)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self = other.storage.storage
  }
  
}
