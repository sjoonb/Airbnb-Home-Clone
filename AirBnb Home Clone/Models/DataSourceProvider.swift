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
        
    }
}


protocol DataSourceProvidable {
    associatedtype AuthSection: Sectionable
    var sections: [AuthSection] { get }
}

