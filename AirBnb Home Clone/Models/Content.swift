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
    case nearby, stays, experiences, hosting//, info
}

// MARK: - Headers

extension Section {
    var headerContent: Content? {
        switch self {
        case .nearby: return nil
        case .stays: return .init(title: "Live anywhere", subtitle: nil, image: nil)
        case .experiences: return .init(title: "Experience the world",
                                        subtitle: "Unique activities with local experts—in person or online.",
                                        image: nil)
        case .hosting: return .init(title: "Join millions of hosts on Airbnb", subtitle: nil, image: nil)
    //        case .info: return .init(title: "Stay informed", subtitle: nil, image: nil)
        }
    }
}

// MARK: - Stub Data

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
        case .stays:
            return [
                .init(title: "Entire homes", subtitle: nil, image: "entire-homes"),
                .init(title: "Cabins and cottages", subtitle: nil, image: "cabins-cottages"),
                .init(title: "Unique stays", subtitle: nil, image: "unique-stays"),
                .init(title: "Pets welcome", subtitle: nil, image: "pets-welcome"),
            ]
        case .experiences:
            return [
                .init(title: "Online Experiences",
                      subtitle: "Travel the world without leaving home.",
                      image: "online-experiences"),
                .init(title: "Experiences",
                      subtitle: "Things to do wherever you are.",
                      image: "experiences"),
                .init(title: "Adventures",
                      subtitle: "Multi-day trips with meals and stays.",
                      image: "adventures"),
            ]
        case .hosting:
            return [
                .init(title: "Host your home",
                      subtitle: nil,
                      image: "host-your-home"),
                .init(title: "Host an Online Experience",
                      subtitle: nil,
                      image: "host-online-experience"),
                .init(title: "Host an Experience",
                      subtitle: nil,
                      image: "host-experience"),
            ]
        }
        
    }
}
