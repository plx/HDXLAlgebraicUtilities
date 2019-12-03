//
//  AlgebraicProduct2.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct2 - Definition
// -------------------------------------------------------------------------- //

/// Protocol specifically for arity-2 products.
public protocol AlgebraicProduct2 : AlgebraicProduct
  where
  ArityPosition == Arity2Position {
  
  // ------------------------------------------------------------------------ //
  // MARK: Component Types
  // ------------------------------------------------------------------------ //
  
  /// The type of the first component.
  associatedtype A
  
  /// The type of the second component.
  associatedtype B

  // ------------------------------------------------------------------------ //
  // MARK: Related Types
  // ------------------------------------------------------------------------ //
  
  /// Shorthand for the same-arity sum type.
  ///
  /// It'd be accurate to call this an "algebraic dual", but I find this name
  /// easier to follow (even if dual is arguably more-proper, here).
  typealias AssociatedSum = Sum2<A,B>

  // ------------------------------------------------------------------------ //
  // MARK: Component Properties
  // ------------------------------------------------------------------------ //

  /// The first component.
  var a: A { get set }
  
  /// The second component.
  var b: B { get set }

  // ------------------------------------------------------------------------ //
  // MARK: Initialization
  // ------------------------------------------------------------------------ //
  
  /// Componentwise initialization.
  init(
    _ a: A,
    _ b: B)
  
  // ------------------------------------------------------------------------ //
  // MARK: with-Derivation - Simple
  // ------------------------------------------------------------------------ //
  
  /// Obtain a value derived from `self`, but with `a` substituted-for `self.a`.
  func with(a: A) -> Self
  
  /// Obtain a value derived from `self`, but with `b` substituted-for `self.b`.
  func with(b: B) -> Self

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

}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct2 - To-Tuple
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct2 {
  
  /// Shorthand for the tuple equivalent-to `Self`.
  typealias EquivalentTuple = (A,B)
  
  /// Returns a tuple equivalent-to `self`.
  @inlinable
  var equivalentTupleValue: EquivalentTuple {
    get {
      return (
        self.a,
        self.b
      )
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct2 - To-Labeled-Tuple
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct2 {
  
  /// Shorthand for the *labeled* tuple equivalent-to `Self`.
  typealias EquivalentLabeledTuple = (
    a: A,
    b: B
  )
  
  /// Returns a *labeled* tuple equivalent-to `self`.
  @inlinable
  var equivalentLabeledTupleValue: EquivalentLabeledTuple {
    get {
      return (
        a: self.a,
        b: self.b
      )
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct2 - AlgebraicProduct Defaults
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct2 {
  
  @inlinable
  static var arity: Int {
    get {
      return 2
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct2 - Validatable
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct2 {
  
  @inlinable
  var isValid: Bool {
    get {
      guard
        isValidOrIndifferent(self.a),
        isValidOrIndifferent(self.b) else {
          return false
      }
      return true
    }
  }
  
}
