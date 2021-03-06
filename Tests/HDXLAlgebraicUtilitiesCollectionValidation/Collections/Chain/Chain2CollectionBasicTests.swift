//
//  Chain2CollectionBasicTests.swift
//

import Foundation
import XCTest
import HDXLCommonUtilities
import HDXLTestingUtilities
@testable import HDXLAlgebraicUtilities

class Chain2CollectionBasicTests: XCTestCase {
  
  func testAllEmptyCollection() {
    let e: [Int] = []
    let empty = ChainCollection(
      e,
      e
    )
    XCTAssertTrue(empty.isEmpty)
    XCTAssertEqual(
      0,
      empty.count
    )
    XCTAssertEqual(
      empty.startIndex,
      empty.endIndex
    )
  }
  
  func testAllButOneEmptyVariants() {
    let e: [Int] = []
    let vs: [[Int]] = (1...5).map() {
      [Int]($0..<($0 + $0))
    }
    for (index,v) in vs.enumerated() {
      XCTAssertEqual(
        1 + index,
        v.count
      )
    }
    for v in vs {
      let probes = [
        ChainCollection(e,v),
        ChainCollection(v,e)
      ]
      for probe in probes {
        XCTAssertFalse(probe.isEmpty)
        XCTAssertNotEqual(
          0,
          probe.count
        )
        XCTAssertNotEqual(
          probe.startIndex,
          probe.endIndex
        )
        XCTAssertEqual(
          probe.count,
          v.count
        )
        for (fromChain,fromV) in zip(probe,v) {
          XCTAssertEqual(
            fromChain,
            fromV
          )
        }
      }
    }
    
  }

 
  func testCollectionCounts() {
    self.haltingOnFirstError {
      // to avoid re-allocating each iteration, we reuse this
      var probe = ChainCollection(
        [0],
        [1]
      )
      let components = (0...5).map() {
        return [Int](
          repeating: $0,
          count: $0
        )
      }
      for a in components.indices {
        probe.a = components[a]
        XCTAssertEqual(
          a,
          probe.a.count
        )
        for b in components.indices {
          probe.b = components[b]
          XCTAssertEqual(
            b,
            probe.b.count
          )
          XCTAssertEqual(
            a + b,
            probe.count
          )
          XCTAssertEqual(
            probe.isEmpty,
            probe.count == 0
          )
          var manualCount: Int = 0
          for _ in probe {
            manualCount += 1
          }
          XCTAssertEqual(
            manualCount,
            probe.count
          )
        }
      }
    }
  }
  
  func testSpecificChain() {
    self.haltingOnFirstError() {
      let aa = [ 0,  1,  2,  3,  4, 5]
      let bb = [10, 11, 12, 13, 14]
      var expected: [Int] = []
      expected.append(contentsOf: aa)
      expected.append(contentsOf: bb)
      let probe = ChainCollection(
        aa,
        bb
      )
      XCTAssertEqual(
        expected.count,
        probe.count
      )
      for (target,candidate) in zip(expected,probe) {
        XCTAssertEqual(
          target,
          candidate
        )
      }
    }
  }

}
