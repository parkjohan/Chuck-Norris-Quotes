

import UIKit

class RoundedShadowCardView: UIView {
    override func awakeFromNib() {
        let shadowRadius: CGFloat = 4.0
        let shadowOpacity: Float = 5.0
        let shadowYOffset = 4.0
        let shadowXOffset = 0.0
        let shadowColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0).cgColor
        let cornerRadius: CGFloat = 10
        
        layer.shadowColor = shadowColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: shadowXOffset, height: shadowYOffset)
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        clipsToBounds = false
    }
}
