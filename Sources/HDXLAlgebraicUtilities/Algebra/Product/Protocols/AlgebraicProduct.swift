//
//  AlgebraicProduct.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct - Definition
// -------------------------------------------------------------------------- //

/// Basic protocol for algebraic products (e.g. "nominally-typed tuples").
///
/// Rarely for direct use; expect, instead, to use the arity-specific protocols
/// that inherit from `AlgebraicProduct`.
///
/// The *reason* we *need* protocols for the product types is b/c it's important
/// to offer them in both (a) "inline" (e.g. flat struct) and (b) "COW" (e.g.
/// storage on heap, implemented as class, wrapped in COW-style struct). Our only
/// useful abstraction tool right now is to "protocolize" each arity and then make
/// types that use/vend products generic in the representation thereof.
///
/// For `Sum` the issue is less urgent b/c *in general* we can safely assume that
/// the constituent types are well-designed--e.g. not too big, not too much ARC
/// traffic, etc.--and thus for any given concrete parameterization of any given
/// `Sum` type, our size is only marginally-larger than the largest constituent
/// and our ARC traffic is only, at-worst, as bad as the worst of its constituents
/// (which, by assumption, we believe will be "not *that* bad").
///
public protocol AlgebraicProduct {
  
  /// Corresponds to the number of values in the product: (A,B) is arity 2, for example.
  static var arity: Int { get }
  
  /// Corresponds to specific positions/slots within this product (e.g. `.a|.b` for arity 2).
  associatedtype ArityPosition: Comparable, Hashable, CaseIterable // TODO: `ArityPositionProtocol`
  
}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct - Support
// -------------------------------------------------------------------------- //

internal extension AlgebraicProduct {
  
  /// Exists to (a) validate the protocols during testing and (b) to document
  /// that this equality *should always hold* (e.g. that that's the intent).
  @inlinable
  static var hasConsistentArities: Bool {
    get {
      return self.arity == ArityPosition.allCases.count
    }
  }
  
}
