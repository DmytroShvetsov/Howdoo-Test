import Foundation
import QuartzCore

// MARK: - get:duration
extension CATransition {
    static func get(duration: CFTimeInterval = 0.3, type: CATransitionType = .fade, subtype: CATransitionSubtype? = .none) -> CATransition {
        let transition = CATransition()
        transition.duration = duration
        transition.type     = type
        transition.subtype  = subtype
        transition.timingFunction = .init(name: .easeInEaseOut)
        return transition
    }
}
