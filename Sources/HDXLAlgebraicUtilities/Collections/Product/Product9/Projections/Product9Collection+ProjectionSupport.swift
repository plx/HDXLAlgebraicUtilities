//
//  Product9Collection+ProjectionSupport.swift
//

import Foundation
import HDXLCommonUtilities

public extension Product9Collection {

  /// Convenience for the inline position representation; available on type *regardless* of `Position` choice.
  typealias InlinePositionRepresentation = InlineProduct9<A.Index,B.Index,C.Index,D.Index,E.Index,F.Index,G.Index,H.Index,I.Index>
  
  /// Convenience for the cow position representation; available on type *regardless* of `Position` choice.
  typealias COWPositionRepresentation = COWProduct9<A.Index,B.Index,C.Index,D.Index,E.Index,F.Index,G.Index,H.Index,I.Index>
  
  /// Convenience for the inline element representation; available on type *regardless* of `Element` choice.
  typealias InlineElementRepresentation = InlineProduct9<A.Element,B.Element,C.Element,D.Element,E.Element,F.Element,G.Element,H.Element,I.Element>
  
  /// Convenience for the cow element representation; available on type *regardless* of `Element` choice.
  typealias COWElementRepresentation = COWProduct9<A.Element,B.Element,C.Element,D.Element,E.Element,F.Element,G.Element,H.Element,I.Element>

}
