//
//  InlineProduct6+SwiftUIConditionalConformances.swift
//

import Foundation
import SwiftUI
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: InlineProduct6 - AdditiveArithmetic
// -------------------------------------------------------------------------- //

extension InlineProduct6: AdditiveArithmetic
  where
  A:AdditiveArithmetic,
  B:AdditiveArithmetic,
  C:AdditiveArithmetic,
  D:AdditiveArithmetic,
  E:AdditiveArithmetic,
  F:AdditiveArithmetic {
   
}

// -------------------------------------------------------------------------- //
// MARK: InlineProduct6 - VectorArithmetic
// -------------------------------------------------------------------------- //

extension InlineProduct6 : VectorArithmetic
  where
  A:VectorArithmetic,
  B:VectorArithmetic,
  C:VectorArithmetic,
  D:VectorArithmetic,
  E:VectorArithmetic,
  F:VectorArithmetic {
  

}
