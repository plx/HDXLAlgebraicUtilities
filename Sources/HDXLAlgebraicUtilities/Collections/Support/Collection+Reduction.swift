//
//  Collection+Reduction.swift
//

import Foundation
import HDXLCommonUtilities

internal extension Collection {
  
  @inlinable
  func reduced(to index: Index) -> CollectionOfOne<Element> {
    precondition(index < self.endIndex)
    return CollectionOfOne<Element>(self[index])
  }
  
}
