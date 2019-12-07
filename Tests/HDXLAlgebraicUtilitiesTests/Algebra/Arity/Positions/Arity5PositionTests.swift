//
//  Arity5PositionTests.swift
//

import Foundation
import XCTest
import HDXLCommonUtilities
import HDXLTestingUtilities
@testable import HDXLAlgebraicUtilities

class Arity5PositionTests: XCTestCase {
  
  typealias Position = Arity5Position
  
  func testArity() {
    XCTAssertEqual(
      5,
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
        .e
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

