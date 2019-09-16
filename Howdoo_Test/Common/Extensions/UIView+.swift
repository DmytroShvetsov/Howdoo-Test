import UIKit
import NVActivityIndicatorView

// MARK: - loader
extension UIView {
    private static let loaderTag = 9_999
    
    private var loaderView: UIView? {
        return viewWithTag(UIView.loaderTag)
    }
    
    final func showLoader() {
        addLoaderView(opacity: 0.25)
    }
    
    private func addLoaderView(opacity: Float = 0) {
        loaderView?.removeFromSuperview()
        
        let container = UIView()
        container.tag = UIView.loaderTag
        isUserInteractionEnabled = false
        addSubview(container)
        container.edges(to: self)
        container.centerInSuperview()
        
        if opacity != 0 {
            let blurEffect: UIBlurEffect
            
            if #available(iOS 10.0, *) {
                blurEffect = .init(style: .prominent)
            } else {
                blurEffect = .init(style: .light)
            }
            
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.layer.opacity = opacity
            container.addSubview(blurView)
            blurView.edges(to: container)
        }
        
        let indicatorConrainer = UIView()
        indicatorConrainer.backgroundColor = .black
        indicatorConrainer.layer.opacity = 0.5
        indicatorConrainer.layer.cornerRadius = 5
        container.addSubview(indicatorConrainer)
        indicatorConrainer.width(75)
        indicatorConrainer.height(to: indicatorConrainer, indicatorConrainer.widthAnchor)
        indicatorConrainer.centerInSuperview()
        
        let indicator = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .white, padding: nil)
        indicator.startAnimating()
        indicatorConrainer.addSubview(indicator)
        indicator.centerInSuperview()
        indicator.size(to: indicatorConrainer, multiplier: 0.5)
    }
    
    final func removeLoader() {
        isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.3, animations: {
            self.loaderView?.alpha = 0
        }) { _ in
            self.loaderView?.removeFromSuperview()
        }
    }
}
