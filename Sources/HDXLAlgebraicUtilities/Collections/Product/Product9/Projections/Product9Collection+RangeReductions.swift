//
//  Product9Collection+RangeReductions.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: Product9Collection - Range-Reduction
// -------------------------------------------------------------------------- //

public extension Product9Collection {
  
  /// Returns `self` after having "sliced" `A` as-per `a`.
  ///
  /// - note: For *known* single-element slices, consider specialized methods--`CollectionOfOne` likely has better performance characteristics.
  ///
  @inlinable
  func reducingA(to a: Range<A.Index>) -> Product9Collection<
    A.SubSequence,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
    Position,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(a.upperBound <= self.a.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
      A.SubSequence,
      B,
      C,
      D,
      E,
      F,
      G,
      H,
      I,
      Position,
      Element>(
        self.a[a],
        self.b,
        self.c,
        self.d,
        self.e,
        self.f,
        self.g,
        self.h,
        self.i
      )
  }

  /// Returns `self` after having "sliced" `B` as-per `b`.
  ///
  /// - note: For *known* single-element slices, consider specialized methods--`CollectionOfOne` likely has better performance characteristics.
  ///
  @inlinable
  func reducingB(to b: Range<B.Index>) -> Product9Collection<
    A,
    B.SubSequence,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
    Position,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(b.upperBound <= self.b.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
      A,
      B.SubSequence,
      C,
      D,
      E,
      F,
      G,
      H,
      I,
      Position,
      Element>(
        self.a,
        self.b[b],
        self.c,
        self.d,
        self.e,
        self.f,
        self.g,
        self.h,
        self.i
      )
  }

  /// Returns `self` after having "sliced" `C` as-per `c`.
  ///
  /// - note: For *known* single-element slices, consider specialized methods--`CollectionOfOne` likely has better performance characteristics.
  ///
  @inlinable
  func reducingC(to c: Range<C.Index>) -> Product9Collection<
    A,
    B,
    C.SubSequence,
    D,
    E,
    F,
    G,
    H,
    I,
    Position,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(c.upperBound <= self.c.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
      A,
      B,
      C.SubSequence,
      D,
      E,
      F,
      G,
      H,
      I,
      Position,
      Element>(
        self.a,
        self.b,
        self.c[c],
        self.d,
        self.e,
        self.f,
        self.g,
        self.h,
        self.i
      )
  }

  /// Returns `self` after having "sliced" `D` as-per `d`.
  ///
  /// - note: For *known* single-element slices, consider specialized methods--`CollectionOfOne` likely has better performance characteristics.
  ///
  @inlinable
  func reducingD(to d: Range<D.Index>) -> Product9Collection<
    A,
    B,
    C,
    D.SubSequence,
    E,
    F,
    G,
    H,
    I,
    Position,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(d.upperBound <= self.d.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
      A,
      B,
      C,
      D.SubSequence,
      E,
      F,
      G,
      H,
      I,
      Position,
      Element>(
        self.a,
        self.b,
        self.c,
        self.d[d],
        self.e,
        self.f,
        self.g,
        self.h,
        self.i
      )
  }

  /// Returns `self` after having "sliced" `E` as-per `e`.
  ///
  /// - note: For *known* single-element slices, consider specialized methods--`CollectionOfOne` likely has better performance characteristics.
  ///
  @inlinable
  func reducingE(to e: Range<E.Index>) -> Product9Collection<
    A,
    B,
    C,
    D,
    E.SubSequence,
    F,
    G,
    H,
    I,
    Position,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(e.upperBound <= self.e.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
      A,
      B,
      C,
      D,
      E.SubSequence,
      F,
      G,
      H,
      I,
      Position,
      Element>(
        self.a,
        self.b,
        self.c,
        self.d,
        self.e[e],
        self.f,
        self.g,
        self.h,
        self.i
      )
  }

  /// Returns `self` after having "sliced" `F` as-per `f`.
  ///
  /// - note: For *known* single-element slices, consider specialized methods--`CollectionOfOne` likely has better performance characteristics.
  ///
  @inlinable
  func reducingF(to f: Range<F.Index>) -> Product9Collection<
    A,
    B,
    C,
    D,
    E,
    F.SubSequence,
    G,
    H,
    I,
    Position,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(f.upperBound <= self.f.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
      A,
      B,
      C,
      D,
      E,
      F.SubSequence,
      G,
      H,
      I,
      Position,
      Element>(
        self.a,
        self.b,
        self.c,
        self.d,
        self.e,
        self.f[f],
        self.g,
        self.h,
        self.i
      )
  }

  /// Returns `self` after having "sliced" `G` as-per `g`.
  ///
  /// - note: For *known* single-element slices, consider specialized methods--`CollectionOfOne` likely has better performance characteristics.
  ///
  @inlinable
  func reducingG(to g: Range<G.Index>) -> Product9Collection<
    A,
    B,
    C,
    D,
    E,
    F,
    G.SubSequence,
    H,
    I,
    Position,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(g.upperBound <= self.g.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
      A,
      B,
      C,
      D,
      E,
      F,
      G.SubSequence,
      H,
      I,
      Position,
      Element>(
        self.a,
        self.b,
        self.c,
        self.d,
        self.e,
        self.f,
        self.g[g],
        self.h,
        self.i
      )
  }

  /// Returns `self` after having "sliced" `H` as-per `h`.
  ///
  /// - note: For *known* single-element slices, consider specialized methods--`CollectionOfOne` likely has better performance characteristics.
  ///
  @inlinable
  func reducingH(to h: Range<H.Index>) -> Product9Collection<
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H.SubSequence,
    I,
    Position,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(h.upperBound <= self.h.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
      A,
      B,
      C,
      D,
      E,
      F,
      G,
      H.SubSequence,
      I,
      Position,
      Element>(
        self.a,
        self.b,
        self.c,
        self.d,
        self.e,
        self.f,
        self.g,
        self.h[h],
        self.i
      )
  }

  /// Returns `self` after having "sliced" `I` as-per `i`.
  ///
  /// - note: For *known* single-element slices, consider specialized methods--`CollectionOfOne` likely has better performance characteristics.
  ///
  @inlinable
  func reducingI(to i: Range<I.Index>) -> Product9Collection<
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I.SubSequence,
    Position,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(i.upperBound <= self.i.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
      A,
      B,
      C,
      D,
      E,
      F,
      G,
      H,
      I.SubSequence,
      Position,
      Element>(
        self.a,
        self.b,
        self.c,
        self.d,
        self.e,
        self.f,
        self.g,
        self.h,
        self.i[i]
      )
  }

}

