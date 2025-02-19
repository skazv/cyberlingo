//
//  Animator.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//


import Foundation
import UIKit

/// A wrapper around the UIView animate methods.
enum Animator {

  static func addKeyFrame(withRelativeStartTime relativeStartTime: Double = 0.0,
                          relativeDuration: Double = 1.0,
                          animations: @escaping () -> Void) {
    UIView.addKeyframe(withRelativeStartTime: relativeStartTime,
                       relativeDuration: relativeDuration,
                       animations: animations)
  }

  static func addFadeKeyFrame(to view: UIView?,
                              withRelativeStartTime relativeStartTime: Double = 0.0,
                              relativeDuration: Double = 1.0,
                              alpha: CGFloat) {
    UIView.addKeyframe(withRelativeStartTime: relativeStartTime,
                       relativeDuration: relativeDuration) {
      view?.alpha = alpha
    }
  }

  static func addTransformKeyFrame(to view: UIView?,
                                   withRelativeStartTime relativeStartTime: Double = 0.0,
                                   relativeDuration: Double = 1.0,
                                   transform: CGAffineTransform) {
    UIView.addKeyframe(withRelativeStartTime: relativeStartTime,
                       relativeDuration: relativeDuration) {
      view?.transform = transform
    }
  }

  static func animateKeyFrames(withDuration duration: TimeInterval,
                               delay: TimeInterval = 0.0,
                               options: UIView.KeyframeAnimationOptions = [],
                               animations: @escaping (() -> Void),
                               completion: ((Bool) -> Void)? = nil) {
    UIView.animateKeyframes(withDuration: duration,
                            delay: delay,
                            options: options,
                            animations: animations,
                            completion: completion)
  }

  static func animateSpring(withDuration duration: TimeInterval,
                            delay: TimeInterval = 0.0,
                            usingSpringWithDamping damping: CGFloat,
                            initialSpringVelocity: CGFloat = 0.0,
                            options: UIView.AnimationOptions,
                            animations: @escaping () -> Void,
                            completion: ((Bool) -> Void)? = nil) {
    UIView.animate(withDuration: duration,
                   delay: delay,
                   usingSpringWithDamping: damping,
                   initialSpringVelocity: initialSpringVelocity,
                   options: options,
                   animations: animations,
                   completion: completion)
  }
}

//sdfsdfasdfgsdafg

extension Array {

  mutating func shift(withDistance distance: Int = 1) {
    let offsetIndex = distance >= 0
      ? index(startIndex, offsetBy: distance, limitedBy: endIndex)
      : index(endIndex, offsetBy: distance, limitedBy: startIndex)
    guard let index = offsetIndex else { return }
    self = Array(self[index ..< endIndex] + self[startIndex ..< index])
  }
}

extension Array where Element: Hashable {

  func removingDuplicates() -> [Element] {
    var dict = [Element: Bool]()
    return filter { dict.updateValue(true, forKey: $0) == nil }
  }

  mutating func removeDuplicates() {
    self = self.removingDuplicates()
  }
}

//zcvzxcvasdxv

extension CGPoint {

  init(_ vector: CGVector) {
    self = CGPoint(x: vector.dx, y: vector.dy)
  }
}

//asdfasdfsdfasdfasdfasdf

extension CGVector {

  // MARK: - Operators

  static prefix func + (vector: CGVector) -> CGVector {
    return vector
  }

  static prefix func - (vector: CGVector) -> CGVector {
    return CGVector(dx: -vector.dx, dy: -vector.dy)
  }

  static func + (lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
  }

  static func - (lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
  }

  static func * (scalar: CGFloat, vector: CGVector) -> CGVector {
    return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
  }

  static func * (scalar: Int, vector: CGVector) -> CGVector {
    return vector * CGFloat(scalar)
  }

  static func * (vector: CGVector, scalar: CGFloat) -> CGVector {
    return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
  }

  static func * (vector: CGVector, scalar: Int) -> CGVector {
    return vector * CGFloat(scalar)
  }

  static func / (vector: CGVector, scalar: CGFloat) -> CGVector {
    return CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
  }

  static func / (vector: CGVector, scalar: Int) -> CGVector {
    return vector / CGFloat(scalar)
  }

  static func += (lhs: inout CGVector, rhs: CGVector) {
    // swiftlint:disable:next shorthand_operator
    lhs = lhs + rhs
  }

  static func -= (lhs: inout CGVector, rhs: CGVector) {
    // swiftlint:disable:next shorthand_operator
    lhs = lhs - rhs
  }

  static func *= (vector: inout CGVector, scalar: CGFloat) {
    // swiftlint:disable:next shorthand_operator
    vector = vector * scalar
  }

  static func *= (vector: inout CGVector, scalar: Int) {
    // swiftlint:disable:next shorthand_operator
    vector = vector * scalar
  }

  static func /= (vector: inout CGVector, scalar: CGFloat) {
    // swiftlint:disable:next shorthand_operator
    vector = vector / scalar
  }

  static func /= (vector: inout CGVector, scalar: Int) {
    // swiftlint:disable:next shorthand_operator
    vector = vector / scalar
  }

  static func * (lhs: CGVector, rhs: CGVector) -> CGFloat {
    return lhs.dx * rhs.dx + lhs.dy * rhs.dy
  }

  // MARK: - Miscellaneous

  init(from origin: CGPoint = .zero, to target: CGPoint) {
    self = CGVector(dx: target.x - origin.x,
                    dy: target.y - origin.y)
  }

  init(_ size: CGSize) {
    self = CGVector(dx: size.width, dy: size.height)
  }

  var length: CGFloat {
    return hypot(self.dx, self.dy)
  }

  var normalized: CGVector {
    return self / self.length
  }
}

// MARK: - Functions

func abs(_ vector: CGVector) -> CGFloat {
  return vector.length
}

//asdfasdfsdfasdfasdfasdf

/// A testable `UIPanGestureRecognizer`
class PanGestureRecognizer: UIPanGestureRecognizer {

  private weak var testTarget: AnyObject?
  private var testAction: Selector?

  private var testLocation: CGPoint?
  private var testTranslation: CGPoint?
  private var testVelocity: CGPoint?
  private var testState: UIGestureRecognizer.State?

  override var state: UIGestureRecognizer.State {
    get {
      return testState ?? super.state
    }
    set {
      super.state = newValue
    }
  }

  override init(target: Any?, action: Selector?) {
    testTarget = target as AnyObject
    testAction = action
    super.init(target: target, action: action)
  }

  override func location(in view: UIView?) -> CGPoint {
    return testLocation ?? super.location(in: view)
  }

  override func translation(in view: UIView?) -> CGPoint {
    return testTranslation ?? super.translation(in: view)
  }

  override func velocity(in view: UIView?) -> CGPoint {
    return testVelocity ?? super.velocity(in: view)
  }

  func performPan(withLocation location: CGPoint?,
                  translation: CGPoint?,
                  velocity: CGPoint?,
                  state: UIPanGestureRecognizer.State? = nil) {
    testLocation = location
    testTranslation = translation
    testVelocity = velocity
    testState = state
    if let action = testAction {
      testTarget?.performSelector(onMainThread: action,
                                  with: self,
                                  waitUntilDone: true)
    }
  }
}

//asdfasdfsdfasdfasdfasdf

// swiftlint:disable line_length
enum StringUtils {

  static func createInvalidUpdateErrorString(newCount: Int,
                                             oldCount: Int,
                                             insertedCount: Int = 0,
                                             deletedCount: Int = 0) -> String {
    return "Invalid update: invalid number of cards. The number of cards contained in the card stack after the update (\(newCount)) must be equal to the number of cards contained in the card stack before the update (\(oldCount)), plus or minus the number of cards inserted or deleted (\(insertedCount) inserted, \(deletedCount) deleted)"
  }
}
// swiftlint:enable line_length

//asdfasdfsdfasdfasdfasdf

/// A testable `UITapGestureRecognizer`
class TapGestureRecognizer: UITapGestureRecognizer {

  private weak var testTarget: AnyObject?
  private var testAction: Selector?

  private var testLocation: CGPoint?

  override init(target: Any?, action: Selector?) {
    testTarget = target as AnyObject
    testAction = action
    super.init(target: target, action: action)
  }

  override func location(in view: UIView?) -> CGPoint {
    return testLocation ?? super.location(in: view)
  }

  func performTap(withLocation location: CGPoint?) {
    testLocation = location
    if let action = testAction {
      testTarget?.performSelector(onMainThread: action,
                                  with: self,
                                  waitUntilDone: true)
    }
  }
}

extension UIView {

  /// Sets the `isUserInteractionEnabled` property on the view and all of it's subviews.
  ///
  /// - Parameter isEnabled: the value to set the `isUserInteractionEnabled` property to.
  func setUserInteraction(_ isEnabled: Bool) {
    isUserInteractionEnabled = isEnabled
    for subview in subviews {
      subview.setUserInteraction(isEnabled)
    }
  }
}
