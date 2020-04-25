//
//  Product3Collection+SubProduct.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Basic API
// -------------------------------------------------------------------------- //

public extension Product3Collection {

  /// Type analogous to subsequence, but for subproducts.
  ///
  /// - note: `COW/Inline`-ness is inherited from base collection--not worth making flexible.
  ///
  typealias SubProduct = Product3Collection<
    A.SubSequence,
    B.SubSequence,
    C.SubSequence,
    Position,
    Element
  >
  
  /// Returns the "subproduct"--the product of the slices taken from each factor.
  ///
  /// - parameter a: The range with-which to slice the `a`-factor.
  /// - parameter b: The range with-which to slice the `b`-factor.
  /// - parameter c: The range with-which to slice the `c`-factor.
  ///
  /// - returns: The product of the slices: `a[a] x b[b] x c[c]` (etc.).
  ///
  @inlinable
  func subproduct(
    a: Range<A.Index>,
    b: Range<B.Index>,
    c: Range<C.Index>) -> SubProduct {
    return SubProduct(
      storage: self.storage.subproduct(
        a: a,
        b: b,
        c: c
      )
    )
  }
    
  /// Returns the "subproduct"--the product of the slices taken from each factor.
  ///
  /// - parameter a: The range expression with-which to slice the `a`-factor.
  /// - parameter b: The range expression with-which to slice the `b`-factor.
  /// - parameter c: The range expression with-which to slice the `c`-factor.
  ///
  /// - returns: The product of the slices: `a[a] x b[b] x c[c]` (etc.).
  ///
  @inlinable
  func subproduct<
    RA,
    RB,
    RC>(
    a ra: RA,
    b rb: RB,
    c rc: RC) -> SubProduct
    where
    RA:RangeExpression,
    RB:RangeExpression,
    RC:RangeExpression,
    RA.Bound == A.Index,
    RB.Bound == B.Index,
    RC.Bound == C.Index {
      return SubProduct(
        storage: self.storage.subproduct(
          a: ra,
          b: rb,
          c: rc
        )
      )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Single-Axis API - A
// -------------------------------------------------------------------------- //

public extension Product3Collection {
  

  /// Returns a subproduct wherein we only slice along the `a`-axis.
  ///
  /// - parameter a: The range with-which to slice the `a`-factor.
  ///
  /// - returns: The subproduct with `a[a]` instead of `a` (and all others equivalent).
  ///
  /// - note: We only *slice* on `a`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(a: Range<A.Index>) -> SubProduct {
    return SubProduct(
      storage: self.storage.subproduct(
        a: a
      )
    )
  }

  /// Returns a subproduct wherein we only slice along the `a`-axis.
  ///
  /// - parameter a: The range expression with-which to slice the `a`-factor.
  ///
  /// - returns: The subproduct with `a[a]` instead of `a` (and all others equivalent).
  ///
  /// - note: We only *slice* on `a`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RA>(
    a ra: RA) -> SubProduct
    where
    RA:RangeExpression,
    RA.Bound == A.Index {
      return SubProduct(
        storage: self.storage.subproduct(
          a: ra
        )
      )
  }

}

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Single-Axis API - B
// -------------------------------------------------------------------------- //

public extension Product3Collection {
  
  /// Returns a subproduct wherein we only slice along the `b`-axis.
  ///
  /// - parameter b: The range with-which to slice the `b`-factor.
  ///
  /// - returns: The subproduct with `b[b]` instead of `b` (and all others equivalent).
  ///
  /// - note: We only *slice* on `b`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(b: Range<B.Index>) -> SubProduct {
    return SubProduct(
      storage: self.storage.subproduct(
        b: b
      )
    )
  }

  /// Returns a subproduct wherein we only slice along the `b`-axis.
  ///
  /// - parameter b: The range expression with-which to slice the `b`-factor.
  ///
  /// - returns: The subproduct with `b[b]` instead of `b` (and all others equivalent).
  ///
  /// - note: We only *slice* on `b`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RB>(
    b rb: RB) -> SubProduct
    where
    RB:RangeExpression,
    RB.Bound == B.Index {
      return SubProduct(
        storage: self.storage.subproduct(
          b: rb
        )
      )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Single-Axis API - C
// -------------------------------------------------------------------------- //

public extension Product3Collection {
  
  /// Returns a subproduct wherein we only slice along the `c`-axis.
  ///
  /// - parameter c: The range with-which to slice the `c`-factor.
  ///
  /// - returns: The subproduct with `c[c]` instead of `c` (and all others equivalent).
  ///
  /// - note: We only *slice* on `c`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(c: Range<C.Index>) -> SubProduct {
    return SubProduct(
      storage: self.storage.subproduct(
        c: c
      )
    )
  }

  /// Returns a subproduct wherein we only slice along the `c`-axis.
  ///
  /// - parameter c: The range expression with-which to slice the `c`-factor.
  ///
  /// - returns: The subproduct with `c[c]` instead of `c` (and all others equivalent).
  ///
  /// - note: We only *slice* on `c`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RC>(
    c rc: RC) -> SubProduct
    where
    RC:RangeExpression,
    RC.Bound == C.Index {
      return SubProduct(
        storage: self.storage.subproduct(
          c: rc
        )
      )
  }
  
}
