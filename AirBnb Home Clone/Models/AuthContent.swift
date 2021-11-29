//
//  AuthContent.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/08.
//


import UIKit

protocol Sectionable {
    associatedtype Item: Itemable
    var headerDescription: String? { get }
    var footerDescription: String? { get }
    var items: [Item] { get set }
}

protocol Itemable {
    var title: String? { get }
    var description: String? { get }
    var detailTitle: String? { get }
    var image: UIImage? { get set }
    var hasNestedContent: Bool { get set }
}

struct AuthSection: Sectionable {
    var headerDescription: String?
    var footerDescription: String?
    var items: [AuthItem]
}

struct AuthItem: Itemable {
    var title: String?
    var description: String?
    var detailTitle: String?
    var hasNestedContent: Bool
    
    private var _image: UIImage?
    var image: UIImage? {
        get { _image ?? UIImage(named: title ?? "?") }
        set { _image = newValue }
    }
    
    init(title: String? = nil, description: String? = nil, detailTitle: String? = nil, hasNestedContent: Bool = false ,image: UIImage? = nil) {
        self.title = title
        self.description = description
        self.detailTitle = detailTitle
        self.hasNestedContent = hasNestedContent
        self.image = image
    }
}

enum AuthProvider: String {
    case email = "email"
    case apple = "apple.com"
    case google = "google.com"
    case facebook = "facebook.com"
    
    var name: String {
        switch self {
        case .email:
            return "envelope"
        case .apple:
            return "Apple"
        case .google:
            return "Google"
        case .facebook:
            return "Facebook"
        }
    }
    
    var description: String {
        switch self {
        case .email:
            return "이메일로 로그인하기"
        case .apple:
            return "Apple로 계속하기"
        case .google:
            return "구글 계정으로 로그인"
        case .facebook:
            return "페이스북 계정으로 로그인"
        }
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "envelope":
            self = .email
        case "Google":
            self = .google
        case "Apple":
            self = .apple
        case "Facebook":
            self = .facebook
        default: return nil
        }

    }
    
    
}

extension AuthProvider: DataSourceProvidable {
    static var providers: [AuthProvider] {
        [ .apple, .google, .facebook ]
    }
    
    
    static var providerSections: [AuthSection] {
        let providers = self.providers.map { AuthItem(title: $0.name, description: $0.description, image: UIImage(named: $0.name)) }
        let sections = providers.map { item in
            AuthSection(items: [item])
        }
        return sections
    }
    
    static var emailSection: AuthSection {
        let image = UIImage.systemImage(email.name, tintColor: .black)
        let item = AuthItem(title: email.name, description: email.description, image: image)
        return AuthSection(items: [item])
    }
    
    var sections: [AuthSection] {
        AuthProvider.sections
    }

    static var sections: [AuthSection]! = [ emailSection ] + providerSections
}
