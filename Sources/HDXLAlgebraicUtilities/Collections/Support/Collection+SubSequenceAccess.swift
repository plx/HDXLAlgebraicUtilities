//
//  Collection+SubSequenceAccess.swift
//

import Foundation
import HDXLCommonUtilities

internal extension Collection {
  
  /// Utility to grab the full-range `SubSequence` of `self`.
  @inlinable
  var completeSubSequence: SubSequence {
    get {
      return self[self.completeRange]
    }
  }
  
  /// Shorthand for `self.startIndex..<self.endIndex`.
  @inlinable
  var completeRange: Range<Index> {
    get {
      return self.startIndex..<self.endIndex
    }
  }
  
}
