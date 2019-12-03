//
//  IndexPositionStorageMovementAttemptDestination.swift
//

import Foundation
import HDXLCommonUtilities

@usableFromInline
internal enum IndexPositionStorageMovementAttemptDestination<T> {
  
  case success(T)
  case becameEnd
  case misnavigation
  
}
