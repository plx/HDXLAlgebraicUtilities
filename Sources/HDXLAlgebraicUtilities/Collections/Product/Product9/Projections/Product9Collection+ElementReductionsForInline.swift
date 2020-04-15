//
//  Product9Collection+ElementReductionsForInline.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: Product9Collection - Single-Element Reduction - Inline
// -------------------------------------------------------------------------- //

public extension Product9Collection
  where
  Position == InlinePositionRepresentation {
  
  /// Returns `self` after having "sliced" `A` down to the single value @ index `a`.
  @inlinable
  func reducingA(to a: A.Index) -> Product9Collection<
    CollectionOfOne<A.Element>,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
    InlineProduct9<CollectionOfOne<A.Element>.Index,B.Index,C.Index,D.Index,E.Index,F.Index,G.Index,H.Index,I.Index>,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(a < self.a.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
        CollectionOfOne<A.Element>,
        B,
        C,
        D,
        E,
        F,
        G,
        H,
        I,
        InlineProduct9<CollectionOfOne<A.Element>.Index,B.Index,C.Index,D.Index,E.Index,F.Index,G.Index,H.Index,I.Index>,
        Element>(
        self.a.reduced(to: a),
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

  /// Returns `self` after having "sliced" `B` down to the single value @ index `b`.
  @inlinable
  func reducingB(to b: B.Index) -> Product9Collection<
    A,
    CollectionOfOne<B.Element>,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
    InlineProduct9<A.Index,CollectionOfOne<B.Element>.Index,C.Index,D.Index,E.Index,F.Index,G.Index,H.Index,I.Index>,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(b < self.b.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
        A,
        CollectionOfOne<B.Element>,
        C,
        D,
        E,
        F,
        G,
        H,
        I,
        InlineProduct9<A.Index,CollectionOfOne<B.Element>.Index,C.Index,D.Index,E.Index,F.Index,G.Index,H.Index,I.Index>,
        Element>(
        self.a,
        self.b.reduced(to: b),
        self.c,
        self.d,
        self.e,
        self.f,
        self.g,
        self.h,
        self.i
      )
  }

  /// Returns `self` after having "sliced" `C` down to the single value @ index `c`.
  @inlinable
  func reducingC(to c: C.Index) -> Product9Collection<
    A,
    B,
    CollectionOfOne<C.Element>,
    D,
    E,
    F,
    G,
    H,
    I,
    InlineProduct9<A.Index,B.Index,CollectionOfOne<C.Element>.Index,D.Index,E.Index,F.Index,G.Index,H.Index,I.Index>,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(c < self.c.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
        A,
        B,
        CollectionOfOne<C.Element>,
        D,
        E,
        F,
        G,
        H,
        I,
        InlineProduct9<A.Index,B.Index,CollectionOfOne<C.Element>.Index,D.Index,E.Index,F.Index,G.Index,H.Index,I.Index>,
        Element>(
        self.a,
        self.b,
        self.c.reduced(to: c),
        self.d,
        self.e,
        self.f,
        self.g,
        self.h,
        self.i
      )
  }

  /// Returns `self` after having "sliced" `D` down to the single value @ index `d`.
  @inlinable
  func reducingD(to d: D.Index) -> Product9Collection<
    A,
    B,
    C,
    CollectionOfOne<D.Element>,
    E,
    F,
    G,
    H,
    I,
    InlineProduct9<A.Index,B.Index,C.Index,CollectionOfOne<D.Element>.Index,E.Index,F.Index,G.Index,H.Index,I.Index>,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(d < self.d.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
        A,
        B,
        C,
        CollectionOfOne<D.Element>,
        E,
        F,
        G,
        H,
        I,
        InlineProduct9<A.Index,B.Index,C.Index,CollectionOfOne<D.Element>.Index,E.Index,F.Index,G.Index,H.Index,I.Index>,
        Element>(
        self.a,
        self.b,
        self.c,
        self.d.reduced(to: d),
        self.e,
        self.f,
        self.g,
        self.h,
        self.i
      )
  }

  /// Returns `self` after having "sliced" `E` down to the single value @ index `e`.
  @inlinable
  func reducingE(to e: E.Index) -> Product9Collection<
    A,
    B,
    C,
    D,
    CollectionOfOne<E.Element>,
    F,
    G,
    H,
    I,
    InlineProduct9<A.Index,B.Index,C.Index,D.Index,CollectionOfOne<E.Element>.Index,F.Index,G.Index,H.Index,I.Index>,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(e < self.e.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
        A,
        B,
        C,
        D,
        CollectionOfOne<E.Element>,
        F,
        G,
        H,
        I,
        InlineProduct9<A.Index,B.Index,C.Index,D.Index,CollectionOfOne<E.Element>.Index,F.Index,G.Index,H.Index,I.Index>,
        Element>(
        self.a,
        self.b,
        self.c,
        self.d,
        self.e.reduced(to: e),
        self.f,
        self.g,
        self.h,
        self.i
      )
  }

  /// Returns `self` after having "sliced" `F` down to the single value @ index `f`.
  @inlinable
  func reducingF(to f: F.Index) -> Product9Collection<
    A,
    B,
    C,
    D,
    E,
    CollectionOfOne<F.Element>,
    G,
    H,
    I,
    InlineProduct9<A.Index,B.Index,C.Index,D.Index,E.Index,CollectionOfOne<F.Element>.Index,G.Index,H.Index,I.Index>,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(f < self.f.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
        A,
        B,
        C,
        D,
        E,
        CollectionOfOne<F.Element>,
        G,
        H,
        I,
        InlineProduct9<A.Index,B.Index,C.Index,D.Index,E.Index,CollectionOfOne<F.Element>.Index,G.Index,H.Index,I.Index>,
        Element>(
        self.a,
        self.b,
        self.c,
        self.d,
        self.e,
        self.f.reduced(to: f),
        self.g,
        self.h,
        self.i
      )
  }

  /// Returns `self` after having "sliced" `G` down to the single value @ index `g`.
  @inlinable
  func reducingG(to g: G.Index) -> Product9Collection<
    A,
    B,
    C,
    D,
    E,
    F,
    CollectionOfOne<G.Element>,
    H,
    I,
    InlineProduct9<A.Index,B.Index,C.Index,D.Index,E.Index,F.Index,CollectionOfOne<G.Element>.Index,H.Index,I.Index>,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(g < self.g.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
        A,
        B,
        C,
        D,
        E,
        F,
        CollectionOfOne<G.Element>,
        H,
        I,
        InlineProduct9<A.Index,B.Index,C.Index,D.Index,E.Index,F.Index,CollectionOfOne<G.Element>.Index,H.Index,I.Index>,
        Element>(
        self.a,
        self.b,
        self.c,
        self.d,
        self.e,
        self.f,
        self.g.reduced(to: g),
        self.h,
        self.i
      )
  }

  /// Returns `self` after having "sliced" `H` down to the single value @ index `h`.
  @inlinable
  func reducingH(to h: H.Index) -> Product9Collection<
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    CollectionOfOne<H.Element>,
    I,
    InlineProduct9<A.Index,B.Index,C.Index,D.Index,E.Index,F.Index,G.Index,CollectionOfOne<H.Element>.Index,I.Index>,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(h < self.h.endIndex)
      // ///////////////////////////////////////////////////////////////////////
      return Product9Collection<
        A,
        B,
        C,
        D,
        E,
        F,
        G,
        CollectionOfOne<H.Element>,
        I,
        InlineProduct9<A.Index,B.Index,C.Index,D.Index,E.Index,F.Index,G.Index,CollectionOfOne<H.Element>.Index,I.Index>,
        Element>(
        self.a,
        self.b,
        self.c,
        self.d,
        self.e,
        self.f,
        self.g,
        self.h.reduced(to: h),
        self.i
      )
  }

  /// Returns `self` after having "sliced" `I` down to the single value @ index `i`.
  @inlinable
  func reducingI(to i: I.Index) -> Product9Collection<
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    CollectionOfOne<I.Element>,
    InlineProduct9<A.Index,B.Index,C.Index,D.Index,E.Index,F.Index,G.Index,H.Index,CollectionOfOne<I.Element>.Index>,
    Element> {
      // ///////////////////////////////////////////////////////////////////////
      precondition(i < self.i.endIndex)
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
        CollectionOfOne<I.Element>,
        InlineProduct9<A.Index,B.Index,C.Index,D.Index,E.Index,F.Index,G.Index,H.Index,CollectionOfOne<I.Element>.Index>,
        Element>(
        self.a,
        self.b,
        self.c,
        self.d,
        self.e,
        self.f,
        self.g,
        self.h,
        self.i.reduced(to: i)
      )
  }

}

