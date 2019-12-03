//
//  Product4Interoperation.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MAR: COWProduct4 <- InlineProduct4
// -------------------------------------------------------------------------- //

public extension COWProduct4 {
  
  /// Equivalent, package-supplied "inline" implementation.
  typealias InlineEquivalent = InlineProduct4<A,B,C,D>
  
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
// MAR: InlineProduct4 <- COWProduct4
// -------------------------------------------------------------------------- //

public extension InlineProduct4 {
  
  /// Equivalent, package-supplied "COW" implementation.
  typealias COWEquivalent = COWProduct4<A,B,C,D>
  
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
