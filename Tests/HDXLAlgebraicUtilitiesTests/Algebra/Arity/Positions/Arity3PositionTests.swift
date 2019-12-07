//
//  Arity3PositionTests.swift
//

import Foundation
import XCTest
import HDXLCommonUtilities
import HDXLTestingUtilities
@testable import HDXLAlgebraicUtilities

class Arity3PositionTests: XCTestCase {
  
  typealias Position = Arity3Position
  
  func testArity() {
    XCTAssertEqual(
      3,
      Position.allCases.count
    )
  }
  
  func testAllCases() {
    XCTAssertEqual(
      Position.allCases,
      [
        .a,
        .b,
        .c
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

