//
//  CardStackAnimationOptions.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//


import Foundation
import UIKit

/// The animation options provided to the internal card stack animator.
public struct CardStackAnimationOptions {

  /// The duration of the animation applied to the background cards after a canceled swipe has been recognized
  /// on the top card.
  ///
  /// If this value is `nil`, the animation will last exactly half the duration of
  /// `animationOptions.resetDuration` on the top card. This value must be greater than zero.
  /// Defaults to `nil`.
  public var resetDuration: TimeInterval? {
    didSet {
      if let duration = resetDuration {
        resetDuration = max(.leastNormalMagnitude, duration)
      }
    }
  }

  /// The duration of the card stack shift animation.
  ///
  /// This value must be greater than zero. Defaults to `0.1`.
  public var shiftDuration: TimeInterval = 0.1 {
    didSet {
      shiftDuration = max(.leastNormalMagnitude, shiftDuration)
    }
  }

  /// The duration of the animation applied to the background cards after a swipe has been recognized on the top card.
  ///
  /// If this value is `nil`, the animation will last exactly half the duration of
  /// `animationOptions.totalSwipeDuration` on the top card. This value must be greater than zero.
  /// Defaults to `nil`.
  public var swipeDuration: TimeInterval? {
    didSet {
      if let duration = swipeDuration {
        swipeDuration = max(.leastNormalMagnitude, duration)
      }
    }
  }

  /// The duration of the animation applied to the background cards after an `undo` has been triggered.
  ///
  /// If this value is `nil`, the animation will last exactly half the duration of
  /// `animationOptions.totalReverseSwipeDuration` on the top card. This value must be greater than zero.
  /// Defaults to `nil`.
  public var undoDuration: TimeInterval? {
    didSet {
      if let duration = undoDuration {
        undoDuration = max(.leastNormalMagnitude, duration)
      }
    }
  }
}


//Asdasdfljasdflajsdhfljashdfjasdf




protocol CardStackAnimatable {
  func animateReset(_ cardStack: SwipeCardStack,
                    topCard: SwipeCard)
  func animateShift(_ cardStack: SwipeCardStack,
                    withDistance distance: Int,
                    animated: Bool,
                    completion: ((Bool) -> Void)?)
  func animateSwipe(_ cardStack: SwipeCardStack,
                    topCard: SwipeCard,
                    direction: SwipeDirection,
                    forced: Bool,
                    animated: Bool,
                    completion: ((Bool) -> Void)?)
  func animateUndo(_ cardStack: SwipeCardStack,
                   topCard: SwipeCard,
                   animated: Bool,
                   completion: ((Bool) -> Void)?)
  func removeAllCardAnimations(_ cardStack: SwipeCardStack)
  func removeBackgroundCardAnimations(_ cardStack: SwipeCardStack)
}

/// The background card animator for the card stack.
///
/// All methods should be called only after the `CardStackManager` has been updated.
class CardStackAnimator: CardStackAnimatable {

  static let shared = CardStackAnimator()

  // MARK: - Main Methods

  func animateReset(_ cardStack: SwipeCardStack,
                    topCard: SwipeCard) {
    removeBackgroundCardAnimations(cardStack)

    let duration = cardStack.animationOptions.resetDuration ?? topCard.animationOptions.totalResetDuration / 2
    Animator.animateKeyFrames(
      withDuration: duration,
      options: .allowUserInteraction,
      animations: {
        for (position, card) in cardStack.backgroundCards.enumerated() {
          let transform = cardStack.transform(forCardAtPosition: position + 1)
          Animator.addTransformKeyFrame(to: card, transform: transform)
        }
      },
      completion: nil)
  }

  func animateShift(_ cardStack: SwipeCardStack,
                    withDistance distance: Int,
                    animated: Bool,
                    completion: ((Bool) -> Void)?) {
    removeAllCardAnimations(cardStack)

    if !animated {
      for (position, value) in cardStack.visibleCards.enumerated() {
        value.card.transform = cardStack.transform(forCardAtPosition: position)
      }
      completion?(true)
      return
    }

    // Place background cards in old positions
    for (position, value) in cardStack.visibleCards.enumerated() {
      value.card.transform = cardStack.transform(forCardAtPosition: position + distance)
    }

    // Animate background cards to new positions
    Animator.animateKeyFrames(
      withDuration: cardStack.animationOptions.shiftDuration,
      animations: {
        for (position, value) in cardStack.visibleCards.enumerated() {
          let transform = cardStack.transform(forCardAtPosition: position)
          Animator.addTransformKeyFrame(to: value.card, transform: transform)
        }
      },
      completion: completion)
  }

  func animateSwipe(_ cardStack: SwipeCardStack,
                    topCard: SwipeCard,
                    direction: SwipeDirection,
                    forced: Bool,
                    animated: Bool,
                    completion: ((Bool) -> Void)?) {
    removeBackgroundCardAnimations(cardStack)

    if !animated {
      for (position, value) in cardStack.visibleCards.enumerated() {
        cardStack.layoutCard(value.card, at: position)
      }
      completion?(true)
      return
    }

    let delay = swipeDelay(for: topCard, forced: forced)
    let duration = swipeDuration(cardStack,
                                 topCard: topCard,
                                 direction: direction,
                                 forced: forced)

    // No background cards left to animate, so we instead just delay calling the completion block
    if cardStack.visibleCards.isEmpty {
      DispatchQueue.main.asyncAfter(deadline: .now() + delay + duration) {
        completion?(true)
      }
      return
    }

    Animator.animateKeyFrames(
      withDuration: duration,
      delay: delay,
      animations: {
        for (position, value) in cardStack.visibleCards.enumerated() {
          Animator.addKeyFrame {
            cardStack.layoutCard(value.card, at: position)
          }
        }
      },
      completion: completion)
  }

  func animateUndo(_ cardStack: SwipeCardStack,
                   topCard: SwipeCard,
                   animated: Bool,
                   completion: ((Bool) -> Void)?) {
    removeBackgroundCardAnimations(cardStack)

    if !animated {
      for (position, card) in cardStack.backgroundCards.enumerated() {
        cardStack.layoutCard(card, at: position + 1)
      }
      completion?(true)
      return
    }

    // Place background cards in old positions
    for (position, card) in cardStack.backgroundCards.enumerated() {
      card.transform = cardStack.transform(forCardAtPosition: position)
    }

    // Animate background cards to new positions
    let duration = cardStack.animationOptions.undoDuration ?? topCard.animationOptions.totalReverseSwipeDuration / 2
    Animator.animateKeyFrames(
      withDuration: duration,
      animations: {
        for (position, card) in cardStack.backgroundCards.enumerated() {
          Animator.addKeyFrame {
            cardStack.layoutCard(card, at: position + 1)
          }
        }
      },
      completion: completion)
  }

  func removeBackgroundCardAnimations(_ cardStack: SwipeCardStack) {
    cardStack.backgroundCards.forEach { $0.removeAllAnimations() }
  }

  func removeAllCardAnimations(_ cardStack: SwipeCardStack) {
    cardStack.visibleCards.forEach { $0.card.removeAllAnimations() }
  }

  // MARK: - Animation Calculations

  func swipeDelay(for topCard: SwipeCard, forced: Bool) -> TimeInterval {
    let duration = topCard.animationOptions.totalSwipeDuration
    let relativeOverlayDuration = topCard.animationOptions.relativeSwipeOverlayFadeDuration
    let delay = duration * TimeInterval(relativeOverlayDuration)
    return forced ? delay : 0
  }

  func swipeDuration(_ cardStack: SwipeCardStack,
                     topCard: SwipeCard,
                     direction: SwipeDirection,
                     forced: Bool) -> TimeInterval {
    if let swipeDuration = cardStack.animationOptions.swipeDuration {
      return swipeDuration
    }

    if forced {
      return topCard.animationOptions.totalSwipeDuration / 2
    }

    let velocityFactor = topCard.dragSpeed(on: direction) / topCard.minimumSwipeSpeed(on: direction)

    // Card swiped below the minimum swipe speed
    if velocityFactor < 1.0 {
      return topCard.animationOptions.totalSwipeDuration / 2
    }

    // Card swiped at least the minimum swipe speed so return relative duration instead
    return 1.0 / (2.0 * TimeInterval(velocityFactor))
  }
}

//asdfasdlkfjasjdfasdf

struct Swipe: Equatable {
  var index: Int
  var direction: SwipeDirection
}

protocol CardStackStateManagable {
  var remainingIndices: [Int] { get }
  var swipes: [Swipe] { get }
  var totalIndexCount: Int { get }

  func insert(_ index: Int, at position: Int)

  func delete(_ index: Int)
  func delete(_ indices: [Int])
  func delete(indexAtPosition position: Int)
  func delete(indicesAtPositions positions: [Int])

  func swipe(_ direction: SwipeDirection)
  func undoSwipe() -> Swipe?
  func shift(withDistance distance: Int)
  func reset(withNumberOfCards numberOfCards: Int)
}

/// An internal class to manage the current state of the card stack.
class CardStackStateManager: CardStackStateManagable {

  /// The indices of the data source which have yet to be swiped.
  ///
  /// This array reflects the current order of the card stack, with the first element equal to the index of
  /// the top card in the data source. The order of this array accounts for both swiped and shifted cards in the stack.
  var remainingIndices: [Int] = []

  /// An array containing the swipe history of the card stack.
  var swipes: [Swipe] = []

  var totalIndexCount: Int {
    return remainingIndices.count + swipes.count
  }

  // MARK: - Insertion

  func insert(_ index: Int, at position: Int) {
    precondition(index >= 0, "Attempt to insert card at index \(index)")
    //swiftlint:disable:next line_length
    precondition(index <= totalIndexCount, "Attempt to insert card at index \(index), but there are only \(totalIndexCount + 1) cards after the update")
    precondition(position >= 0, "Attempt to insert card at position \(position)")
    //swiftlint:disable:next line_length
    precondition(position <= remainingIndices.count, "Attempt to insert card at position \(position), but there are only \(remainingIndices.count + 1) cards remaining in the stack after the update")

    // Increment all stored indices greater than or equal to index by 1
    remainingIndices = remainingIndices.map { $0 >= index ? $0 + 1 : $0 }
    swipes = swipes.map { $0.index >= index ? Swipe(index: $0.index + 1, direction: $0.direction) : $0 }

    remainingIndices.insert(index, at: position)
  }

  // MARK: - Deletion

  func delete(_ index: Int) {
    precondition(index >= 0, "Attempt to delete card at index \(index)")
    //swiftlint:disable:next line_length
    precondition(index < totalIndexCount, "Attempt to delete card at index \(index), but there are only \(totalIndexCount) cards before the update")

    swipes.removeAll { return $0.index == index }

    if let position = remainingIndices.firstIndex(of: index) {
      remainingIndices.remove(at: position)
    }

    // Decrement all stored indices greater than or equal to index by 1
    remainingIndices = remainingIndices.map { $0 >= index ? $0 - 1 : $0 }
    swipes = swipes.map { $0.index >= index ? Swipe(index: $0.index - 1, direction: $0.direction) : $0 }
  }

  func delete(_ indices: [Int]) {
    var remainingIndices = indices.removingDuplicates()

    while !remainingIndices.isEmpty {
      let index = remainingIndices[0]
      delete(index)

      remainingIndices.remove(at: 0)

      // Decrement all remaining indices greater than or equal to index by 1
      remainingIndices = remainingIndices.map { $0 >= index ? $0 - 1 : $0 }
    }
  }

  func delete(indexAtPosition position: Int) {
    precondition(position >= 0, "Attempt to delete card at position \(position)")
    //swiftlint:disable:next line_length
    precondition(position < remainingIndices.count, "Attempt to delete card at position \(position), but there are only \(remainingIndices.count) cards remaining in the stack before the update")

    // Decrement all stored indices greater than or equal to index by 1
    let index = remainingIndices.remove(at: position)
    remainingIndices = remainingIndices.map { $0 >= index ? $0 - 1 : $0 }
    swipes = swipes.map { $0.index >= index ? Swipe(index: $0.index - 1, direction: $0.direction) : $0 }
  }

  func delete(indicesAtPositions positions: [Int]) {
    var remainingPositions = positions.removingDuplicates()

    while !remainingPositions.isEmpty {
      let position = remainingPositions[0]
      delete(indexAtPosition: position)

      remainingPositions.remove(at: 0)

      // Decrement all remaining positions greater than or equal to position by 1
      remainingPositions = remainingPositions.map { $0 >= position ? $0 - 1 : $0 }
    }
  }

  // MARK: - Main Methods

  func swipe(_ direction: SwipeDirection) {
    if remainingIndices.isEmpty { return }
    let firstIndex = remainingIndices.removeFirst()
    let swipe = Swipe(index: firstIndex, direction: direction)
    swipes.append(swipe)
  }

  func undoSwipe() -> Swipe? {
    if swipes.isEmpty { return nil }
    let lastSwipe = swipes.removeLast()
    remainingIndices.insert(lastSwipe.index, at: 0)
    return lastSwipe
  }

  func shift(withDistance distance: Int) {
    remainingIndices.shift(withDistance: distance)
  }

  func reset(withNumberOfCards numberOfCards: Int) {
    self.remainingIndices = Array(0..<numberOfCards)
    self.swipes = []
  }
}

//asdkfjhaslkdjfhaslkjdfhalkjshdfasdf

open class SwipeCardStack: UIView, SwipeCardDelegate, UIGestureRecognizerDelegate {

  /// A internal structure for a `SwipeCard` and it's corresponding index in the card stack's `dataSource`.
  struct Card {
    var index: Int
    var card: SwipeCard
  }

  open var animationOptions = CardStackAnimationOptions()

  /// Return `false` if you wish to ignore all horizontal gestures on the card stack.
  ///
  /// You may wish to modify this property if your card stack is embedded in a `UIScrollView`, for example.
  open var shouldRecognizeHorizontalDrag: Bool = true

  /// Return `false` if you wish to ignore all vertical gestures on the card stack.
  ///
  /// You may wish to modify this property if your card stack is embedded in a `UIScrollView`, for example.
  open var shouldRecognizeVerticalDrag: Bool = true

  public weak var delegate: SwipeCardStackDelegate?

  public weak var dataSource: SwipeCardStackDataSource? {
    didSet {
      reloadData()
    }
  }

  public var cardStackInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) {
    didSet {
      setNeedsLayout()
    }
  }

  /// The data source index corresponding to the topmost card in the stack.
  public var topCardIndex: Int? {
    return visibleCards.first?.index
  }

  var numberOfVisibleCards: Int = 2

  /// An ordered array containing all pairs of currently visible cards.
  ///
  /// The `Card` at the first position is the topmost `SwipeCard` in the view hierarchy.
  var visibleCards: [Card] = []

  var topCard: SwipeCard? {
    return visibleCards.first?.card
  }

  var backgroundCards: [SwipeCard] {
    return Array(visibleCards.dropFirst()).map { $0.card }
  }

  var isEnabled: Bool {
    return !isAnimating && (topCard?.isUserInteractionEnabled ?? true)
  }

  var isAnimating: Bool = false

  let cardContainer = UIView()

  private var animator: CardStackAnimatable = CardStackAnimator.shared
  private var stateManager: CardStackStateManagable = CardStackStateManager()

  // MARK: - Initialization

  override public init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }

  convenience init(animator: CardStackAnimatable,
                   stateManager: CardStackStateManagable) {
    self.init(frame: .zero)
    self.animator = animator
    self.stateManager = stateManager
  }

  private func initialize() {
    addSubview(cardContainer)
  }

  // MARK: - Layout & Transform

  override open func layoutSubviews() {
    super.layoutSubviews()
    let width = bounds.width - (cardStackInsets.left + cardStackInsets.right)
    let height = bounds.height - (cardStackInsets.top + cardStackInsets.bottom)
    cardContainer.frame = CGRect(x: cardStackInsets.left, y: cardStackInsets.top, width: width, height: height)

    for (position, value) in visibleCards.enumerated() {
      layoutCard(value.card, at: position)
    }
  }

  func layoutCard(_ card: SwipeCard, at position: Int) {
    card.transform = .identity
    card.frame = CGRect(origin: .zero, size: cardContainer.frame.size)
    card.transform = transform(forCardAtPosition: position)
    card.isUserInteractionEnabled = position == 0
  }

  func scaleFactor(forCardAtPosition position: Int) -> CGPoint {
    return position == 0 ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.95, y: 0.95)
  }

  func transform(forCardAtPosition position: Int) -> CGAffineTransform {
    let cardScaleFactor = scaleFactor(forCardAtPosition: position)
    return CGAffineTransform(scaleX: cardScaleFactor.x, y: cardScaleFactor.y)
  }

  func backgroundCardDragTransform(topCard: SwipeCard, currentPosition: Int) -> CGAffineTransform {
    let panTranslation = topCard.panGestureRecognizer.translation(in: self)
    let minimumSideLength = min(bounds.width, bounds.height)
    let percentage = max(min(2 * abs(panTranslation.x) / minimumSideLength, 1),
                         min(2 * abs(panTranslation.y) / minimumSideLength, 1))

    let currentScale = scaleFactor(forCardAtPosition: currentPosition)
    let nextScale = scaleFactor(forCardAtPosition: currentPosition - 1)

    let scaleX = (1 - percentage) * currentScale.x + percentage * nextScale.x
    let scaleY = (1 - percentage) * currentScale.y + percentage * nextScale.y

    return CGAffineTransform(scaleX: scaleX, y: scaleY)
  }

  // MARK: - Gesture Recognizers

  override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    guard let topCard = topCard, topCard.panGestureRecognizer == gestureRecognizer else {
      return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }

    let velocity = topCard.panGestureRecognizer.velocity(in: self)

    if abs(velocity.x) > abs(velocity.y) {
      return shouldRecognizeHorizontalDrag
    }

    if abs(velocity.x) < abs(velocity.y) {
      return shouldRecognizeVerticalDrag
    }

    return topCard.gestureRecognizerShouldBegin(gestureRecognizer)
  }

  // MARK: - Main Methods

  /// Triggers a swipe on the card stack in the specified direction.
  /// - Parameters:
  ///   - direction: The direction to swipe the top card.
  ///   - animated: A boolean indicating whether the swipe action should be animated.
  public func swipe(_ direction: SwipeDirection, animated: Bool) {
    if !isEnabled { return }

    if animated {
      topCard?.swipe(direction: direction)
    } else {
      topCard?.removeFromSuperview()
    }

    if let topCard = topCard {
      swipeAction(topCard: topCard,
                  direction: direction,
                  forced: true,
                  animated: animated)
    }
  }

  func swipeAction(topCard: SwipeCard,
                   direction: SwipeDirection,
                   forced: Bool,
                   animated: Bool) {
    guard let swipedIndex = topCardIndex else { return }
    stateManager.swipe(direction)
    visibleCards.remove(at: 0)

    // Insert new card if needed
    if (stateManager.remainingIndices.count - visibleCards.count) > 0 {
      let bottomCardIndex = stateManager.remainingIndices[visibleCards.count]
      if let card = loadCard(at: bottomCardIndex) {
        insertCard(Card(index: bottomCardIndex, card: card), at: visibleCards.count)
      }
    }

    delegate?.cardStack?(self, didSwipeCardAt: swipedIndex, with: direction)

    if stateManager.remainingIndices.isEmpty {
      delegate?.didSwipeAllCards?(self)
      return
    }

    isAnimating = true
    animator.animateSwipe(self,
                          topCard: topCard,
                          direction: direction,
                          forced: forced,
                          animated: animated) { [weak self] finished in
      if finished {
        self?.isAnimating = false
      }
    }
  }

  /// Returns the most recently swiped card to the top of the card stack.
  /// - Parameter animated: A boolean indicating whether the undo action should be animated.
  public func undoLastSwipe(animated: Bool) {
    if !isEnabled { return }
    guard let previousSwipe = stateManager.undoSwipe() else { return }

    reloadVisibleCards()
    delegate?.cardStack?(self, didUndoCardAt: previousSwipe.index, from: previousSwipe.direction)

    if animated {
      topCard?.reverseSwipe(from: previousSwipe.direction)
    }

    isAnimating = true
    if let topCard = topCard {
      animator.animateUndo(self,
                           topCard: topCard,
                           animated: animated) { [weak self] finished in
        if finished {
          self?.isAnimating = false
        }
      }
    }
  }

  /// Shifts the remaining cards in the card stack by the specified distance. Any swiped cards are ignored.
  /// - Parameters:
  ///   - distance: The distance to shift the remaining cards by.
  ///   - animated: A boolean indicating whether the undo action should be animated.
  public func shift(withDistance distance: Int = 1, animated: Bool) {
    if !isEnabled || distance == 0 || visibleCards.count <= 1 { return }

    stateManager.shift(withDistance: distance)
    reloadVisibleCards()

    isAnimating = true
    animator.animateShift(self,
                          withDistance: distance,
                          animated: animated) { [weak self] finished in
      if finished {
        self?.isAnimating = false
      }
    }
  }

  // MARK: - Data Source

  public func reloadData() {
    guard let dataSource = dataSource else { return }
    let numberOfCards = dataSource.numberOfCards(in: self)
    stateManager.reset(withNumberOfCards: numberOfCards)
    reloadVisibleCards()
    isAnimating = false
  }

  /// Returns the `SwipeCard` at the specified index.
  /// - Parameter index: The index of the card in the data source.
  /// - Returns: The `SwipeCard` at the specified index, or `nil` if the card is not visible or the index is
  /// out of range.
  public func card(forIndexAt index: Int) -> SwipeCard? {
    for value in visibleCards where value.index == index {
      return value.card
    }
    return nil
  }

  func reloadVisibleCards() {
    visibleCards.forEach { $0.card.removeFromSuperview() }
    visibleCards.removeAll()

    let numberOfCards = min(stateManager.remainingIndices.count, numberOfVisibleCards)
    for position in 0..<numberOfCards {
      let index = stateManager.remainingIndices[position]
      if let card = loadCard(at: index) {
        insertCard(Card(index: index, card: card), at: position)
      }
    }
  }

  func insertCard(_ value: Card, at position: Int) {
    cardContainer.insertSubview(value.card, at: visibleCards.count - position)
    layoutCard(value.card, at: position)
    visibleCards.insert(value, at: position)
  }

  func loadCard(at index: Int) -> SwipeCard? {
    let card = dataSource?.cardStack(self, cardForIndexAt: index)
    card?.delegate = self
    card?.panGestureRecognizer.delegate = self
    return card
  }

  // MARK: - State Management

  /// Returns the current position of the card at the specified index.
  ///
  /// A returned value of `0` indicates that the card is the topmost card in the stack.
  /// - Parameter index: The index of the card in the data source.
  /// - Returns: The current position of the card at the specified index, or `nil` if the index if out of range or the
  /// card has been swiped.
  public func positionforCard(at index: Int) -> Int? {
    return stateManager.remainingIndices.firstIndex(of: index)
  }

  /// Returns the remaining number of cards in the card stack.
  /// - Returns: The number of cards in the card stack which have not yet been swiped.
  public func numberOfRemainingCards() -> Int {
    return stateManager.remainingIndices.count
  }

  /// Returns the indices of the swiped cards in the order they were swiped.
  /// - Returns: The indices of the swiped cards in the data source.
  public func swipedCards() -> [Int] {
    return stateManager.swipes.map { $0.index }
  }

  /// Inserts a new card with the given index at the specified position.
  ///
  /// Calling this method will not clear the swipe history nor trigger a reload of the data source.
  /// - Parameters:
  ///   - index: The index of the card in the data source.
  ///   - position: The position of the new card in the card stack.
  public func insertCard(atIndex index: Int, position: Int) {
    guard let dataSource = dataSource else { return }

    let oldNumberOfCards = stateManager.totalIndexCount
    let newNumberOfCards = dataSource.numberOfCards(in: self)

    stateManager.insert(index, at: position)

    if newNumberOfCards != oldNumberOfCards + 1 {
      let errorString = StringUtils.createInvalidUpdateErrorString(newCount: newNumberOfCards,
                                                                   oldCount: oldNumberOfCards,
                                                                   insertedCount: 1)
      fatalError(errorString)
    }

    reloadVisibleCards()
  }

  /// Appends a collection of new cards with the specifed indices to the bottom of the card stack.
  ///
  /// Calling this method will not clear the swipe history nor trigger a reload of the data source.
  /// - Parameter indices: The indices of the cards in the data source.
  public func appendCards(atIndices indices: [Int]) {
    guard let dataSource = dataSource else { return }

    let oldNumberOfCards = stateManager.totalIndexCount
    let newNumberOfCards = dataSource.numberOfCards(in: self)

    for index in indices {
      stateManager.insert(index, at: numberOfRemainingCards())
    }

    if newNumberOfCards != oldNumberOfCards + indices.count {
      let errorString = StringUtils.createInvalidUpdateErrorString(newCount: newNumberOfCards,
                                                                   oldCount: oldNumberOfCards,
                                                                   insertedCount: indices.count)
      fatalError(errorString)
    }

    reloadVisibleCards()
  }

  /// Deletes the cards at the specified indices. If an index corresponds to a card that has been swiped,
  /// it is removed from the swipe history.
  ///
  /// Calling this method will not clear the swipe history nor trigger a reload of the data source.
  /// - Parameter indices: The indices of the cards in the data source to delete.
  public func deleteCards(atIndices indices: [Int]) {
    guard let dataSource = dataSource else { return }

    let oldNumberOfCards = stateManager.totalIndexCount
    let newNumberOfCards = dataSource.numberOfCards(in: self)

    if newNumberOfCards != oldNumberOfCards - indices.count {
      let errorString = StringUtils.createInvalidUpdateErrorString(newCount: newNumberOfCards,
                                                                   oldCount: oldNumberOfCards,
                                                                   deletedCount: indices.count)
      fatalError(errorString)
    }

    stateManager.delete(indices)
    reloadVisibleCards()
  }

  /// Deletes the cards at the specified positions in the card stack.
  ///
  /// Calling this method will not clear the swipe history nor trigger a reload of the data source.
  /// - Parameter positions: The positions of the cards to delete in the card stack.
  public func deleteCards(atPositions positions: [Int]) {
    guard let dataSource = dataSource else { return }

    let oldNumberOfCards = stateManager.totalIndexCount
    let newNumberOfCards = dataSource.numberOfCards(in: self)

    if newNumberOfCards != oldNumberOfCards - positions.count {
      let errorString = StringUtils.createInvalidUpdateErrorString(newCount: newNumberOfCards,
                                                                   oldCount: oldNumberOfCards,
                                                                   deletedCount: positions.count)
      fatalError(errorString)
    }

    stateManager.delete(indicesAtPositions: positions)
    reloadVisibleCards()
  }

  // MARK: - SwipeCardDelegate

  func cardDidTap(_ card: SwipeCard) {
    guard let topCardIndex = topCardIndex else { return }
    delegate?.cardStack?(self, didSelectCardAt: topCardIndex)
  }

  func cardDidBeginSwipe(_ card: SwipeCard) {
    animator.removeBackgroundCardAnimations(self)
  }

  func cardDidContinueSwipe(_ card: SwipeCard) {
    for (position, backgroundCard) in backgroundCards.enumerated() {
      backgroundCard.transform = backgroundCardDragTransform(topCard: card, currentPosition: position + 1)
    }
  }

  func cardDidCancelSwipe(_ card: SwipeCard) {
    animator.animateReset(self, topCard: card)
  }

  func cardDidFinishSwipeAnimation(_ card: SwipeCard) {
    card.removeFromSuperview()
  }

  func cardDidSwipe(_ card: SwipeCard, withDirection direction: SwipeDirection) {
    swipeAction(topCard: card, direction: direction, forced: false, animated: true)
  }
}

//asdflkasjdflkajsdlkfjasdf

public protocol SwipeCardStackDataSource: AnyObject {
  func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard
  func numberOfCards(in cardStack: SwipeCardStack) -> Int
}

//asdflkasjdfkajsdf

@objc public protocol SwipeCardStackDelegate: AnyObject {

  @objc
  optional func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int)

  @objc
  optional func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection)

  @objc
  optional func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection)

  @objc
  optional func didSwipeAllCards(_ cardStack: SwipeCardStack)
}




