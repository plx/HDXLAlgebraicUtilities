//
//  Chain3CollectionStorage.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - Definition
// -------------------------------------------------------------------------- //

@usableFromInline
internal final class Chain3CollectionStorage<
  A:Collection,
  B:Collection,
  C:Collection>
  where
  A.Element == B.Element,
  A.Element == C.Element {
  
  // -------------------------------------------------------------------------- //
  // MARK: Constituent Collections
  // -------------------------------------------------------------------------- //
  
  @usableFromInline
  @GenericCollectionStorage
  var a: A {
    didSet {
      self.resetCaches()
    }
  }
  
  @usableFromInline
  @GenericCollectionStorage
  var b: B {
    didSet {
      self.resetCaches()
    }
  }
  
  @usableFromInline
  @GenericCollectionStorage
  var c: C {
    didSet {
      self.resetCaches()
    }
  }
    
  // ------------------------------------------------------------------------ //
  // MARK: Cache-Management
  // ------------------------------------------------------------------------ //
  
  @inlinable
  internal func resetCaches() {
    self._isEmpty = nil
    self._count = nil
    
    self._rangeForA = nil
    self._rangeForB = nil
    self._rangeForC = nil
    
    self._firstPosition = nil
    self._finalPosition = nil
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: isEmpty Support
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  var _isEmpty: Bool? = nil
  
  @inlinable
  var isEmpty: Bool {
    get {
      return self._isEmpty.obtainAssuredValue(
        fallingBackUpon: self.calculateIsEmpty()
      )
    }
  }
  
  @inlinable
  func calculateIsEmpty() -> Bool {
    return (
      self.a.isEmpty
      &&
      self.b.isEmpty
      &&
      self.c.isEmpty
    )
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: count Support
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  var _count: Int? = nil
  
  @inlinable
  var count: Int {
    get {
      return self._count.obtainAssuredValue(
        fallingBackUpon: self.calculateCount()
      )
    }
  }
  
  @usableFromInline
  func calculateCount() -> Int {
    guard !self.isEmpty else {
      return 0
    }
    return (
      self.$a.count
      +
      self.$b.count
      +
      self.$c.count
    )
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: Incremental Range Support - Storage
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  var _rangeForA: Range<Int>? = nil

  @usableFromInline
  var _rangeForB: Range<Int>? = nil

  @usableFromInline
  var _rangeForC: Range<Int>? = nil

  // ------------------------------------------------------------------------ //
  // MARK: Incremental Range Support - Access
  // ------------------------------------------------------------------------ //
  
  @inlinable
  var rangeForA: Range<Int> {
    get {
      return self._rangeForA.obtainAssuredValue(
        fallingBackUpon: self.calculateRangeForA()
      )
    }
  }

  @inlinable
  var rangeForB: Range<Int> {
    get {
      return self._rangeForB.obtainAssuredValue(
        fallingBackUpon: self.calculateRangeForB()
      )
    }
  }

  @inlinable
  var rangeForC: Range<Int> {
    get {
      return self._rangeForC.obtainAssuredValue(
        fallingBackUpon: self.calculateRangeForC()
      )
    }
  }

  // ------------------------------------------------------------------------ //
  // MARK: Incremental Range Support - Calculation
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  func calculateRangeForA() -> Range<Int> {
    guard !self.isEmpty else {
      return 0..<0
    }
    return 0..<self.$a.count
  }

  @usableFromInline
  func calculateRangeForB() -> Range<Int> {
    guard !self.isEmpty else {
      return 0..<0
    }
    let previousUpperBound = self.rangeForA.upperBound
    let currentCount = self.$b.count
    return previousUpperBound..<(previousUpperBound + currentCount)
  }

  @usableFromInline
  func calculateRangeForC() -> Range<Int> {
    guard !self.isEmpty else {
      return 0..<0
    }
    let previousUpperBound = self.rangeForB.upperBound
    let currentCount = self.$c.count
    return previousUpperBound..<(previousUpperBound + currentCount)
  }
    
  // ------------------------------------------------------------------------ //
  // MARK: Index Support
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  internal typealias Index = Chain3CollectionIndex<A,B,C>
  
  @usableFromInline
  internal typealias Position = Index.Position
  
  // ------------------------------------------------------------------------ //
  // MARK: Extremal Position Support - Storage
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  var _firstPosition: Position?? = nil

  @usableFromInline
  var _finalPosition: Position?? = nil

  // ------------------------------------------------------------------------ //
  // MARK: Extremal Position Support - Access
  // ------------------------------------------------------------------------ //

  @inlinable
  var firstPosition: Position? {
    get {
      return self._firstPosition.obtainAssuredValue(
        fallingBackUpon: self.calculateFirstPosition()
      )
    }
  }

  @inlinable
  var finalPosition: Position? {
    get {
      return self._finalPosition.obtainAssuredValue(
        fallingBackUpon: self.calculateFinalPosition()
      )
    }
  }

  // ------------------------------------------------------------------------ //
  // MARK: Extremal Position Support - Calculation
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  func calculateFirstPosition() -> Position? {
    // recall: lazy evaluation, first-to-last
    return Position.firstNonNil(
      self.$a.firstSubscriptableIndex,
      self.$b.firstSubscriptableIndex,
      self.$c.firstSubscriptableIndex
    )
  }

  @usableFromInline
  func calculateFinalPosition() -> Position? {
    // recall: lazy evaluation, last-to-first
    return Position.finalNonNil(
      self.$a.finalSubscriptableIndex,
      self.$b.finalSubscriptableIndex,
      self.$c.finalSubscriptableIndex
    )
  }

  // ------------------------------------------------------------------------ //
  // MARK: Extremal Indices
  // ------------------------------------------------------------------------ //

  @inlinable
  var startIndex: Index {
    get {
      guard let firstPosition = self.firstPosition else {
        return self.endIndex
      }
      return Index(position: firstPosition)
    }
  }
  
  @inlinable
  var endIndex: Index {
    get {
      return Index.endIndex
    }
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: Initialization
  // ------------------------------------------------------------------------ //
  
  @inlinable
  required init(
    _ a: A,
    _ b: B,
    _ c: C) {
    self.a = a
    self.b = b
    self.c = c
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: Position Support
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  internal typealias Element = A.Element
  
  @inlinable
  subscript(position: Position) -> Element {
    get {
      switch position {
      case .a(let a):
        return self.a[a]
      case .b(let b):
        return self.b[b]
      case .c(let c):
        return self.c[c]
      }
    }
  }
  
  @usableFromInline
  func position(after position: Position) -> Position? {
    // NOTE: this blindly does all 9 advancements then figures out at the end
    // if it "went over the edge" or not. This is more-efficient than it looks
    // b.c the `nextSubscriptableIndex` usually just returns the supplied index,
    // and it's *hopefully* not worth bloating this with a ton of early-exits
    // (e.g. checking for "hold position" after each advancement and bailing).
    guard !self.isEmpty else {
      return nil
    }
    switch position {
    case .a(let a):
      guard let nextAIndex = self.$a.subscriptableIndex(after: a) else {
        return self.firstPosition(after: .a)
      }
      return .a(nextAIndex)
    case .b(let b):
      guard let nextBIndex = self.$b.subscriptableIndex(after: b) else {
        return self.firstPosition(after: .b)
      }
      return .b(nextBIndex)
    case .c(let c):
      guard let nextCIndex = self.$c.subscriptableIndex(after: c) else {
        return self.firstPosition(after: .c)
      }
      return .c(nextCIndex)
    }
  }
  
  @inlinable
  func position(
    _ position: Position,
    offsetBy distance: Int) -> Position? {
    let linearPosition = self.linearPosition(forPosition: position)
    let destination = linearPosition + distance
    guard (0...self.count).contains(destination) else {
      preconditionFailure("Invalid navigation, went from \(position) (linear: \(linearPosition)) => \(destination) (offset: \(distance)), but valid range is 0...\(self.count)!")
    }
    guard destination < self.count else {
      return nil
    }
    return self.position(
      forLinearPosition: destination
    )
  }
  
  @inlinable
  func distance(
    from start: Position,
    to end: Position) -> Int {
    return (
      self.linearPosition(forPosition: end)
      -
      self.linearPosition(forPosition: start)
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - Reflection Support
// -------------------------------------------------------------------------- //

internal extension Chain3CollectionStorage {
  
  @inlinable
  static var shortTypeName: String {
    get {
      return "Chain3CollectionStorage"
    }
  }
  
  @inlinable
  static var completeTypeName: String {
    get {
      return "\(self.shortTypeName)<\(self.typeParameterNames)>"
    }
  }
  
  @inlinable
  static var typeParameterNames: String {
    get {
      return [
        String(reflecting: A.self),
        String(reflecting: B.self),
        String(reflecting: C.self)
        ].joined(separator: ", ")
    }
  }

  @inlinable
  var parameterDescriptions: String {
    get {
      return [
        String(reflecting: self.a),
        String(reflecting: self.b),
        String(reflecting: self.c)
        ].joined(separator: ", ")
      
    }
  }

  @inlinable
  var parameterDebugDescriptions: String {
    get {
      return [
        "a: \(String(reflecting: self.a))",
        "b: \(String(reflecting: self.b))",
        "c: \(String(reflecting: self.c))"
        ].joined(separator: ", ")

    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - Position Advancement Support
// -------------------------------------------------------------------------- //

internal extension Chain3CollectionStorage {
  
  @usableFromInline
  func firstPositionAfterA() -> Position? {
    return Position.firstNonNil(
      nil,
      self.$b.firstSubscriptableIndex,
      self.$c.firstSubscriptableIndex
    )
  }
  
  @usableFromInline
  func firstPositionAfterB() -> Position? {
    return Position.firstNonNil(
      nil,
      nil,
      self.$c.firstSubscriptableIndex
    )
  }
  
  @usableFromInline
  func firstPositionAfterC() -> Position? {
    return nil
  }
    
  @inlinable
  func firstPosition(after position: Arity3Position) -> Position? {
    switch position {
    case .a:
      return self.firstPositionAfterA()
    case .b:
      return self.firstPositionAfterB()
    case .c:
      return self.firstPositionAfterC()
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - Position Linearization Support
// -------------------------------------------------------------------------- //

internal extension Chain3CollectionStorage {
  
  @inlinable
  func position(forLinearPosition linearPosition: Int) -> Position {
    if self.rangeForA.contains(linearPosition) {
      return .a(
        self.a.index(
          self.a.startIndex,
          offsetBy: linearPosition - self.rangeForA.lowerBound
        )
      )
    } else if self.rangeForB.contains(linearPosition) {
      return .b(
        self.b.index(
          self.b.startIndex,
          offsetBy: linearPosition - self.rangeForB.lowerBound
        )
      )
    } else if self.rangeForC.contains(linearPosition) {
      return .c(
        self.c.index(
          self.c.startIndex,
          offsetBy: linearPosition - self.rangeForC.lowerBound
        )
      )
    } else {
      preconditionFailure("Attempted to obtain position for out-of-bounds `linearPosition` \(linearPosition) in \(self.debugDescription)!")
    }
  }
  
  @inlinable
  func linearPosition(forPosition position: Position) -> Int {
    switch position {
    case .a(let a):
      return (
        self.rangeForA.lowerBound
        +
        self.a.distance(
          from: self.a.startIndex,
          to: a
        )
      )
    case .b(let b):
      return (
        self.rangeForB.lowerBound
        +
        self.b.distance(
          from: self.b.startIndex,
          to: b
        )
      )
    case .c(let c):
      return (
        self.rangeForC.lowerBound
          +
          self.c.distance(
            from: self.c.startIndex,
            to: c
        )
      )
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - Position Retreat
// -------------------------------------------------------------------------- //

internal extension Chain3CollectionStorage
  where
  A:BidirectionalCollection,
  B:BidirectionalCollection,
  C:BidirectionalCollection {
  
  @usableFromInline
  func position(before position: Position) -> Position? {
    // NOTE: this blindly does all 9 retreats then figures out at the end
    // if it "went over the edge" or not. This is more-efficient than it looks
    // b.c the `previousSubscriptableIndex` usually just returns the supplied index,
    // and it's *hopefully* not worth bloating this with a ton of early-exits
    // (e.g. checking for "hold position" after each advancement and bailing).
    guard !self.isEmpty else {
      return nil
    }
    switch position {
    case .c(let c):
      guard let previousCIndex = self.$c.subscriptableIndex(before: c) else {
        return self.finalPositionBeforeC()
      }
      return .c(previousCIndex)
    case .b(let b):
      guard let previousBIndex = self.$b.subscriptableIndex(before: b) else {
        return self.finalPositionBeforeB()
      }
      return .b(previousBIndex)
    case .a(let a):
      guard let previousAIndex = self.$a.subscriptableIndex(before: a) else {
        return self.finalPositionBeforeA()
      }
      return .a(previousAIndex)
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - Position Retreat Support
// -------------------------------------------------------------------------- //

internal extension Chain3CollectionStorage {
  
  @usableFromInline
  func finalPositionBeforeA() -> Position? {
    return nil
  }
  
  @usableFromInline
  func finalPositionBeforeB() -> Position? {
    return Position.finalNonNil(
      self.$a.finalSubscriptableIndex,
      nil,
      nil
    )
  }
  
  @usableFromInline
  func finalPositionBeforeC() -> Position? {
    return Position.finalNonNil(
      self.$a.finalSubscriptableIndex,
      self.$b.finalSubscriptableIndex,
      nil
    )
  }
  
  @inlinable
  func finalPosition(before position: Arity3Position) -> Position? {
    switch position {
    case .a:
      return self.finalPositionBeforeA()
    case .b:
      return self.finalPositionBeforeB()
    case .c:
      return self.finalPositionBeforeC()
    }
  }

  
}

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - With Derivation
// -------------------------------------------------------------------------- //

internal extension Chain3CollectionStorage {
  
  // TODO: any way to pull the cached properties over for the unchanged properties?
  
  @inlinable
  func with(a: A) -> Chain3CollectionStorage<A,B,C> {
    return Chain3CollectionStorage<A,B,C>(
      a,
      b,
      c
    )
  }
  
  @inlinable
  func with(b: B) -> Chain3CollectionStorage<A,B,C> {
    return Chain3CollectionStorage<A,B,C>(
      a,
      b,
      c
    )
  }
  
  @inlinable
  func with(c: C) -> Chain3CollectionStorage<A,B,C> {
    return Chain3CollectionStorage<A,B,C>(
      a,
      b,
      c
    )
  }
    
}

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - Validatable
// -------------------------------------------------------------------------- //

extension Chain3CollectionStorage : Validatable {
  
  @inlinable
  internal var isValid: Bool {
    get {
      guard
        isValidOrIndifferent(self.a),
        isValidOrIndifferent(self.b),
        isValidOrIndifferent(self.c) else {
          return false
      }
      return true
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - Equatable
// -------------------------------------------------------------------------- //

extension Chain3CollectionStorage : Equatable
  where
  A:Equatable,
  B:Equatable,
  C:Equatable {
  
  @inlinable
  internal static func ==(
    lhs: Chain3CollectionStorage<A,B,C>,
    rhs: Chain3CollectionStorage<A,B,C>) -> Bool {
    guard lhs !== rhs else {
      return true
    }
    guard
      lhs.a == rhs.a,
      lhs.b == rhs.b,
      lhs.c == rhs.c else {
        return false
    }
    return true
  }

}

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - Hashable
// -------------------------------------------------------------------------- //

extension Chain3CollectionStorage : Hashable
  where
  A:Hashable,
  B:Hashable,
  C:Hashable {
  
  @inlinable
  internal func hash(into hasher: inout Hasher) {
    self.a.hash(into: &hasher)
    self.b.hash(into: &hasher)
    self.c.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain3CollectionStorage : CustomStringConvertible {
  
  @inlinable
  internal var description: String {
    get {
      return "( \(self.parameterDescriptions) )"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension Chain3CollectionStorage : CustomDebugStringConvertible {
  
  @inlinable
  internal var debugDescription: String {
    get {
      return "\(type(of: self).completeTypeName)(\(self.parameterDebugDescriptions)"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - Codable
// -------------------------------------------------------------------------- //

extension Chain3CollectionStorage : Codable
  where
  A:Codable,
  B:Codable,
  C:Codable {
  
  @usableFromInline
  internal enum CodingKeys : String, CodingKey {
    
    case a = "a"
    case b = "b"
    case c = "c"
    
    @inlinable
    internal var intValue: Int? {
      get {
        switch self {
        case .a:
          return 0
        case .b:
          return 1
        case .c:
          return 2
        }
      }
    }
    
    @inlinable
    internal init?(intValue: Int) {
      switch intValue {
      case 0:
        self = .a
      case 1:
        self = .b
      case 2:
        self = .c
      default:
        return nil
      }
    }
    
  }
  
  @inlinable
  internal func encode(to encoder: Encoder) throws {
    var values = encoder.container(keyedBy: CodingKeys.self)
    try values.encode(
      self.a,
      forKey: .a
    )
    try values.encode(
      self.b,
      forKey: .b
    )
    try values.encode(
      self.c,
      forKey: .c
    )
  }
  
  @inlinable
  internal convenience init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.init(
      try values.decode(
        A.self,
        forKey: .a
      ),
      try values.decode(
        B.self,
        forKey: .b
      ),
      try values.decode(
        C.self,
        forKey: .c
      )
    )
  }
  
}
