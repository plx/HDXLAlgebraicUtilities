//
//  Sum4+UniformValueAccess.swift
//

import Foundation
import HDXLCommonUtilities

public extension Sum4
  where
  A == B,
  A == C,
  A == D {
  
  typealias UniformValue = A
  typealias IdentifiedUniformValue = Product2<Position,UniformValue>
  
  /// For sums of a uniform type, we can reliably extract a non-nil value of that type.
  @inlinable
  var uniformValue: UniformValue {
    get {
      switch self {
      case .a(let v):
        return v
      case .b(let v):
        return v
      case .c(let v):
        return v
      case .d(let v):
        return v
      }
    }
  }
  
  /// Like `uniformValue` but includes the arity-position from-which we sourced the value.
  @inlinable
  var identifiedUniformValue: IdentifiedUniformValue {
    get {
      switch self {
      case .a(let v):
        return IdentifiedUniformValue(.a,v)
      case .b(let v):
        return IdentifiedUniformValue(.b,v)
      case .c(let v):
        return IdentifiedUniformValue(.c,v)
      case .d(let v):
        return IdentifiedUniformValue(.d,v)
      }
    }
  }
  
}
