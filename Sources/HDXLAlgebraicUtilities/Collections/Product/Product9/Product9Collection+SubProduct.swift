//
//  Product9Collection+SubProduct.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Basic API
// -------------------------------------------------------------------------- //

public extension Product9Collection {

  /// Type analogous to subsequence, but for subproducts.
  ///
  /// - note: `COW/Inline`-ness is inherited from base collection--not worth making flexible.
  ///
  typealias SubProduct = Product9Collection<
    A.SubSequence,
    B.SubSequence,
    C.SubSequence,
    D.SubSequence,
    E.SubSequence,
    F.SubSequence,
    G.SubSequence,
    H.SubSequence,
    I.SubSequence,
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
  /// - parameter f: The range with-which to slice the `f`-factor.
  /// - parameter g: The range with-which to slice the `g`-factor.
  /// - parameter h: The range with-which to slice the `h`-factor.
  /// - parameter i: The range with-which to slice the `i`-factor.
  ///
  /// - returns: The product of the slices: `a[a] x b[b] x ... x i[i]` (etc.).
  ///
  @inlinable
  func subproduct(
    a: Range<A.Index>,
    b: Range<B.Index>,
    c: Range<C.Index>,
    d: Range<D.Index>,
    e: Range<E.Index>,
    f: Range<F.Index>,
    g: Range<G.Index>,
    h: Range<H.Index>,
    i: Range<I.Index>) -> SubProduct {
    return SubProduct(
      storage: self.storage.subproduct(
        a: a,
        b: b,
        c: c,
        d: d,
        e: e,
        f: f,
        g: g,
        h: h,
        i: i
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
  /// - parameter f: The range expression with-which to slice the `f`-factor.
  /// - parameter g: The range expression with-which to slice the `g`-factor.
  /// - parameter h: The range expression with-which to slice the `h`-factor.
  /// - parameter i: The range expression with-which to slice the `i`-factor.
  ///
  /// - returns: The product of the slices: `a[a] x b[b] x ... x i[i]` (etc.).
  ///
  @inlinable
  func subproduct<
    RA,
    RB,
    RC,
    RD,
    RE,
    RF,
    RG,
    RH,
    RI>(
    a ra: RA,
    b rb: RB,
    c rc: RC,
    d rd: RD,
    e re: RE,
    f rf: RF,
    g rg: RG,
    h rh: RH,
    i ri: RI) -> SubProduct
    where
    RA:RangeExpression,
    RB:RangeExpression,
    RC:RangeExpression,
    RD:RangeExpression,
    RE:RangeExpression,
    RF:RangeExpression,
    RG:RangeExpression,
    RH:RangeExpression,
    RI:RangeExpression,
    RA.Bound == A.Index,
    RB.Bound == B.Index,
    RC.Bound == C.Index,
    RD.Bound == D.Index,
    RE.Bound == E.Index,
    RF.Bound == F.Index,
    RG.Bound == G.Index,
    RH.Bound == H.Index,
    RI.Bound == I.Index {
      return SubProduct(
        storage: self.storage.subproduct(
          a: ra,
          b: rb,
          c: rc,
          d: rd,
          e: re,
          f: rf,
          g: rg,
          h: rh,
          i: ri
        )
      )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Single-Axis API - A
// -------------------------------------------------------------------------- //

public extension Product9Collection {
  

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

public extension Product9Collection {
  
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

public extension Product9Collection {
  
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

public extension Product9Collection {
  
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

public extension Product9Collection {
  
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

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Single-Axis API - F
// -------------------------------------------------------------------------- //

public extension Product9Collection {
  
  /// Returns a subproduct wherein we only slice along the `f`-axis.
  ///
  /// - parameter f: The range with-which to slice the `f`-factor.
  ///
  /// - returns: The subproduct with `f[f]` instead of `f` (and all others equivalent).
  ///
  /// - note: We only *slice* on `f`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(f: Range<F.Index>) -> SubProduct {
    return SubProduct(
      storage: self.storage.subproduct(
        f: f
      )
    )
  }

  /// Returns a subproduct wherein we only slice along the `f`-axis.
  ///
  /// - parameter f: The range expression with-which to slice the `f`-factor.
  ///
  /// - returns: The subproduct with `f[f]` instead of `f` (and all others equivalent).
  ///
  /// - note: We only *slice* on `f`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RF>(
    f rf: RF) -> SubProduct
    where
    RF:RangeExpression,
    RF.Bound == F.Index {
      return SubProduct(
        storage: self.storage.subproduct(
          f: rf
        )
      )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Single-Axis API - G
// -------------------------------------------------------------------------- //

public extension Product9Collection {
  
  /// Returns a subproduct wherein we only slice along the `g`-axis.
  ///
  /// - parameter g: The range with-which to slice the `g`-factor.
  ///
  /// - returns: The subproduct with `g[g]` instead of `g` (and all others equivalent).
  ///
  /// - note: We only *slice* on `g`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(g: Range<G.Index>) -> SubProduct {
    return SubProduct(
      storage: self.storage.subproduct(
        g: g
      )
    )
  }

  /// Returns a subproduct wherein we only slice along the `g`-axis.
  ///
  /// - parameter g: The range expression with-which to slice the `g`-factor.
  ///
  /// - returns: The subproduct with `g[g]` instead of `g` (and all others equivalent).
  ///
  /// - note: We only *slice* on `g`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RG>(
    g rg: RG) -> SubProduct
    where
    RG:RangeExpression,
    RG.Bound == G.Index {
      return SubProduct(
        storage: self.storage.subproduct(
          g: rg
        )
      )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Single-Axis API - H
// -------------------------------------------------------------------------- //

public extension Product9Collection {
  
  /// Returns a subproduct wherein we only slice along the `h`-axis.
  ///
  /// - parameter h: The range with-which to slice the `h`-factor.
  ///
  /// - returns: The subproduct with `h[h]` instead of `h` (and all others equivalent).
  ///
  /// - note: We only *slice* on `h`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(h: Range<H.Index>) -> SubProduct {
    return SubProduct(
      storage: self.storage.subproduct(
        h: h
      )
    )
  }

  /// Returns a subproduct wherein we only slice along the `h`-axis.
  ///
  /// - parameter h: The range expression with-which to slice the `h`-factor.
  ///
  /// - returns: The subproduct with `h[h]` instead of `h` (and all others equivalent).
  ///
  /// - note: We only *slice* on `h`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RH>(
    h rh: RH) -> SubProduct
    where
    RH:RangeExpression,
    RH.Bound == H.Index {
      return SubProduct(
        storage: self.storage.subproduct(
          h: rh
        )
      )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SubProduct - Single-Axis API - I
// -------------------------------------------------------------------------- //

public extension Product9Collection {
  
  /// Returns a subproduct wherein we only slice along the `i`-axis.
  ///
  /// - parameter i: The range with-which to slice the `i`-factor.
  ///
  /// - returns: The subproduct with `i[i]` instead of `i` (and all others equivalent).
  ///
  /// - note: We only *slice* on `i`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(i: Range<I.Index>) -> SubProduct {
    return SubProduct(
      storage: self.storage.subproduct(
        i: i
      )
    )
  }

  /// Returns a subproduct wherein we only slice along the `i`-axis.
  ///
  /// - parameter h: The range expression with-which to slice the `i`-factor.
  ///
  /// - returns: The subproduct with `i[i]` instead of `i` (and all others equivalent).
  ///
  /// - note: We only *slice* on `i`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RI>(
    i ri: RI) -> SubProduct
    where
    RI:RangeExpression,
    RI.Bound == I.Index {
      return SubProduct(
        storage: self.storage.subproduct(
          i: ri
        )
      )
  }
  
}
