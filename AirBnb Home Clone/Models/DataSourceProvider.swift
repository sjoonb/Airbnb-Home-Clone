//
//  DataSourceProvider.swift
//  authenciationClone
//
//  Created by 백성준 on 2021/08/11.
//

import UIKit


protocol DataSourceProviderDelegate: AnyObject {
    func didSelectRowAt(_ indexPath: IndexPath, on tableView: UITableView)
}

class DataSourceProvider<DataSource: DataSourceProvidable>: NSObject, UITableViewDataSource, UITableViewDelegate {

    weak var delegate: DataSourceProviderDelegate?

    private var sections: [DataSource.AuthSection]!

    convenience init(dataSource: [DataSource.AuthSection]!, emptyStateView: UIView? = nil, tableView: UITableView? = nil)  {
        self.init()
//        emptyView = emptyStateView
        sections = dataSource ?? [DataSource.AuthSection]()
//        sections = [DataSource.AuthSection]()
        tableView?.dataSource = self
        tableView?.delegate = self
        
        tableViewConfiguration(tableView)
    }
    
    // MARK: - Public Section and Item Getters
    public func item(at indexPath: IndexPath) -> DataSource.AuthSection.Item {
      return sectionItem(at: indexPath)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let item = sectionItem(at: indexPath)

        config(&cell, for: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectRowAt(indexPath, on: tableView)
    }
    
    
    // MARK: - Private Helpers
    
    private func tableViewConfiguration(_ tableView: UITableView?) {
        tableView?.sectionHeaderHeight = 7
        tableView?.sectionFooterHeight = 7
        tableView?.isScrollEnabled = false
    }
    
    private func sectionItem(at indexPath: IndexPath) -> DataSource.AuthSection.Item  {
        return sections[indexPath.section].items[indexPath.row]
    }
    
    private func config(_ cell: inout UITableViewCell, for item: DataSource.AuthSection.Item) {

        var content = cell.defaultContentConfiguration()
        
        content.image = item.image
        content.attributedText = NSAttributedString(string: item.description ?? "", attributes: [ .font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.black ])
        content.textProperties.alignment = .center
        content.imageToTextPadding = (content.image?.size.width ?? 0) * -1
            
        cell.contentConfiguration = content

        cell.layer.backgroundColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.8
        
//        let maskLayer = CALayer()
//        maskLayer.cornerRadius = 10
//        maskLayer.backgroundColor = UIColor.clear.cgColor
//        maskLayer.borderColor = UIColor.red.cgColor
//        maskLayer.borderWidth = 1
//
//        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.contentView.bounds.width, height: cell.bounds.height)
//        cell.contentView.layer.insertSublayer(maskLayer, below: cell.contentView.layer)
//            .insetBy(dx: horizontalPadding/2, dy: verticalPadding/2)
        
        
//        cell.contentView.layer.borderColor = UIColor.black.cgColor)
//        cell.contentView.layer.borderWidth = 1
//
//        cell.contentView
        
    }
}


//
//    open override func layoutSubviews() {
//          super.layoutSubviews()
//          //set the values for top,left,bottom,right margins
//          let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//          contentView.frame = contentView.frame.inset(by: margins)
//          contentView.layer.cornerRadius = 8
//        contentView.backgroundColor = .white
//    }
//}

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

protocol DataSourceProvidable {
    associatedtype AuthSection: Sectionable
    var sections: [AuthSection] { get }
}

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

