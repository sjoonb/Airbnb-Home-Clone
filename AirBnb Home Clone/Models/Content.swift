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

enum Section: Int, Hashable, CaseIterable {
    case nearby //, stays, experiences, hosting, info
}

extension Section {
    func stubData() -> [Content] {
        switch self {
        case .nearby:
            return [
                .init(title: "Estes Park", subtitle: "1.5 hour drive", image: "estes-park"),
                .init(title: "Breckenridge", subtitle: "2.5 hour drive", image: "breckenridge"),
                .init(title: "Grand Lake", subtitle: "3 hour drive", image: "grand-lake"),
                .init(title: "Idaho Springs", subtitle: "2 hour drive", image: "idaho-springs"),
                .init(title: "Glenwood Springs", subtitle: "4.5 hour drive", image: "glenwood-springs"),
                .init(title: "Pagosa Springs", subtitle: "7.5 hour drive", image: "pagosa-springs"),
            ]
        }
    }
}
