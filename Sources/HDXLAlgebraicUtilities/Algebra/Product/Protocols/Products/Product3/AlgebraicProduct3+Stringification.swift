//
//  AlgebraicProduct3+Stringification.swift
//

import Foundation
import HDXLCommonUtilities

internal extension AlgebraicProduct3 {
  
  @inlinable
  static var unenclosedComponentTypeDescriptions: String {
    get {
      return [
        String(describing: A.self),
        String(describing: B.self),
        String(describing: C.self)
        ].joined(separator: ", ")
    }
  }

  @inlinable
  static var unenclosedComponentTypeDebugDescriptions: String {
    get {
      return [
        String(reflecting: A.self),
        String(reflecting: B.self),
        String(reflecting: C.self)
        ].joined(separator: ", ")
    }
  }
  
  @inlinable
  var unenclosedComponentValueDescriptions: String {
    get {
      return [
      String(describing: self.a),
      String(describing: self.b),
      String(describing: self.c)
      ].joined(separator: ", ")
    }
  }

  @inlinable
  var unenclosedComponentValueDebugDescriptions: String {
    get {
      return [
      String(reflecting: self.a),
      String(reflecting: self.b),
      String(reflecting: self.c)
      ].joined(separator: ", ")
    }
  }

  @inlinable
  var unenclosedLabeledComponentValueDescriptions: String {
    get {
      return [
      "a: \(String(describing: self.a))",
      "b: \(String(describing: self.b))",
      "c: \(String(describing: self.c))"
      ].joined(separator: ", ")
    }
  }

  @inlinable
  var unenclosedLabeledComponentValueDebugDescriptions: String {
    get {
      return [
      "a: \(String(reflecting: self.a))",
      "b: \(String(reflecting: self.b))",
      "c: \(String(reflecting: self.c))"
      ].joined(separator: ", ")
    }
  }

}
