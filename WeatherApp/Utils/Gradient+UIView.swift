import UIKit

extension UIView {
    func applyGradient(
        forColors colors: [UIColor], 
        startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0), 
        endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)
    ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map{ $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.bounds
        self.layer.sublayers?.forEach { sublayer in
            if sublayer is CAGradientLayer {
                sublayer.removeFromSuperlayer()
            }
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}


import Foundation

extension DateFormatter {

    /// Formatter for hourly forecast time (e.g. 3 PM, 16:00)
    static let hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha" // Example: 3PM
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }()
}
