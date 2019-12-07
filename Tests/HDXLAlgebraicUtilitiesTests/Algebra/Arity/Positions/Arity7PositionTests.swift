//
//  Arity7PositionTests.swift
//

import Foundation
import XCTest
import HDXLCommonUtilities
import HDXLTestingUtilities
@testable import HDXLAlgebraicUtilities

class Arity7PositionTests: XCTestCase {
  
  typealias Position = Arity7Position
  
  func testArity() {
    XCTAssertEqual(
      7,
      Position.allCases.count
    )
  }
  
  func testAllCases() {
    XCTAssertEqual(
      Position.allCases,
      [
        .a,
        .b,
        .c,
        .d,
        .e,
        .f,
        .g
      ]
    )
  }
  
  func testEquality() {
    HDXLAssertCoherentEquality(
      forDistinctValues: Position.allCases
    )
  }
  
  func testOrdering() {
    HDXLAssertCoherentOrdering(
      forAscendingDistinctValues: Position.allCases
    )
  }
    
}

