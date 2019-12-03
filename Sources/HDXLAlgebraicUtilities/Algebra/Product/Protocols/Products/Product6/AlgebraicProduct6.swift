//
//  AlgebraicProduct6.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct6 - Definition
// -------------------------------------------------------------------------- //

/// Protocol specifically for arity-6 products.
public protocol AlgebraicProduct6 : AlgebraicProduct
  where
  ArityPosition == Arity6Position {
  
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

  // ------------------------------------------------------------------------ //
  // MARK: Related Types
  // ------------------------------------------------------------------------ //
  
  /// Shorthand for the same-arity sum type.
  ///
  /// It'd be accurate to call this an "algebraic dual", but I find this name
  /// easier to follow (even if dual is arguably more-proper, here).
  typealias AssociatedSum = Sum6<A,B,C,D,E,F>

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
    _ f: F)
  
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
  
}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct6 - To-Tuple
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct6 {
  
  /// Shorthand for the tuple equivalent-to `Self`.
  typealias EquivalentTuple = (A,B,C,D,E,F)

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
        self.f
      )
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct6 - To-Labeled-Tuple
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct6 {
  
  /// Shorthand for the *labeled* tuple equivalent-to `Self`.
  typealias EquivalentLabeledTuple = (
    a: A,
    b: B,
    c: C,
    d: D,
    e: E,
    f: F
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
        f: self.f
      )
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct6 - AlgebraicProduct Defaults
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct6 {
  
  @inlinable
  static var arity: Int {
    get {
      return 6
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct6 - Validatable
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct6 {
  
  @inlinable
  var isValid: Bool {
    get {
      guard
        isValidOrIndifferent(self.a),
        isValidOrIndifferent(self.b),
        isValidOrIndifferent(self.c),
        isValidOrIndifferent(self.d),
        isValidOrIndifferent(self.e),
        isValidOrIndifferent(self.f) else {
          return false
      }
      return true
    }
  }
  
}
