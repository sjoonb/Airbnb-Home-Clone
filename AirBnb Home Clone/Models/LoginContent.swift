//
//  LoginContent.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import Foundation

struct LoginContent {
    let title: String
    let subtitle: String
    let text: String
    
    init(title: String, subtitle: String, text: String) {
        self.title = title
        self.subtitle = subtitle
        self.text = text
    }
}

enum LoginSection {
    case wishView, travelView, messageView, profileView
}

extension LoginSection {
    func stubData() -> LoginContent {
        switch self {
        case .wishView:
            return .init(title: "위시리스트", subtitle: "아직 저장 항목 없음", text: "가슴 설레는 다음 여행 계획을 세워보세요. 검색 중에 마음에 드는 숙소나 즐길 거리를 저장하려면 하트 아이콘을 누르세요.")
        case .travelView:
            return .init(title: "여행", subtitle: "아직 여행 없음", text: "다시 여행을 떠나실 준비가 되면 에어비앤비에서 도와드리겠습니다.")
        case .messageView:
            return .init(title: "메시지", subtitle: "메시지를 보려면 로그인하세요", text: "로그인하면 여기에 호스트가 보낸 메시지가 표시됩니다.")
        case .profileView:
            return .init(title: "프로필", subtitle: "다음번 여행을 계획하려면 로그인하세요.", text: "에어비앤비 계정이 없으신가요? 회원 가입")
        }
    }
}
