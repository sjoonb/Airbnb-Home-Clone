//
//  Content.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/09/13.
//

import UIKit


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
    case nearby, stays, experiences, hosting, info
}

// MARK: - Headers

extension Section {
    var headerContent: Content? {
        switch self {
        case .nearby: return .init(title: "가까운 여행지 둘러보기", subtitle: nil, image: nil)
        case .stays: return .init(title: "어디에서나, 여행은 살아보는 거야!", subtitle: nil, image: nil)
        case .experiences: return .init(title: "Experience the world",
                                        subtitle: "Unique activities with local experts—in person or online.",
                                        image: nil)
        case .hosting: return .init(title: "Join millions of hosts on Airbnb", subtitle: nil, image: nil)
        case .info: return .init(title: "Stay informed", subtitle: nil, image: nil)
        }
    }
}

// MARK: - Stub Data

extension Section {
    func stubData() -> [Content] {
        switch self {
        case .nearby:
            return [
                .init(title: "서울", subtitle: "차로 1시간 거리", image: "seoul"),
                .init(title: "부산", subtitle: "차로 5시간 거리", image: "busan"),
                .init(title: "양양군", subtitle: "차로 2.5시간 거리", image: "yangyang-gun"),
                .init(title: "속초시", subtitle: "차로 2.5시간 거리", image: "sokcho-si"),
                .init(title: "대구", subtitle: "차로 4시간 거리", image: "dae-gu"),
                .init(title: "완주군", subtitle: "차로 3시간 거리", image: "wanju-gun"),
            ]
        case .stays:
            return [
                .init(title: "자연생활을 만끽할 수 있는 숙소", subtitle: nil, image: "natural-homes"),
                .init(title: "독특한 공간 ", subtitle: nil, image: "water-homes"),
                .init(title: "집 전체", subtitle: nil, image: "whole-homes"),
                .init(title: "반려동물 동반 가능", subtitle: nil, image: "pet-homes"),
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
        case .info:
            return [
                .init(title: "For guests", subtitle: nil, image: nil, style: .title),
                .init(title: "Our COVID-19 response",
                      subtitle: "Health and saftey updates",
                      image: nil),
                .init(title: "Cancellation options",
                      subtitle: "Learn what's covered",
                      image: nil),
                .init(title: "Help Center",
                      subtitle: "Get support",
                      image: nil),

                .init(title: "For hosts", subtitle: nil, image: nil, style: .title),
                .init(title: "Message from Brian Chesky",
                      subtitle: "Hear from our CEO",
                      image: nil),
                .init(title: "Resources for hosting",
                      subtitle: "What's impacted by COVID-19",
                      image: nil),
                .init(title: "Providing frontline stays",
                      subtitle: "Learn how to help",
                      image: nil),

                .init(title: "For COVID-19 responders", subtitle: nil, image: nil, style: .title),
                .init(title: "Frontline stays",
                      subtitle: "Learn about our program",
                      image: nil),
                .init(title: "Sign up",
                      subtitle: "Check for housing options",
                      image: nil),
                .init(title: "Make a donation",
                      subtitle: "Support nonprofit organizations",
                      image: nil),

                .init(title: "More", subtitle: nil, image: nil, style: .title),
                .init(title: "Airbnb Newsroom",
                      subtitle: "Latest announcements",
                      image: nil),
                .init(title: "World Health Organization",
                      subtitle: "Education and updates",
                      image: nil),
                .init(title: "Project Lighthouse",
                      subtitle: "Finding and fighting discrimination",
                      image: nil),
            ]

        }
        
    }
}
