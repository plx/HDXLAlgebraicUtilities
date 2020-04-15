//
//  UniformLeadingStapleCollection.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: Collection - UniformLeadingStapleCollection Exposure
// -------------------------------------------------------------------------- //

public extension Collection {

  /// Obtain a collection providing the contents of `self` uniformly stapled-together
  /// with the provided `leading` value.
  @inlinable
  func stapling<Leading>(
    leading: Leading) -> UniformLeadingStapleCollection<Self,Leading> {
    return UniformLeadingStapleCollection<Self,Leading>(
      source: self,
      leading: leading
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformLeadingStapleCollection - Definition
// -------------------------------------------------------------------------- //

/// Collection wherein each value in `source` is provided with (uniform)
/// leading "staples" (of type `Leading`).
public struct UniformLeadingStapleCollection<Source:Collection,Leading> {
  
  @usableFromInline
  internal var _source: Source
  
  @usableFromInline
  internal var _leading: Leading
  
  /// "Designated", componentwise-initializer for `UniformLeadingStapleCollection`.
  ///
  /// Internal for now--as with the mutable properties, etc.--until I get some more
  /// feel for which manipulations and modifications I want to support.
  @inlinable
  internal init(
    source: Source,
    leading: Leading) {
    self._source = source
    self._leading = leading
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformLeadingStapleCollection - Core API
// -------------------------------------------------------------------------- //

public extension UniformLeadingStapleCollection {
  
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

}

// -------------------------------------------------------------------------- //
// MARK: UniformLeadingStapleCollection - Validatable
// -------------------------------------------------------------------------- //

extension UniformLeadingStapleCollection : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      guard
        isValidOrIndifferent(self._source),
        isValidOrIndifferent(self._leading) else {
          return false
      }
      return true
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformLeadingStapleCollection - Equatable
// -------------------------------------------------------------------------- //

extension UniformLeadingStapleCollection : Equatable
  where
  Source:Equatable,
  Leading:Equatable {
  
  @inlinable
  public static func ==(
    lhs: UniformLeadingStapleCollection<Source,Leading>,
    rhs: UniformLeadingStapleCollection<Source,Leading>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    // note: in many-but-not-all cases leading should be first, but
    // in others that's super pessimal, so for now...just go in declaration order
    guard
      lhs._source == rhs._source,
      lhs._leading == rhs._leading else {
        return false
    }
    return true
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformLeadingStapleCollection - Hashable
// -------------------------------------------------------------------------- //

extension UniformLeadingStapleCollection : Hashable
  where
  Source:Hashable,
  Leading:Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self._source.hash(into: &hasher)
    self._leading.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformLeadingStapleCollection - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension UniformLeadingStapleCollection : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "(source: \(String(describing: self._source)), leading: \(String(describing: self._leading)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformLeadingStapleCollection - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension UniformLeadingStapleCollection : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "UniformLeadingStapleCollection<\(String(reflecting: Source.self)),\(String(reflecting: Leading.self))>(\(String(reflecting: self._source)), leading: \(String(reflecting: self._leading)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformLeadingStapleCollection - Codable
// -------------------------------------------------------------------------- //

extension UniformLeadingStapleCollection : Codable
  where
  Leading:Codable,
  Source:Codable {
  
  // synthesized OK
}

// -------------------------------------------------------------------------- //
// MARK: UniformLeadingStapleCollection - Identifiable
// -------------------------------------------------------------------------- //

extension UniformLeadingStapleCollection : Identifiable where Source:Identifiable {
  
  public typealias ID = Source.ID
  
  @inlinable
  public var id: ID {
    get {
      return self._source.id
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformLeadingStapleCollection - Collection
// -------------------------------------------------------------------------- //

extension UniformLeadingStapleCollection : Collection {
  
  public typealias Element = LeadingStapleValue<Leading,Source.Element>
  public typealias Index = Source.Index
  public typealias Indices = Source.Indices
  public typealias SubSequence = UniformLeadingStapleCollection<Source.SubSequence,Leading>
  
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
        value: self.source[index]
      )
    }
  }
  
  @inlinable
  public subscript(bounds: Range<Index>) -> SubSequence {
    get {
      return SubSequence(
        source: self.source[bounds],
        leading: self.leading
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
// MARK: UniformLeadingStapleCollection - BidirectionalCollection
// -------------------------------------------------------------------------- //

extension UniformLeadingStapleCollection : BidirectionalCollection where Source:BidirectionalCollection {
  
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
// MARK: UniformLeadingStapleCollection - RandomAccessCollection
// -------------------------------------------------------------------------- //

extension UniformLeadingStapleCollection : RandomAccessCollection where Source:RandomAccessCollection {

}
