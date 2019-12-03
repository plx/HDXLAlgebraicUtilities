//
//  AlgebraicProduct9.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct9 - Definition
// -------------------------------------------------------------------------- //

/// Protocol specifically for arity-9 products.
public protocol AlgebraicProduct9 : AlgebraicProduct
  where
  ArityPosition == Arity9Position {
  
  // ------------------------------------------------------------------------ //
  // MARK: Component Types
  // ------------------------------------------------------------------------ //
  
  /// The type of the first component.
  associatedtype A

  /// The type of the second component.
  associatedtype B
    
  /// The type of the third component.
  associatedtype C

  /// The type of the fourth component.
  associatedtype D

  /// The type of the fifth component.
  associatedtype E

  /// The type of the sixth component.
  associatedtype F

  /// The type of the seventh component.
  associatedtype G

  /// The type of the eighth component.
  associatedtype H

  /// The type of the ninth component.
  associatedtype I
  
  // ------------------------------------------------------------------------ //
  // MARK: Related Types
  // ------------------------------------------------------------------------ //
  
  /// Shorthand for the same-arity sum type.
  ///
  /// It'd be accurate to call this an "algebraic dual", but I find this name
  /// easier to follow (even if dual is arguably more-proper, here).
  typealias AssociatedSum = Sum9<A,B,C,D,E,F,G,H,I>
  
  // ------------------------------------------------------------------------ //
  // MARK: Component Properties
  // ------------------------------------------------------------------------ //

  /// The first component.
  var a: A { get set }
  
  /// The second component.
  var b: B { get set }
  
  /// The third component.
  var c: C { get set }

  /// The fourth component.
  var d: D { get set }

  /// The fifth component.
  var e: E { get set }

  /// The sixth component.
  var f: F { get set }

  /// The seventh component.
  var g: G { get set }

  /// The eighth component.
  var h: H { get set }

  /// The ninth component.
  var i: I { get set }

  // ------------------------------------------------------------------------ //
  // MARK: Initialization
  // ------------------------------------------------------------------------ //
  
  /// Componentwise initialization.
  init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I)
  
  // ------------------------------------------------------------------------ //
  // MARK: with-Derivation - Simple
  // ------------------------------------------------------------------------ //
  
  /// Obtain a value derived from `self`, but with `a` substituted-for `self.a`.
  func with(a: A) -> Self

  /// Obtain a value derived from `self`, but with `b` substituted-for `self.b`.
  func with(b: B) -> Self

  /// Obtain a value derived from `self`, but with `c` substituted-for `self.c`.
  func with(c: C) -> Self

  /// Obtain a value derived from `self`, but with `d` substituted-for `self.d`.
  func with(d: D) -> Self

  /// Obtain a value derived from `self`, but with `e` substituted-for `self.e`.
  func with(e: E) -> Self

  /// Obtain a value derived from `self`, but with `f` substituted-for `self.f`.
  func with(f: F) -> Self

  /// Obtain a value derived from `self`, but with `g` substituted-for `self.g`.
  func with(g: G) -> Self

  /// Obtain a value derived from `self`, but with `h` substituted-for `self.h`.
  func with(h: H) -> Self

  /// Obtain a value derived from `self`, but with `i` substituted-for `self.i`.
  func with(i: I) -> Self

  // ------------------------------------------------------------------------ //
  // MARK: with-Derivation - Preference
  // ------------------------------------------------------------------------ //
  
  /// Type-level configuration as to whether or not the `with(x:)`-style calls
  /// should use `true` or `false` when they call through to `with(x:ensureUniqueCopy:)`.
  static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { get }

  // ------------------------------------------------------------------------ //
  // MARK: with-Derivation - Complete
  // ------------------------------------------------------------------------ //
  
  /// Obtain a value derived from `self`, but with `a` substituted-for `self.a`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    a: A,
    ensureUniqueCopy: Bool) -> Self
  
  /// Obtain a value derived from `self`, but with `b` substituted-for `self.b`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    b: B,
    ensureUniqueCopy: Bool) -> Self
  
  /// Obtain a value derived from `self`, but with `c` substituted-for `self.c`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    c: C,
    ensureUniqueCopy: Bool) -> Self

  /// Obtain a value derived from `self`, but with `d` substituted-for `self.d`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    d: D,
    ensureUniqueCopy: Bool) -> Self

  /// Obtain a value derived from `self`, but with `e` substituted-for `self.e`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    e: E,
    ensureUniqueCopy: Bool) -> Self

  /// Obtain a value derived from `self`, but with `f` substituted-for `self.f`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    f: F,
    ensureUniqueCopy: Bool) -> Self

  /// Obtain a value derived from `self`, but with `g` substituted-for `self.g`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    g: G,
    ensureUniqueCopy: Bool) -> Self

  /// Obtain a value derived from `self`, but with `h` substituted-for `self.h`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    h: H,
    ensureUniqueCopy: Bool) -> Self

  /// Obtain a value derived from `self`, but with `i` substituted-for `self.i`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    i: I,
    ensureUniqueCopy: Bool) -> Self

}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct9 - To-Tuple
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct9 {

  /// Shorthand for the tuple equivalent-to `Self`.
  typealias EquivalentTuple = (A,B,C,D,E,F,G,H,I)

  /// Returns a tuple equivalent-to `self`.
  @inlinable
  var equivalentTupleValue: EquivalentTuple {
    get {
      return (
        self.a,
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
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct9 - To-Labeled-Tuple
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct9 {
  
  /// Shorthand for the *labeled* tuple equivalent-to `Self`.
  typealias EquivalentLabeledTuple = (
    a: A,
    b: B,
    c: C,
    d: D,
    e: E,
    f: F,
    g: G,
    h: H,
    i: I
  )
  
  /// Returns a *labeled* tuple equivalent-to `self`.
  @inlinable
  var equivalentLabeledTupleValue: EquivalentLabeledTuple {
    get {
      return (
        a: self.a,
        b: self.b,
        c: self.c,
        d: self.d,
        e: self.e,
        f: self.f,
        g: self.g,
        h: self.h,
        i: self.i
      )
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct9 - AlgebraicProduct Defaults
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct9 {
  
  @inlinable
  static var arity: Int {
    get {
      return 9
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct9 - Validatable
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct9 {
  
  @inlinable
  var isValid: Bool {
    get {
      guard
        isValidOrIndifferent(self.a),
        isValidOrIndifferent(self.b),
        isValidOrIndifferent(self.c),
        isValidOrIndifferent(self.d),
        isValidOrIndifferent(self.e),
        isValidOrIndifferent(self.f),
        isValidOrIndifferent(self.g),
        isValidOrIndifferent(self.h),
        isValidOrIndifferent(self.i) else {
          return false
      }
      return true
    }
  }
  
}
