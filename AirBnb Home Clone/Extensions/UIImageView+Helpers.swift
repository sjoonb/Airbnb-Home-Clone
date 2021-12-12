//
//  UIImageView+Helpers.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/30.
//

import UIKit

extension UIImageView {
    convenience init(systemImageName: String, tintColor: UIColor? = nil) {
        var systemImage = UIImage(systemName: systemImageName)
        if let tintColor = tintColor {
            systemImage = systemImage?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        }
        self.init(image: systemImage)
    }
    
    func setImage(from url: URL?) {
        guard let url = url else { return }
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.image = image
                self.contentMode = .scaleAspectFit
            }
        }
    }
    
}
