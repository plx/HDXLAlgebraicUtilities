//
//  Product7Interoperation.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MAR: COWProduct7 <- InlineProduct7
// -------------------------------------------------------------------------- //

public extension COWProduct7 {
  
  /// Equivalent, package-supplied "inline" implementation.
  typealias InlineEquivalent = InlineProduct7<A,B,C,D,E,F,G>
  
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
// MAR: InlineProduct7 <- COWProduct7
// -------------------------------------------------------------------------- //

public extension InlineProduct7 {
  
  /// Equivalent, package-supplied "COW" implementation.
  typealias COWEquivalent = COWProduct7<A,B,C,D,E,F,G>
  
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
