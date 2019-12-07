//
//  Arity4PositionTests.swift
//

import Foundation
import XCTest
import HDXLCommonUtilities
import HDXLTestingUtilities
@testable import HDXLAlgebraicUtilities

class Arity4PositionTests: XCTestCase {
  
  typealias Position = Arity4Position
  
  func testArity() {
    XCTAssertEqual(
      4,
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
        .d
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

