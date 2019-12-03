//
//  IndexPositionStorageEndReplacement.swift
//

import Foundation
import HDXLCommonUtilities

@usableFromInline
internal enum IndexPositionStorageEndReplacement<T> {
  
  case position(T)
  case end
  case misnavigation
  
}
