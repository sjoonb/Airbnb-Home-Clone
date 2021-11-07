//
//  loginView.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/05.
//

import UIKit
import Anchorage


class LoginView: ProgrammaticView {
    weak var delegate: AnyObject?
    
    private let titleLabel = UILabel()
    private let separator = UIView()
    private let subtitleLabel = UILabel()
    private let textLabel = UILabel()
    private let loginButton = UIButton(type: .roundedRect)
    
    override func configure() {
        backgroundColor = .systemBackground
        
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
//        titleLabel.text = "위시리스트"

        separator.backgroundColor = .quaternaryLabel
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//        subtitleLabel.text = "아직 저장 항목 없음"

        textLabel.textColor = UIColor.gray
        textLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        textLabel.text = "가슴 설레는 다음 여행 계획을 세워보세요. 검색 중에 마음에 드는 숙소나 즐길 거리를 저장하려면 하트 아이콘을 누르세요."
        textLabel.numberOfLines = 0
        
        loginButton.layer.cornerRadius = 10
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = .systemPink
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        loginButton.contentEdgeInsets = .init(top: 14, left: 28, bottom: 14, right: 28)

    }
    
    override func constrain() {
        addSubviews(titleLabel, separator, subtitleLabel, textLabel, subtitleLabel, textLabel, loginButton)

        titleLabel.centerYAnchor == centerYAnchor * 0.25
//        titleLabel.topAnchor == topAnchor
        titleLabel.leadingAnchor == leadingAnchor + 30
        
        separator.topAnchor == titleLabel.bottomAnchor + 60
        separator.centerXAnchor == centerXAnchor
        separator.heightAnchor == 1
        separator.widthAnchor == widthAnchor - 60
        
        subtitleLabel.topAnchor == separator.bottomAnchor + 40
        subtitleLabel.leadingAnchor == leadingAnchor + 30
        
        textLabel.topAnchor == subtitleLabel.bottomAnchor + 10
        textLabel.leadingAnchor == leadingAnchor + 30
        textLabel.trailingAnchor == trailingAnchor - 30

        loginButton.topAnchor == textLabel.bottomAnchor + 20
        loginButton.leadingAnchor == leadingAnchor + 30

    }
    
    func configure(with content: LoginContent?) {
        titleLabel.text = content?.title
        subtitleLabel.text = content?.subtitle
        textLabel.text = content?.text
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct LoginViewPreview: PreviewProvider{
    static var previews: some View {
        Group {
            UIViewPreview {
                let view = LoginView()
                view.configure(with: LoginSection.wishView.stubData())
                return view
            }.previewDevice("iPhone 11").previewLayout(.sizeThatFits)
            UIViewPreview {
                let view = LoginView()
                view.configure(with: LoginSection.wishView.stubData())
                return view
            }.previewDevice("iPhone SE (2nd generation)").previewLayout(.sizeThatFits)
        }
    }
}
#endif
