//
//  Product9Interoperation.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MAR: COWProduct9 <- InlineProduct9
// -------------------------------------------------------------------------- //

public extension COWProduct9 {
  
  /// Equivalent, package-supplied "inline" implementation.
  typealias InlineEquivalent = InlineProduct9<A,B,C,D,E,F,G,H,I>
  
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
// MAR: InlineProduct9 <- COWProduct9
// -------------------------------------------------------------------------- //

public extension InlineProduct9 {
  
  /// Equivalent, package-supplied "COW" implementation.
  typealias COWEquivalent = COWProduct9<A,B,C,D,E,F,G,H,I>
  
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
