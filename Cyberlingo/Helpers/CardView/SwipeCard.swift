//
//  CardAnimationOptions.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//


import Foundation
import UIKit

/// The animation options provided to the internal card animator.
public struct CardAnimationOptions {

  /// The maximum rotation angle of the card, measured in radians.
  ///
  /// Defined as a value in the range `[-CGFloat.pi/2, CGFloat.pi/2]`. Defaults to `CGFloat.pi/10`.
  public var maximumRotationAngle: CGFloat = .pi / 10 {
    didSet {
      maximumRotationAngle = max(-.pi / 2, min(maximumRotationAngle, .pi / 2))
    }
  }

  /// The duration of the fade animation applied to the overlays after the reverse swipe translation.
  /// Measured relative to the total reverse swipe duration.
  ///
  /// Defined as a value in the range `[0, 1]`. Defaults to `0.15`.
  public var relativeReverseSwipeOverlayFadeDuration: Double = 0.15 {
    didSet {
      relativeReverseSwipeOverlayFadeDuration = max(0, min(relativeReverseSwipeOverlayFadeDuration, 1))
    }
  }

  /// The duration of the fade animation applied to the overlays before the swipe translation.
  /// Measured relative to the total swipe duration.
  ///
  /// Defined as a value in the range `[0, 1]`. Defaults to `0.15`.
  public var relativeSwipeOverlayFadeDuration: Double = 0.15 {
    didSet {
      relativeSwipeOverlayFadeDuration = max(0, min(relativeSwipeOverlayFadeDuration, 1))
    }
  }

  /// The damping coefficient of the spring-like animation applied when a swipe is canceled.
  ///
  /// Defined as a value in the range `[0, 1]`. Defaults to `0.5`
  public var resetSpringDamping: CGFloat = 0.5 {
    didSet {
      resetSpringDamping = max(0, min(resetSpringDamping, 1))
    }
  }

  /// The duration of the spring-like animation applied when a swipe is canceled, measured in seconds.
  ///
  /// This value must be greater than zero. Defaults to `0.6`.
  public var totalResetDuration: TimeInterval = 0.6 {
    didSet {
      totalResetDuration = max(.leastNormalMagnitude, totalResetDuration)
    }
  }

  /// The total duration of the reverse swipe animation, measured in seconds.
  ///
  /// This value must be greater than zero. Defaults to `0.25`.
  public var totalReverseSwipeDuration: TimeInterval = 0.25 {
    didSet {
      totalReverseSwipeDuration = max(.leastNormalMagnitude, totalReverseSwipeDuration)
    }
  }

  /// The total duration of the swipe animation, measured in seconds.
  ///
  /// This value must be greater than zero. Defaults to `0.7`.
  public var totalSwipeDuration: TimeInterval = 0.7 {
    didSet {
      totalSwipeDuration = max(.leastNormalMagnitude, totalSwipeDuration)
    }
  }
}

//zdxvzkxcvkjzxjcvkzxcv

protocol CardAnimatable {
  func animateReset(on card: SwipeCard)
  func animateReverseSwipe(on card: SwipeCard,
                           from direction: SwipeDirection,
                           completion: ((Bool) -> Void)?)
  func animateSwipe(on card: SwipeCard,
                    direction: SwipeDirection,
                    forced: Bool,
                    completion: ((Bool) -> Void)?)
  func removeAllAnimations(on card: SwipeCard)
}

class CardAnimator: CardAnimatable {

  static var shared = CardAnimator()

  // MARK: - Main Methods

  /// Calling this method triggers a spring-like animation on the card, eventually settling back to
  ///  it's original position.
  /// - Parameter card: The card to animate.
  func animateReset(on card: SwipeCard) {
    removeAllAnimations(on: card)

    Animator.animateSpring(
      withDuration: card.animationOptions.totalResetDuration,
      usingSpringWithDamping: card.animationOptions.resetSpringDamping,
      options: [.curveLinear, .allowUserInteraction]) {
      if let direction = card.activeDirection(),
         let overlay = card.overlay(forDirection: direction) {
        overlay.alpha = 0
      }
      card.transform = .identity
    }
  }

  /// Calling this method triggers a reverse swipe (i.e. undo) animation on the card.
  /// - Parameters:
  ///   - card: The card to animate.
  ///   - direction: The direction from which the card will be coming off-screen.
  ///   - completion: An optional block which is called once the animation has completed.
  func animateReverseSwipe(on card: SwipeCard,
                           from direction: SwipeDirection,
                           completion: ((Bool) -> Void)?) {
    removeAllAnimations(on: card)

    // Recreate swipe
    Animator.animateKeyFrames(withDuration: 0.0) { [weak self] in
      self?.addSwipeAnimationKeyFrames(card,
                                       direction: direction,
                                       forced: true)
    }

    // Reverse swipe
    Animator.animateKeyFrames(
      withDuration: card.animationOptions.totalReverseSwipeDuration,
      options: .calculationModeLinear,
      animations: { [weak self] in
        self?.addReverseSwipeAnimationKeyFrames(card, direction: direction)
      },
      completion: completion)
  }

  /// Calling this method triggers a swipe animation on the card.
  /// - Parameters:
  ///   - card: The card to animate.
  ///   - direction: The direction to which the card will swipe off-screen.
  ///   - forced: A boolean idicating whether the card was swiped programmatically
  ///   - completion: An optional block which is called once the animation has completed.
  func animateSwipe(on card: SwipeCard,
                    direction: SwipeDirection,
                    forced: Bool,
                    completion: ((Bool) -> Void)?) {
    removeAllAnimations(on: card)

    let duration = swipeDuration(card, direction: direction, forced: forced)
    Animator.animateKeyFrames(
      withDuration: duration,
      options: .calculationModeLinear,
      animations: { [weak self] in
        self?.addSwipeAnimationKeyFrames(card,
                                         direction: direction,
                                         forced: forced)
      },
      completion: completion)
  }

  /// Calling this method will remove any active animations on the card and its layers.
  /// - Parameter card: The card on which the animations will be removed.
  func removeAllAnimations(on card: SwipeCard) {
    card.layer.removeAllAnimations()
    card.swipeDirections.forEach {
      card.overlay(forDirection: $0)?.layer.removeAllAnimations()
    }
  }

  // MARK: - Animation Keyframes

  func addReverseSwipeAnimationKeyFrames(_ card: SwipeCard, direction: SwipeDirection) {
    let overlay = card.overlay(forDirection: direction)
    let relativeOverlayDuration = overlay != nil ? card.animationOptions.relativeReverseSwipeOverlayFadeDuration : 0.0

    // Transform
    Animator.addTransformKeyFrame(to: card,
                                  relativeDuration: 1 - relativeOverlayDuration,
                                  transform: .identity)

    // Overlays
    for swipeDirection in card.swipeDirections {
      card.overlay(forDirection: direction)?.alpha = swipeDirection == direction ? 1.0 : 0.0
    }

    Animator.addFadeKeyFrame(to: overlay,
                             withRelativeStartTime: 1 - relativeOverlayDuration,
                             relativeDuration: relativeOverlayDuration,
                             alpha: 0.0)
  }

  func addSwipeAnimationKeyFrames(_ card: SwipeCard, direction: SwipeDirection, forced: Bool) {
    let overlay = card.overlay(forDirection: direction)

    // Overlays
    for swipeDirection in card.swipeDirections.filter({ $0 != direction }) {
      card.overlay(forDirection: swipeDirection)?.alpha = 0.0
    }

    let relativeOverlayDuration = (forced && overlay != nil)
      ? card.animationOptions.relativeSwipeOverlayFadeDuration
      : 0.0
    Animator.addFadeKeyFrame(to: overlay,
                             relativeDuration: relativeOverlayDuration,
                             alpha: 1.0)

    // Transform
    let transform = swipeTransform(card, direction: direction, forced: forced)
    Animator.addTransformKeyFrame(to: card,
                                  withRelativeStartTime: relativeOverlayDuration,
                                  relativeDuration: 1 - relativeOverlayDuration,
                                  transform: transform)
  }

  // MARK: - Animation Calculations

  func swipeDuration(_ card: SwipeCard, direction: SwipeDirection, forced: Bool) -> TimeInterval {
    if forced {
      return card.animationOptions.totalSwipeDuration
    }

    let velocityFactor = card.dragSpeed(on: direction) / card.minimumSwipeSpeed(on: direction)

    // Card swiped below the minimum swipe speed
    if velocityFactor < 1.0 {
      return card.animationOptions.totalSwipeDuration
    }

    // Card swiped at least the minimum swipe speed -> return relative duration
    return 1.0 / TimeInterval(velocityFactor)
  }

  func swipeRotationAngle(_ card: SwipeCard, direction: SwipeDirection, forced: Bool) -> CGFloat {
    if direction == .up || direction == .down { return 0.0 }

    let rotationDirectionY: CGFloat = direction == .left ? -1.0 : 1.0

    if forced {
      return 2 * rotationDirectionY * card.animationOptions.maximumRotationAngle
    }

    guard let touchPoint = card.touchLocation else {
      return 2 * rotationDirectionY * card.animationOptions.maximumRotationAngle
    }

    if (direction == .left && touchPoint.y < card.bounds.height / 2)
        || (direction == .right && touchPoint.y >= card.bounds.height / 2) {
      return -2 * card.animationOptions.maximumRotationAngle
    }

    return 2 * card.animationOptions.maximumRotationAngle
  }

  func swipeTransform(_ card: SwipeCard, direction: SwipeDirection, forced: Bool) -> CGAffineTransform {
    let dragTranslation = CGVector(to: card.panGestureRecognizer.translation(in: card.superview))
    let normalizedDragTranslation = forced ? direction.vector : dragTranslation.normalized
    let actualTranslation = CGPoint(swipeTranslation(card,
                                                     direction: direction,
                                                     directionVector: normalizedDragTranslation))
    return CGAffineTransform(rotationAngle: swipeRotationAngle(card, direction: direction, forced: forced))
      .concatenating(CGAffineTransform(translationX: actualTranslation.x, y: actualTranslation.y))
  }

  func swipeTranslation(_ card: SwipeCard, direction: SwipeDirection, directionVector: CGVector) -> CGVector {
    let cardDiagonalLength = CGVector(card.bounds.size).length
    let maxScreenLength = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    let minimumOffscreenTranslation = CGVector(dx: maxScreenLength + cardDiagonalLength,
                                               dy: maxScreenLength + cardDiagonalLength)
    return CGVector(dx: directionVector.dx * minimumOffscreenTranslation.dx,
                    dy: directionVector.dy * minimumOffscreenTranslation.dy)
  }
}

//asdflkajsdlkfjadsf

open class SwipeCard: SwipeView {

  open var animationOptions = CardAnimationOptions()

  /// The the main content view.
  public var content: UIView? {
    didSet {
      if let content = content {
        oldValue?.removeFromSuperview()
        addSubview(content)
      }
    }
  }

  /// The the footer view.
  public var footer: UIView? {
    didSet {
      if let footer = footer {
        oldValue?.removeFromSuperview()
        addSubview(footer)
      }
    }
  }

  /// The height of the footer view.
  public var footerHeight: CGFloat = 100 {
    didSet {
      setNeedsLayout()
    }
  }

  weak var delegate: SwipeCardDelegate?

  var touchLocation: CGPoint? {
    return internalTouchLocation
  }

  private var internalTouchLocation: CGPoint?

  private let overlayContainer = UIView()
  private var overlays = [SwipeDirection: UIView]()

  private var animator: CardAnimatable = CardAnimator.shared

  // MARK: - Initialization

  override public init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }

  convenience init(animator: CardAnimatable) {
    self.init(frame: .zero)
    self.animator = animator
  }

  private func initialize() {
    addSubview(overlayContainer)
    overlayContainer.setUserInteraction(false)
  }

  // MARK: - Layout & Swipe Transform

  override open func layoutSubviews() {
    super.layoutSubviews()
    footer?.frame = CGRect(x: 0, y: bounds.height - footerHeight, width: bounds.width, height: footerHeight)

    // Content
    if let content = content {
      if let footer = footer, footer.isOpaque {
        content.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - footerHeight)
      } else {
        content.frame = bounds
      }
      sendSubviewToBack(content)
    }

    // Overlays
    if footer != nil {
      overlayContainer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - footerHeight)
    } else {
      overlayContainer.frame = bounds
    }
    bringSubviewToFront(overlayContainer)
    overlays.values.forEach { $0.frame = overlayContainer.bounds }
  }

  func swipeTransform() -> CGAffineTransform {
    let dragTranslation = panGestureRecognizer.translation(in: self)
    let translation = CGAffineTransform(translationX: dragTranslation.x,
                                        y: dragTranslation.y)
    let rotation = CGAffineTransform(rotationAngle: swipeRotationAngle())
    return translation.concatenating(rotation)
  }

  func swipeRotationAngle() -> CGFloat {
    let superviewTranslation = panGestureRecognizer.translation(in: superview)
    let rotationStrength = min(superviewTranslation.x / UIScreen.main.bounds.width, 1)
    return swipeRotationDirectionY()
      * rotationStrength
      * animationOptions.maximumRotationAngle
  }

  func swipeRotationDirectionY() -> CGFloat {
    if let touchPoint = touchLocation {
      return (touchPoint.y < bounds.height / 2) ? 1 : -1
    }
    return 0
  }

  func swipeOverlayPercentage(forDirection direction: SwipeDirection) -> CGFloat {
    if direction != activeDirection() { return 0 }
    let totalPercentage = swipeDirections.reduce(0) { sum, direction in
      return sum + dragPercentage(on: direction)
    }
    let actualPercentage = 2 * dragPercentage(on: direction) - totalPercentage
    return max(0, min(actualPercentage, 1))
  }

  // MARK: - Overrides

  override open func didTap(_ recognizer: UITapGestureRecognizer) {
    super.didTap(recognizer)
    internalTouchLocation = recognizer.location(in: self)
    delegate?.cardDidTap(self)
  }

  override open func beginSwiping(_ recognizer: UIPanGestureRecognizer) {
    super.beginSwiping(recognizer)
    internalTouchLocation = recognizer.location(in: self)
    delegate?.cardDidBeginSwipe(self)
    animator.removeAllAnimations(on: self)
  }

  override open func continueSwiping(_ recognizer: UIPanGestureRecognizer) {
    super.continueSwiping(recognizer)
    delegate?.cardDidContinueSwipe(self)

    transform = swipeTransform()

    for (direction, overlay) in overlays {
      overlay.alpha = swipeOverlayPercentage(forDirection: direction)
    }
  }

  override open func didSwipe(_ recognizer: UIPanGestureRecognizer,
                              with direction: SwipeDirection) {
    super.didSwipe(recognizer, with: direction)
    delegate?.cardDidSwipe(self, withDirection: direction)
    swipeAction(direction: direction, forced: false)
  }

  override open func didCancelSwipe(_ recognizer: UIPanGestureRecognizer) {
    super.didCancelSwipe(recognizer)
    delegate?.cardDidCancelSwipe(self)
    animator.animateReset(on: self)
  }

  // MARK: - Main Methods

  public func setOverlay(_ overlay: UIView?, forDirection direction: SwipeDirection) {
    overlays[direction]?.removeFromSuperview()
    overlays[direction] = overlay

    if let overlay = overlay {
      overlayContainer.addSubview(overlay)
      overlay.alpha = 0
      overlay.setUserInteraction(false)
    }
  }

  public func setOverlays(_ overlays: [SwipeDirection: UIView]) {
    for (direction, overlay) in overlays {
      setOverlay(overlay, forDirection: direction)
    }
  }

  public func overlay(forDirection direction: SwipeDirection) -> UIView? {
    return overlays[direction]
  }

  /// Calling this method triggers a swipe animation.
  /// - Parameter direction: The direction to which the card will swipe off-screen.
  public func swipe(direction: SwipeDirection) {
    swipeAction(direction: direction, forced: true)
  }

  func swipeAction(direction: SwipeDirection, forced: Bool) {
    isUserInteractionEnabled = false
    animator.animateSwipe(on: self,
                          direction: direction,
                          forced: forced) { [weak self] finished in
      if let strongSelf = self, finished {
        strongSelf.delegate?.cardDidFinishSwipeAnimation(strongSelf)
      }
    }
  }

  /// Calling this method triggers a reverse swipe (undo) animation.
  /// - Parameter direction: The direction from which the card will be coming off-screen.
  public func reverseSwipe(from direction: SwipeDirection) {
    isUserInteractionEnabled = false
    animator.animateReverseSwipe(on: self, from: direction) { [weak self] finished in
      if finished {
        self?.isUserInteractionEnabled = true
      }
    }
  }

  public func removeAllAnimations() {
    layer.removeAllAnimations()
    animator.removeAllAnimations(on: self)
  }
}

//asdflkasjdfklajsdfasd

protocol SwipeCardDelegate: AnyObject {
  func cardDidBeginSwipe(_ card: SwipeCard)
  func cardDidCancelSwipe(_ card: SwipeCard)
  func cardDidContinueSwipe(_ card: SwipeCard)
  func cardDidFinishSwipeAnimation(_ card: SwipeCard)
  func cardDidSwipe(_ card: SwipeCard, withDirection direction: SwipeDirection)
  func cardDidTap(_ card: SwipeCard)
}

//asdlkfjasdlkfjasdf

/// A wrapper over `UIView` which detects customized swipe gestures. The swipe recognition is
/// based on both speed and translation, and can and be set for each direction.
///
/// This view is intended to be subclassed.
open class SwipeView: UIView {

  /// The swipe directions to be detected by the view. Set this variable to ignore certain directions.
  /// Defaults to `SwipeDirection.allDirections`.
  open var swipeDirections = SwipeDirection.allDirections

  /// The pan gesture recognizer attached to the view.
  public var panGestureRecognizer: UIPanGestureRecognizer {
    return internalPanGestureRecognizer
  }

  private lazy var internalPanGestureRecognizer = PanGestureRecognizer(target: self,
                                                                       action: #selector(handlePan))

  /// The tap gesture recognizer attached to the view.
  public var tapGestureRecognizer: UITapGestureRecognizer {
    return internalTapGestureRecognizer
  }

  private lazy var internalTapGestureRecognizer = TapGestureRecognizer(target: self,
                                                                       action: #selector(didTap))

  // MARK: - Initialization

  /// Initializes the `SwipeView` with the required gesture recognizers.
  /// - Parameter frame: The frame rectangle for the view, measured in points.
  override public init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  /// Initializes the `SwipeView` with the required gesture recognizers.
  /// - Parameter aDecoder: An unarchiver object.
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }

  private func initialize() {
    addGestureRecognizer(internalPanGestureRecognizer)
    addGestureRecognizer(internalTapGestureRecognizer)
  }

  // MARK: - Swipe Calculations

  /// The active swipe direction on the view, if any.
  /// - Returns: The member of `swipeDirections` which returns the highest `dragPercentage:`.
  public func activeDirection() -> SwipeDirection? {
    return swipeDirections.reduce((CGFloat.zero, nil)) { [unowned self] lastResult, direction in
      let dragPercentage = self.dragPercentage(on: direction)
      return dragPercentage > lastResult.0 ? (dragPercentage, direction) : lastResult
    }.1
  }

  /// The speed of the current drag velocity projected onto the specified direction.
  ///
  ///  Expressed in points per second.
  /// - Parameter direction: The direction to project the drag onto.
  /// - Returns: The speed of the current drag velocity on the specifed direction.
  public func dragSpeed(on direction: SwipeDirection) -> CGFloat {
    let velocity = panGestureRecognizer.velocity(in: superview)
    return abs(direction.vector * CGVector(to: velocity))
  }

  /// The percentage of `minimumSwipeDistance` the current drag translation attains in the specified direction.
  ///
  /// The provided swipe direction need not be a member of `swipeDirections`.
  /// Can return a value greater than 1.
  /// - Parameter direction: The swipe direction.
  /// - Returns: The percentage of `minimumSwipeDistance` the current drag translation attains in
  /// the specified direction.
  public func dragPercentage(on direction: SwipeDirection) -> CGFloat {
    let translation = CGVector(to: panGestureRecognizer.translation(in: superview))
    let scaleFactor = 1 / minimumSwipeDistance(on: direction)
    let percentage = scaleFactor * (translation * direction.vector)
    return percentage < 0 ? 0 : percentage
  }

  /// The minimum required speed on the intended direction to trigger a swipe. Subclasses can override
  /// this method for custom swipe behavior.
  /// - Parameter direction: The swipe direction.
  /// - Returns: The minimum speed required to trigger a swipe in the indicated direction, measured in
  ///            points per second. Defaults to 1100 for each direction.
  open func minimumSwipeSpeed(on direction: SwipeDirection) -> CGFloat {
    return 1100
  }

  /// The minimum required drag distance on the intended direction to trigger a swipe, measured from the
  /// swipe's initial touch point. Subclasses can override this method for custom swipe behavior.
  /// - Parameter direction: The swipe direction.
  /// - Returns: The minimum distance required to trigger a swipe in the indicated direction, measured in
  ///            points. Defaults to 1/4 of the minimum of the screen's width and height.
  open func minimumSwipeDistance(on direction: SwipeDirection) -> CGFloat {
    return min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 4
  }

  // MARK: - Gesture Recognition

  /// This function is called whenever the view is tapped. The default implementation does nothing;
  /// subclasses can override this method to perform whatever actions are necessary.
  /// - Parameter recognizer: The gesture recognizer associated with the tap.
  @objc
  open func didTap(_ recognizer: UITapGestureRecognizer) {}

  /// This function is called whenever the view recognizes the beginning of a swipe. The default
  /// implementation does nothing; subclasses can override this method to perform whatever actions
  /// are necessary.
  /// - Parameter recognizer: The gesture recognizer associated with the swipe.
  open func beginSwiping(_ recognizer: UIPanGestureRecognizer) {}

  /// This function is called whenever the view recognizes a change in the active swipe. The default
  /// implementation does nothing; subclasses can override this method to perform whatever actions are
  /// necessary.
  /// - Parameter recognizer: The gesture recognizer associated with the swipe.
  open func continueSwiping(_ recognizer: UIPanGestureRecognizer) {}

  /// This function is called whenever the view recognizes the end of a swipe, regardless if the swipe
  /// was successful or cancelled.
  /// - Parameter recognizer: The gesture recognizer associated with the swipe.
  open func endSwiping(_ recognizer: UIPanGestureRecognizer) {
    if let direction = activeDirection() {
      if dragSpeed(on: direction) >= minimumSwipeSpeed(on: direction)
          || dragPercentage(on: direction) >= 1 {
        didSwipe(recognizer, with: direction)
        return
      }
    }
    didCancelSwipe(recognizer)
  }

  /// This function is called whenever the view recognizes a swipe. The default implementation does
  /// nothing; subclasses can override this method to perform whatever actions are necessary.
  /// - Parameters:
  ///   - recognizer: The gesture recognizer associated with the recognized swipe.
  ///   - direction: The direction of the swipe.
  open func didSwipe(_ recognizer: UIPanGestureRecognizer, with direction: SwipeDirection) {}

  /// This function is called whenever the view recognizes a cancelled swipe. The default implementation
  /// does nothing; subclasses can override this method to perform whatever actions are necessary.
  /// - Parameter recognizer: The gesture recognizer associated with the cancelled swipe.
  open func didCancelSwipe(_ recognizer: UIPanGestureRecognizer) {}

  // MARK: - Selectors

  @objc
  private func handlePan(_ recognizer: UIPanGestureRecognizer) {
    switch recognizer.state {
    case .possible, .began:
      beginSwiping(recognizer)
    case .changed:
      continueSwiping(recognizer)
    case .ended, .cancelled:
      endSwiping(recognizer)
    default:
      break
    }
  }
}


