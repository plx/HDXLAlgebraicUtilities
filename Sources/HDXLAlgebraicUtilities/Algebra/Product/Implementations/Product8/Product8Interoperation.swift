//
//  Product8Interoperation.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MAR: COWProduct8 <- InlineProduct8
// -------------------------------------------------------------------------- //

public extension COWProduct8 {
  
  /// Equivalent, package-supplied "inline" implementation.
  typealias InlineEquivalent = InlineProduct8<A,B,C,D,E,F,G,H>
  
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
// MAR: InlineProduct8 <- COWProduct8
// -------------------------------------------------------------------------- //

public extension InlineProduct8 {
  
  /// Equivalent, package-supplied "COW" implementation.
  typealias COWEquivalent = COWProduct8<A,B,C,D,E,F,G,H>
  
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
