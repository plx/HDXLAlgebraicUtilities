//
//  Sum8+SwiftUIConditionalConformances.swift
//

import Foundation
import SwiftUI
import HDXLCommonUtilities

public struct Sum8View<A:View,B:View,C:View,D:View,E:View,F:View,G:View,H:View>: View {
  
  @usableFromInline
  internal typealias Storage = Sum8<A,B,C,D,E,F,G,H>
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal func obtainStorageView() -> AnyView {
    switch self.storage {
    case .a(let view):
      return AnyView(view)
    case .b(let view):
      return AnyView(view)
    case .c(let view):
      return AnyView(view)
    case .d(let view):
      return AnyView(view)
    case .e(let view):
      return AnyView(view)
    case .f(let view):
      return AnyView(view)
    case .g(let view):
      return AnyView(view)
    case .h(let view):
      return AnyView(view)
    }
  }
  
  @inlinable
  public var body: some View {
    get {
      self.obtainStorageView()
    }
  }
  
}
