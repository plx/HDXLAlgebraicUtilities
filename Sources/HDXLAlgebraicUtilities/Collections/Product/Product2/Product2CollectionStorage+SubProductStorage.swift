//
//  Product2CollectionStorage+SubProductStorage.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: SubProductStorage - Basic API
// -------------------------------------------------------------------------- //

internal extension Product2CollectionStorage {
  
  /// `SubSequence`-like typealias but for subproduct *storage*.
  @usableFromInline
  typealias SubProductStorage = Product2CollectionStorage<
    A.SubSequence,
    B.SubSequence,
    Position,
    Element
  >

  /// Returns storage for the "subproduct"--the product of the slices taken from each factor.
  ///
  /// - parameter a: The range with-which to slice the `a`-factor.
  /// - parameter b: The range with-which to slice the `b`-factor.
  ///
  /// - returns: The product of the slices: `a[a] x b[b]` (etc.).
  ///
  /// - note: Hope is that I will come back and have these methosd on the *storage* copy over the cached attributes (perhaps with modifications to account for the slicing).
  ///
  @inlinable
  func subproduct(
    a: Range<A.Index>,
    b: Range<B.Index>) -> SubProductStorage {
    return SubProductStorage(
      self.a[a],
      self.b[b]
    )
  }
    
  /// Returns storage for the "subproduct"--the product of the slices taken from each factor.
  ///
  /// - parameter a: The range expression with-which to slice the `a`-factor.
  /// - parameter b: The range expression with-which to slice the `b`-factor.
  ///
  /// - returns: The product of the slices: `a[a] x b[b]` (etc.).
  ///
  /// - note: Hope is that I will come back and have these methosd on the *storage* copy over the cached attributes (perhaps with modifications to account for the slicing).
  ///
  @inlinable
  func subproduct<
    RA,
    RB>(
    a ra: RA,
    b rb: RB) -> SubProductStorage
    where
    RA:RangeExpression,
    RB:RangeExpression,
    RA.Bound == A.Index,
    RB.Bound == B.Index {
      return SubProductStorage(
        self.a[ra.relative(to: self.a)],
        self.b[rb.relative(to: self.b)]
      )
  }

}

// -------------------------------------------------------------------------- //
// MARK: SubProductStorage - Single-Axis API - A
// -------------------------------------------------------------------------- //

internal extension Product2CollectionStorage {
  

  /// Returns storage for a subproduct wherein we only slice along the `a`-axis.
  ///
  /// - parameter a: The range with-which to slice the `a`-factor.
  ///
  /// - returns: The subproduct with `a[a]` instead of `a` (and all others equivalent).
  ///
  /// - note: We only *slice* on `a`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(a: Range<A.Index>) -> SubProductStorage {
    return SubProductStorage(
      self.a[a],
      self.b.completeSubSequence
    )
  }

  /// Returns storage for a subproduct wherein we only slice along the `a`-axis.
  ///
  /// - parameter a: The range expression with-which to slice the `a`-factor.
  ///
  /// - returns: The subproduct with `a[a]` instead of `a` (and all others equivalent).
  ///
  /// - note: We only *slice* on `a`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RA>(
    a ra: RA) -> SubProductStorage
    where
    RA:RangeExpression,
    RA.Bound == A.Index {
      return SubProductStorage(
        self.a[ra.relative(to: self.a)],
        self.b.completeSubSequence
      )
  }

}

// -------------------------------------------------------------------------- //
// MARK: SubProductStorage - Single-Axis API - B
// -------------------------------------------------------------------------- //

internal extension Product2CollectionStorage {
  
  /// Returns storage for a subproduct wherein we only slice along the `b`-axis.
  ///
  /// - parameter b: The range with-which to slice the `b`-factor.
  ///
  /// - returns: The subproduct with `b[b]` instead of `b` (and all others equivalent).
  ///
  /// - note: We only *slice* on `b`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(b: Range<B.Index>) -> SubProductStorage {
    return SubProductStorage(
      self.a.completeSubSequence,
      self.b[b]
    )
  }

  /// Returns storage for a subproduct wherein we only slice along the `b`-axis.
  ///
  /// - parameter a: The range expression with-which to slice the `b`-factor.
  ///
  /// - returns: The subproduct with `b[b]` instead of `b` (and all others equivalent).
  ///
  /// - note: We only *slice* on `b`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RB>(
    b rb: RB) -> SubProductStorage
    where
    RB:RangeExpression,
    RB.Bound == B.Index {
      return SubProductStorage(
        self.a.completeSubSequence,
        self.b[rb.relative(to: self.b)]
      )
  }
  
}
