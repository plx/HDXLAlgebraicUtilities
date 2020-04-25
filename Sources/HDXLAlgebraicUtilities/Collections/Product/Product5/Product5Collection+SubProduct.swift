//
//  Product5Collection+SubProduct.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Basic API
// -------------------------------------------------------------------------- //

public extension Product5Collection {

  /// Type analogous to subsequence, but for subproducts.
  ///
  /// - note: `COW/Inline`-ness is inherited from base collection--not worth making flexible.
  ///
  typealias SubProduct = Product5Collection<
    A.SubSequence,
    B.SubSequence,
    C.SubSequence,
    D.SubSequence,
    E.SubSequence,
    Position,
    Element
  >
  
  /// Returns the "subproduct"--the product of the slices taken from each factor.
  ///
  /// - parameter a: The range with-which to slice the `a`-factor.
  /// - parameter b: The range with-which to slice the `b`-factor.
  /// - parameter c: The range with-which to slice the `c`-factor.
  /// - parameter d: The range with-which to slice the `d`-factor.
  /// - parameter e: The range with-which to slice the `e`-factor.
  ///
  /// - returns: The product of the slices: `a[a] x b[b] x ... x e[e]` (etc.).
  ///
  @inlinable
  func subproduct(
    a: Range<A.Index>,
    b: Range<B.Index>,
    c: Range<C.Index>,
    d: Range<D.Index>,
    e: Range<E.Index>) -> SubProduct {
    return SubProduct(
      storage: self.storage.subproduct(
        a: a,
        b: b,
        c: c,
        d: d,
        e: e
      )
    )
  }
    
  /// Returns the "subproduct"--the product of the slices taken from each factor.
  ///
  /// - parameter a: The range expression with-which to slice the `a`-factor.
  /// - parameter b: The range expression with-which to slice the `b`-factor.
  /// - parameter c: The range expression with-which to slice the `c`-factor.
  /// - parameter d: The range expression with-which to slice the `d`-factor.
  /// - parameter e: The range expression with-which to slice the `e`-factor.
  ///
  /// - returns: The product of the slices: `a[a] x b[b] x ... x e[e]` (etc.).
  ///
  @inlinable
  func subproduct<
    RA,
    RB,
    RC,
    RD,
    RE>(
    a ra: RA,
    b rb: RB,
    c rc: RC,
    d rd: RD,
    e re: RE) -> SubProduct
    where
    RA:RangeExpression,
    RB:RangeExpression,
    RC:RangeExpression,
    RD:RangeExpression,
    RE:RangeExpression,
    RA.Bound == A.Index,
    RB.Bound == B.Index,
    RC.Bound == C.Index,
    RD.Bound == D.Index,
    RE.Bound == E.Index {
      return SubProduct(
        storage: self.storage.subproduct(
          a: ra,
          b: rb,
          c: rc,
          d: rd,
          e: re
        )
      )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Single-Axis API - A
// -------------------------------------------------------------------------- //

public extension Product5Collection {
  

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

public extension Product5Collection {
  
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

public extension Product5Collection {
  
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

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Single-Axis API - D
// -------------------------------------------------------------------------- //

public extension Product5Collection {
  
  /// Returns a subproduct wherein we only slice along the `d`-axis.
  ///
  /// - parameter d: The range with-which to slice the `d`-factor.
  ///
  /// - returns: The subproduct with `d[d]` instead of `d` (and all others equivalent).
  ///
  /// - note: We only *slice* on `d`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(d: Range<D.Index>) -> SubProduct {
    return SubProduct(
      storage: self.storage.subproduct(
        d: d
      )
    )
  }

  /// Returns a subproduct wherein we only slice along the `d`-axis.
  ///
  /// - parameter d: The range expression with-which to slice the `d`-factor.
  ///
  /// - returns: The subproduct with `d[d]` instead of `d` (and all others equivalent).
  ///
  /// - note: We only *slice* on `d`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RD>(
    d rd: RD) -> SubProduct
    where
    RD:RangeExpression,
    RD.Bound == D.Index {
      return SubProduct(
        storage: self.storage.subproduct(
          d: rd
        )
      )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Single-Axis API - E
// -------------------------------------------------------------------------- //

public extension Product5Collection {
  
  /// Returns a subproduct wherein we only slice along the `e`-axis.
  ///
  /// - parameter e: The range with-which to slice the `e`-factor.
  ///
  /// - returns: The subproduct with `e[e]` instead of `e` (and all others equivalent).
  ///
  /// - note: We only *slice* on `e`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(e: Range<E.Index>) -> SubProduct {
    return SubProduct(
      storage: self.storage.subproduct(
        e: e
      )
    )
  }

  /// Returns a subproduct wherein we only slice along the `e`-axis.
  ///
  /// - parameter d: The range expression with-which to slice the `e`-factor.
  ///
  /// - returns: The subproduct with `e[e]` instead of `e` (and all others equivalent).
  ///
  /// - note: We only *slice* on `e`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RE>(
    e re: RE) -> SubProduct
    where
    RE:RangeExpression,
    RE.Bound == E.Index {
      return SubProduct(
        storage: self.storage.subproduct(
          e: re
        )
      )
  }
  
}
