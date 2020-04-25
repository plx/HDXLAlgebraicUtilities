//
//  Product8CollectionStorage+SubProductStorage.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: SubProductStorage - Basic API
// -------------------------------------------------------------------------- //

internal extension Product8CollectionStorage {
  
  /// `SubSequence`-like typealias but for subproduct *storage*.
  @usableFromInline
  typealias SubProductStorage = Product8CollectionStorage<
    A.SubSequence,
    B.SubSequence,
    C.SubSequence,
    D.SubSequence,
    E.SubSequence,
    F.SubSequence,
    G.SubSequence,
    H.SubSequence,
    Position,
    Element
  >

  /// Returns storage for the "subproduct"--the product of the slices taken from each factor.
  ///
  /// - parameter a: The range with-which to slice the `a`-factor.
  /// - parameter b: The range with-which to slice the `b`-factor.
  /// - parameter c: The range with-which to slice the `c`-factor.
  /// - parameter d: The range with-which to slice the `d`-factor.
  /// - parameter e: The range with-which to slice the `e`-factor.
  /// - parameter f: The range with-which to slice the `f`-factor.
  /// - parameter g: The range with-which to slice the `g`-factor.
  /// - parameter h: The range with-which to slice the `h`-factor.
  ///
  /// - returns: The product of the slices: `a[a] x b[b] ... x h[h]` (etc.).
  ///
  /// - note: Hope is that I will come back and have these methosd on the *storage* copy over the cached attributes (perhaps with modifications to account for the slicing).
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
    h: Range<H.Index>) -> SubProductStorage {
    return SubProductStorage(
      self.a[a],
      self.b[b],
      self.c[c],
      self.d[d],
      self.e[e],
      self.f[f],
      self.g[g],
      self.h[h]
    )
  }
    
  /// Returns storage for the "subproduct"--the product of the slices taken from each factor.
  ///
  /// - parameter a: The range expression with-which to slice the `a`-factor.
  /// - parameter b: The range expression with-which to slice the `b`-factor.
  /// - parameter c: The range expression with-which to slice the `c`-factor.
  /// - parameter d: The range expression with-which to slice the `d`-factor.
  /// - parameter e: The range expression with-which to slice the `e`-factor.
  /// - parameter f: The range expression with-which to slice the `f`-factor.
  /// - parameter g: The range expression with-which to slice the `g`-factor.
  /// - parameter h: The range expression with-which to slice the `h`-factor.
  ///
  /// - returns: The product of the slices: `a[a] x b[b] ... x h[h]` (etc.).
  ///
  /// - note: Hope is that I will come back and have these methosd on the *storage* copy over the cached attributes (perhaps with modifications to account for the slicing).
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
    RH>(
    a ra: RA,
    b rb: RB,
    c rc: RC,
    d rd: RD,
    e re: RE,
    f rf: RF,
    g rg: RG,
    h rh: RH) -> SubProductStorage
    where
    RA:RangeExpression,
    RB:RangeExpression,
    RC:RangeExpression,
    RD:RangeExpression,
    RE:RangeExpression,
    RF:RangeExpression,
    RG:RangeExpression,
    RH:RangeExpression,
    RA.Bound == A.Index,
    RB.Bound == B.Index,
    RC.Bound == C.Index,
    RD.Bound == D.Index,
    RE.Bound == E.Index,
    RF.Bound == F.Index,
    RG.Bound == G.Index,
    RH.Bound == H.Index {
      return SubProductStorage(
        self.a[ra.relative(to: self.a)],
        self.b[rb.relative(to: self.b)],
        self.c[rc.relative(to: self.c)],
        self.d[rd.relative(to: self.d)],
        self.e[re.relative(to: self.e)],
        self.f[rf.relative(to: self.f)],
        self.g[rg.relative(to: self.g)],
        self.h[rh.relative(to: self.h)]
      )
  }

}

// -------------------------------------------------------------------------- //
// MARK: SubProductStorage - Single-Axis API - A
// -------------------------------------------------------------------------- //

internal extension Product8CollectionStorage {
  

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
      self.b.completeSubSequence,
      self.c.completeSubSequence,
      self.d.completeSubSequence,
      self.e.completeSubSequence,
      self.f.completeSubSequence,
      self.g.completeSubSequence,
      self.h.completeSubSequence
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
        self.b.completeSubSequence,
        self.c.completeSubSequence,
        self.d.completeSubSequence,
        self.e.completeSubSequence,
        self.f.completeSubSequence,
        self.g.completeSubSequence,
        self.h.completeSubSequence
      )
  }

}

// -------------------------------------------------------------------------- //
// MARK: SubProductStorage - Single-Axis API - B
// -------------------------------------------------------------------------- //

internal extension Product8CollectionStorage {
  
  /// Returns storage for a subproduct wherein we only slice along the `b`-axis.
  ///
  /// - parameter a: The range with-which to slice the `b`-factor.
  ///
  /// - returns: The subproduct with `b[b]` instead of `b` (and all others equivalent).
  ///
  /// - note: We only *slice* on `b`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(b: Range<B.Index>) -> SubProductStorage {
    return SubProductStorage(
      self.a.completeSubSequence,
      self.b[b],
      self.c.completeSubSequence,
      self.d.completeSubSequence,
      self.e.completeSubSequence,
      self.f.completeSubSequence,
      self.g.completeSubSequence,
      self.h.completeSubSequence
    )
  }

  /// Returns storage for a subproduct wherein we only slice along the `b`-axis.
  ///
  /// - parameter b: The range expression with-which to slice the `b`-factor.
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
        self.b[rb.relative(to: self.b)],
        self.c.completeSubSequence,
        self.d.completeSubSequence,
        self.e.completeSubSequence,
        self.f.completeSubSequence,
        self.g.completeSubSequence,
        self.h.completeSubSequence
      )
  }

}

// -------------------------------------------------------------------------- //
// MARK: SubProductStorage - Single-Axis API - C
// -------------------------------------------------------------------------- //

internal extension Product8CollectionStorage {
  
  /// Returns storage for a subproduct wherein we only slice along the `c`-axis.
  ///
  /// - parameter c: The range with-which to slice the `c`-factor.
  ///
  /// - returns: The subproduct with `c[c]` instead of `c` (and all others equivalent).
  ///
  /// - note: We only *slice* on `c`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(c: Range<C.Index>) -> SubProductStorage {
    return SubProductStorage(
      self.a.completeSubSequence,
      self.b.completeSubSequence,
      self.c[c],
      self.d.completeSubSequence,
      self.e.completeSubSequence,
      self.f.completeSubSequence,
      self.g.completeSubSequence,
      self.h.completeSubSequence
    )
  }

  /// Returns storage for a subproduct wherein we only slice along the `c`-axis.
  ///
  /// - parameter c: The range expression with-which to slice the `c`-factor.
  ///
  /// - returns: The subproduct with `c[c]` instead of `c` (and all others equivalent).
  ///
  /// - note: We only *slice* on `c`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RC>(
    c rc: RC) -> SubProductStorage
    where
    RC:RangeExpression,
    RC.Bound == C.Index {
      return SubProductStorage(
        self.a.completeSubSequence,
        self.b.completeSubSequence,
        self.c[rc.relative(to: self.c)],
        self.d.completeSubSequence,
        self.e.completeSubSequence,
        self.f.completeSubSequence,
        self.g.completeSubSequence,
        self.h.completeSubSequence
      )
  }

}

// -------------------------------------------------------------------------- //
// MARK: SubProductStorage - Single-Axis API - D
// -------------------------------------------------------------------------- //

internal extension Product8CollectionStorage {
  
  /// Returns storage for a subproduct wherein we only slice along the `d`-axis.
  ///
  /// - parameter d: The range with-which to slice the `d`-factor.
  ///
  /// - returns: The subproduct with `d[d]` instead of `d` (and all others equivalent).
  ///
  /// - note: We only *slice* on `d`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(d: Range<D.Index>) -> SubProductStorage {
    return SubProductStorage(
      self.a.completeSubSequence,
      self.b.completeSubSequence,
      self.c.completeSubSequence,
      self.d[d],
      self.e.completeSubSequence,
      self.f.completeSubSequence,
      self.g.completeSubSequence,
      self.h.completeSubSequence
    )
  }

  /// Returns storage for a subproduct wherein we only slice along the `d`-axis.
  ///
  /// - parameter d: The range expression with-which to slice the `d`-factor.
  ///
  /// - returns: The subproduct with `d[d]` instead of `d` (and all others equivalent).
  ///
  /// - note: We only *slice* on `d`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RD>(
    d rd: RD) -> SubProductStorage
    where
    RD:RangeExpression,
    RD.Bound == D.Index {
      return SubProductStorage(
        self.a.completeSubSequence,
        self.b.completeSubSequence,
        self.c.completeSubSequence,
        self.d[rd.relative(to: self.d)],
        self.e.completeSubSequence,
        self.f.completeSubSequence,
        self.g.completeSubSequence,
        self.h.completeSubSequence
      )
  }

}

// -------------------------------------------------------------------------- //
// MARK: SubProductStorage - Single-Axis API - E
// -------------------------------------------------------------------------- //

internal extension Product8CollectionStorage {
  
  /// Returns storage for a subproduct wherein we only slice along the `e`-axis.
  ///
  /// - parameter e: The range with-which to slice the `e`-factor.
  ///
  /// - returns: The subproduct with `e[e]` instead of `e` (and all others equivalent).
  ///
  /// - note: We only *slice* on `e`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(e: Range<E.Index>) -> SubProductStorage {
    return SubProductStorage(
      self.a.completeSubSequence,
      self.b.completeSubSequence,
      self.c.completeSubSequence,
      self.d.completeSubSequence,
      self.e[e],
      self.f.completeSubSequence,
      self.g.completeSubSequence,
      self.h.completeSubSequence
    )
  }

  /// Returns storage for a subproduct wherein we only slice along the `e`-axis.
  ///
  /// - parameter e: The range expression with-which to slice the `e`-factor.
  ///
  /// - returns: The subproduct with `e[e]` instead of `e` (and all others equivalent).
  ///
  /// - note: We only *slice* on `e`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RE>(
    e re: RE) -> SubProductStorage
    where
    RE:RangeExpression,
    RE.Bound == E.Index {
      return SubProductStorage(
        self.a.completeSubSequence,
        self.b.completeSubSequence,
        self.c.completeSubSequence,
        self.d.completeSubSequence,
        self.e[re.relative(to: self.e)],
        self.f.completeSubSequence,
        self.g.completeSubSequence,
        self.h.completeSubSequence
      )
  }

}

// -------------------------------------------------------------------------- //
// MARK: SubProductStorage - Single-Axis API - F
// -------------------------------------------------------------------------- //

internal extension Product8CollectionStorage {
  
  /// Returns storage for a subproduct wherein we only slice along the `f`-axis.
  ///
  /// - parameter f: The range with-which to slice the `f`-factor.
  ///
  /// - returns: The subproduct with `f[f]` instead of `f` (and all others equivalent).
  ///
  /// - note: We only *slice* on `f`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(f: Range<F.Index>) -> SubProductStorage {
    return SubProductStorage(
      self.a.completeSubSequence,
      self.b.completeSubSequence,
      self.c.completeSubSequence,
      self.d.completeSubSequence,
      self.e.completeSubSequence,
      self.f[f],
      self.g.completeSubSequence,
      self.h.completeSubSequence
    )
  }

  /// Returns storage for a subproduct wherein we only slice along the `f`-axis.
  ///
  /// - parameter f: The range expression with-which to slice the `f`-factor.
  ///
  /// - returns: The subproduct with `f[f]` instead of `f` (and all others equivalent).
  ///
  /// - note: We only *slice* on `f`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RF>(
    f rf: RF) -> SubProductStorage
    where
    RF:RangeExpression,
    RF.Bound == F.Index {
      return SubProductStorage(
        self.a.completeSubSequence,
        self.b.completeSubSequence,
        self.c.completeSubSequence,
        self.d.completeSubSequence,
        self.e.completeSubSequence,
        self.f[rf.relative(to: self.f)],
        self.g.completeSubSequence,
        self.h.completeSubSequence
      )
  }

}

// -------------------------------------------------------------------------- //
// MARK: SubProductStorage - Single-Axis API - G
// -------------------------------------------------------------------------- //

internal extension Product8CollectionStorage {
  
  /// Returns storage for a subproduct wherein we only slice along the `g`-axis.
  ///
  /// - parameter g: The range with-which to slice the `g`-factor.
  ///
  /// - returns: The subproduct with `g[g]` instead of `g` (and all others equivalent).
  ///
  /// - note: We only *slice* on `g`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(g: Range<G.Index>) -> SubProductStorage {
    return SubProductStorage(
      self.a.completeSubSequence,
      self.b.completeSubSequence,
      self.c.completeSubSequence,
      self.d.completeSubSequence,
      self.e.completeSubSequence,
      self.f.completeSubSequence,
      self.g[g],
      self.h.completeSubSequence
    )
  }

  /// Returns storage for a subproduct wherein we only slice along the `g`-axis.
  ///
  /// - parameter g: The range expression with-which to slice the `g`-factor.
  ///
  /// - returns: The subproduct with `g[g]` instead of `g` (and all others equivalent).
  ///
  /// - note: We only *slice* on `g`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RG>(
    g rg: RG) -> SubProductStorage
    where
    RG:RangeExpression,
    RG.Bound == G.Index {
      return SubProductStorage(
        self.a.completeSubSequence,
        self.b.completeSubSequence,
        self.c.completeSubSequence,
        self.d.completeSubSequence,
        self.e.completeSubSequence,
        self.f.completeSubSequence,
        self.g[rg.relative(to: self.g)],
        self.h.completeSubSequence
      )
  }

}

// -------------------------------------------------------------------------- //
// MARK: SubProductStorage - Single-Axis API - H
// -------------------------------------------------------------------------- //

internal extension Product8CollectionStorage {
  
  /// Returns storage for a subproduct wherein we only slice along the `h`-axis.
  ///
  /// - parameter h: The range with-which to slice the `h`-factor.
  ///
  /// - returns: The subproduct with `h[h]` instead of `h` (and all others equivalent).
  ///
  /// - note: We only *slice* on `h`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct(h: Range<H.Index>) -> SubProductStorage {
    return SubProductStorage(
      self.a.completeSubSequence,
      self.b.completeSubSequence,
      self.c.completeSubSequence,
      self.d.completeSubSequence,
      self.e.completeSubSequence,
      self.f.completeSubSequence,
      self.g.completeSubSequence,
      self.h[h]
    )
  }

  /// Returns storage for a subproduct wherein we only slice along the `h`-axis.
  ///
  /// - parameter h: The range expression with-which to slice the `h`-factor.
  ///
  /// - returns: The subproduct with `h[h]` instead of `h` (and all others equivalent).
  ///
  /// - note: We only *slice* on `h`, but we still drop to `SubSequence` for all other factors--if we don't do this, we risk unexpected type mismatches (and other similar issues).
  ///
  @inlinable
  func subproduct<RH>(
    h rh: RH) -> SubProductStorage
    where
    RH:RangeExpression,
    RH.Bound == H.Index {
      return SubProductStorage(
        self.a.completeSubSequence,
        self.b.completeSubSequence,
        self.c.completeSubSequence,
        self.d.completeSubSequence,
        self.e.completeSubSequence,
        self.f.completeSubSequence,
        self.g.completeSubSequence,
        self.h[rh.relative(to: self.h)]
      )
  }

}

