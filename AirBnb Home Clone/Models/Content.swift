//
//  Content.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/09/13.
//

import Foundation

struct Content: Hashable {
    enum Style {
        case standard, title
    }
    
    let title: String
    let subtitle: String?
    let image: String?
    let style: Style
    
    init(title: String, subtitle: String? = nil, image: String? = nil, style: Style = .standard) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.style = style
        
    }
}
