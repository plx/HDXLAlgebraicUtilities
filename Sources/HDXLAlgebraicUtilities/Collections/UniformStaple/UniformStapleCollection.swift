//
//  UniformStapleCollection.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: Collection - UniformStapleCollection Exposure
// -------------------------------------------------------------------------- //

public extension Collection {

  /// Obtain a collection providing the contents of `self` uniformly stapled-together
  /// with the provided `leading` and `trailing` values.
  @inlinable
  func stapling<Leading,Trailing>(
    leading: Leading,
    trailing: Trailing) -> UniformStapleCollection<Self,Leading,Trailing> {
    return UniformStapleCollection<Self,Leading,Trailing>(
      source: self,
      leading: leading,
      trailing: trailing
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformStapleCollection - Definition
// -------------------------------------------------------------------------- //

/// Collection wherein each value in `source` is provided with (uniform)
/// leading-and-trailing "staples" (of type `Leading` and `Trailing`).
public struct UniformStapleCollection<Source:Collection,Leading,Trailing> {
  
  @usableFromInline
  internal var _source: Source
  
  @usableFromInline
  internal var _leading: Leading
  
  @usableFromInline
  internal var _trailing: Trailing
  
  /// "Designated", componentwise-initializer for `UniformStapleCollection`.
  ///
  /// Internal for now--as with the mutable properties, etc.--until I get some more
  /// feel for which manipulations and modifications I want to support.
  @inlinable
  internal init(
    source: Source,
    leading: Leading,
    trailing: Trailing) {
    self._source = source
    self._leading = leading
    self._trailing = trailing
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformStapleCollection - Core API
// -------------------------------------------------------------------------- //

public extension UniformStapleCollection {
  
  @inlinable
  var source: Source {
    get {
      return self._source
    }
  }
  
  @inlinable
  var leading: Leading {
    get {
      return self._leading
    }
  }
  
  @inlinable
  var trailing: Trailing {
    get {
      return self._trailing
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: UniformStapleCollection - Validatable
// -------------------------------------------------------------------------- //

extension UniformStapleCollection : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      guard
        isValidOrIndifferent(self._source),
        isValidOrIndifferent(self._leading),
        isValidOrIndifferent(self._trailing) else {
          return false
      }
      return true
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformStapleCollection - Equatable
// -------------------------------------------------------------------------- //

extension UniformStapleCollection : Equatable
  where
  Source:Equatable,
  Leading:Equatable,
  Trailing:Equatable {
  
  @inlinable
  public static func ==(
    lhs: UniformStapleCollection<Source,Leading,Trailing>,
    rhs: UniformStapleCollection<Source,Leading,Trailing>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    // note: in many-but-not-all cases leading/trailing should be first, but
    // in others that's super pessimal, so for now...just go in declaration order
    guard
      lhs._source == rhs._source,
      lhs._leading == rhs._leading,
      rhs._trailing == rhs._trailing else {
        return false
    }
    return true
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformStapleCollection - Hashable
// -------------------------------------------------------------------------- //

extension UniformStapleCollection : Hashable
  where
  Source:Hashable,
  Leading:Hashable,
  Trailing:Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self._source.hash(into: &hasher)
    self._leading.hash(into: &hasher)
    self._trailing.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformStapleCollection - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension UniformStapleCollection : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "(source: \(String(describing: self._source)), staples: (\(String(describing: self._leading)), \(String(describing: self._trailing))))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformStapleCollection - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension UniformStapleCollection : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "UniformStapleCollection<\(String(reflecting: Source.self)),\(String(reflecting: Leading.self)),\(String(reflecting: Trailing.self))>(\(String(reflecting: self._source)), leading: \(String(reflecting: self._leading)), trailing: \(String(reflecting: self._trailing)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformStapleCollection - Codable
// -------------------------------------------------------------------------- //

extension UniformStapleCollection : Codable
  where
  Leading:Codable,
  Source:Codable,
  Trailing:Codable {
  
  // synthesized OK
}

// -------------------------------------------------------------------------- //
// MARK: UniformStapleCollection - Identifiable
// -------------------------------------------------------------------------- //

extension UniformStapleCollection : Identifiable where Source:Identifiable {
  
  public typealias ID = Source.ID
  
  @inlinable
  public var id: ID {
    get {
      return self._source.id
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformStapleCollection - Collection
// -------------------------------------------------------------------------- //

extension UniformStapleCollection : Collection {
  
  public typealias Element = StapleValue<Leading,Source.Element,Trailing>
  public typealias Index = Source.Index
  public typealias Indices = Source.Indices
  public typealias SubSequence = UniformStapleCollection<Source.SubSequence,Leading,Trailing>
  
  @inlinable
  public var indices: Indices {
    get {
      return self.source.indices
    }
  }
  
  @inlinable
  public var isEmpty: Bool {
    get {
      return self.source.isEmpty
    }
  }
  
  @inlinable
  public var count: Int {
    get {
      return self.source.count
    }
  }
  
  @inlinable
  public var startIndex: Index {
    get {
      return self.source.startIndex
    }
  }
  
  @inlinable
  public var endIndex: Index {
    get {
      return self.source.endIndex
    }
  }
  
  @inlinable
  public func distance(
    from start: Index,
    to end: Index) -> Int {
    return self.source.distance(
      from: start,
      to: end
    )
  }
  
  @inlinable
  public subscript(index: Index) -> Element {
    get {
      return Element(
        leading: self.leading,
        value: self.source[index],
        trailing: self.trailing
      )
    }
  }
  
  @inlinable
  public subscript(bounds: Range<Index>) -> SubSequence {
    get {
      return SubSequence(
        source: self.source[bounds],
        leading: self.leading,
        trailing: self.trailing
      )
    }
  }
  
  @inlinable
  public func index(after i: Index) -> Index {
    return self.source.index(after: i)
  }
  
  @inlinable
  public func formIndex(after i: inout Index) {
    self.source.formIndex(after: &i)
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int) -> Index {
    return self.source.index(
      i,
      offsetBy: distance
    )
  }
  
  @inlinable
  public func formIndex(
    _ i: inout Index,
    offsetBy distance: Int) {
    self.source.formIndex(
      &i,
      offsetBy: distance
    )
  }

  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int,
    limitedBy limit: Index) -> Index? {
    return self.source.index(
      i,
      offsetBy: distance,
      limitedBy: limit
    )
  }

  @inlinable
  public func formIndex(
    _ i: inout Index,
    offsetBy distance: Int,
    limitedBy limit: Index) -> Bool {
    return self.source.formIndex(
      &i,
      offsetBy: distance,
      limitedBy: limit
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformStapleCollection - BidirectionalCollection
// -------------------------------------------------------------------------- //

extension UniformStapleCollection : BidirectionalCollection where Source:BidirectionalCollection {
  
  @inlinable
  public func index(before i: Index) -> Index {
    return self.source.index(before: i)
  }
  
  @inlinable
  public func formIndex(before i: inout Index) {
    self.source.formIndex(before: &i)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformStapleCollection - RandomAccessCollection
// -------------------------------------------------------------------------- //

extension UniformStapleCollection : RandomAccessCollection where Source:RandomAccessCollection {

}
