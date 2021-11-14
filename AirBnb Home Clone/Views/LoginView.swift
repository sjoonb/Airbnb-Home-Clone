//
//  LoginView.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import UIKit
import Anchorage

class LoginView: ProgrammaticView, DataSourceProviderDelegate {
    

    var dataSourceProvider: DataSourceProvider<AuthProvider>!

    private let scrollView = UIScrollView()
    private let topLoginView = TopLoginView()
    private let separatorStack = UIStackView()
    private let leftLine = UIView()
    private let rightLine = UIView()
    private let orLabel = UILabel()
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - DataSourceProviderDelegate

    func didSelectRowAt(_ indexPath: IndexPath, on tableView: UITableView) {
        let item = dataSourceProvider.item(at: indexPath)
        
        let providerName = item.title!
        
        guard let provider = AuthProvider(rawValue: providerName) else {
            return
        }
        
        switch provider {
        case .email:
            print("email tapped")
            
        case .google:
            print("google tapped")
            
        case .apple:
            print("apple tapped")
            
        case .facebook:
            print("google tapped")
            
        }

    }
    
    
    

    // MARK: - Configure & Constrain
    
    override func configure() {
        configureDataSourceProvider()
        
        let scrollViewHeight = 700
        scrollView.contentSize = CGSize(width: bounds.size.width, height: CGFloat(scrollViewHeight))
        
        separatorStack.axis = .horizontal
        separatorStack.backgroundColor = .white
        
        leftLine.backgroundColor = .quaternaryLabel
        
        rightLine.backgroundColor = .quaternaryLabel
        
        orLabel.text = "또는"
        orLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        orLabel.textColor = .darkGray
        
        topLoginView.backgroundColor = .white
        tableView.backgroundColor = .white
    }
    
    override func constrain() {
        addSubviews(scrollView)
        
        scrollView.addSubviews(topLoginView, separatorStack, tableView)
        separatorStack.addSubviews(leftLine, rightLine, orLabel)
        
        scrollView.topAnchor == topAnchor
        scrollView.horizontalAnchors == horizontalAnchors
        scrollView.bottomAnchor == bottomAnchor
        
        
//        label.topAnchor == scrollView.topAnchor + 30
//        label.leadingAnchor == scrollView.leadingAnchor
        topLoginView.topAnchor == scrollView.topAnchor
        topLoginView.horizontalAnchors == horizontalAnchors
        topLoginView.heightAnchor == 240
        
        separatorStack.topAnchor == topLoginView.bottomAnchor
        separatorStack.horizontalAnchors == horizontalAnchors
        separatorStack.heightAnchor == 70

        leftLine.centerYAnchor == separatorStack.centerYAnchor
//        leftLine.topAnchor == separatorStack.topAnchor + 20
        leftLine.leadingAnchor == separatorStack.leadingAnchor + 20
        leftLine.trailingAnchor == separatorStack.centerXAnchor - 20
        leftLine.heightAnchor == 1
        
        orLabel.centerYAnchor == leftLine.centerYAnchor
        orLabel.centerXAnchor == separatorStack.centerXAnchor

        rightLine.topAnchor == leftLine.topAnchor
        rightLine.leadingAnchor == separatorStack.centerXAnchor + 20
        rightLine.trailingAnchor == separatorStack.trailingAnchor - 20
        rightLine.heightAnchor == 1

        tableView.topAnchor == separatorStack.bottomAnchor
        tableView.horizontalAnchors == horizontalAnchors
        tableView.bottomAnchor == bottomAnchor
        
    }
    
    private func configureDataSourceProvider() {
        dataSourceProvider = DataSourceProvider(dataSource: AuthProvider.sections, tableView: tableView)
        dataSourceProvider.delegate = self
    }
}


class TopLoginView: ProgrammaticView {

    private let phoneNumberField = UITextField()
    private let descriptionLabel = UILabel()
    private let continueButton = UIButton()
    
    override func configure() {
        phoneNumberField.attributedPlaceholder = NSAttributedString(
            string: "전화번호",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )

        phoneNumberField.font = UIFont.systemFont(ofSize: 17)
        phoneNumberField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: bounds.height))
        phoneNumberField.leftViewMode = .always

        phoneNumberField.layer.borderColor = UIColor.systemGray.cgColor
        phoneNumberField.layer.borderWidth = 1
        phoneNumberField.layer.cornerRadius = 10
        
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "전화나 문자로 전화번호를 확인하겠습니다. 일반 문자 메시지 요금 및 데이터 요금이 부과됩니다."
        
        continueButton.setTitle("계속", for: .normal)
        continueButton.layer.cornerRadius = 10
        continueButton.backgroundColor = .systemPink
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.titleLabel?.font =  UIFont.systemFont(ofSize: 18, weight: .semibold)

    }
    
    override func constrain() {
        frame = CGRect(x: 0 , y: 0, width: bounds.width, height: 200)
        addSubviews(phoneNumberField, descriptionLabel, continueButton)
        
        phoneNumberField.topAnchor == topAnchor + 30
        phoneNumberField.leadingAnchor == leadingAnchor + 30
        phoneNumberField.trailingAnchor == trailingAnchor - 30
        phoneNumberField.heightAnchor == 60
        
        descriptionLabel.topAnchor == phoneNumberField.bottomAnchor + 20
        descriptionLabel.leadingAnchor == leadingAnchor + 35
        descriptionLabel.trailingAnchor == trailingAnchor - 35
        
        continueButton.topAnchor == descriptionLabel.bottomAnchor + 30
        continueButton.leadingAnchor == leadingAnchor + 30
        continueButton.trailingAnchor == trailingAnchor - 30
        continueButton.heightAnchor == 60
    
    }
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct LoginViewPreview: PreviewProvider {
    static var previews: some View {
        Group {
            UIViewPreview {
                let view = LoginView()
                return view
            }.previewDevice("iPhone 11").previewLayout(.sizeThatFits)
        }
    }
}
#endif
