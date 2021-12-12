//
//  DataSourceProvider.swift
//  authenciationClone
//
//  Created by 백성준 on 2021/08/11.
//

import UIKit


protocol DataSourceProviderDelegate: AnyObject {
    func didSelectRowAt(_ indexPath: IndexPath, on tableView: UITableView)
    func tableViewDidScroll(_ tableView: UITableView)
}

extension DataSourceProviderDelegate {
  /// Provide default implementation to prevent a required implementation when conforming to this protocol
  func tableViewDidScroll(_ tableView: UITableView) {}
}


class DataSourceProvider<DataSource: DataSourceProvidable>: NSObject, UITableViewDataSource, UITableViewDelegate {

    weak var delegate: DataSourceProviderDelegate?

    private var sections: [DataSource.Section]!

    convenience init(dataSource: [DataSource.Section]!, emptyStateView: UIView? = nil, tableView: UITableView? = nil)  {
        self.init()
        sections = dataSource ?? [DataSource.Section]()
        tableView?.dataSource = self
        tableView?.delegate = self
        
        tableViewConfiguration(tableView)
    }
    
    // MARK: - Public Section and Item Getters
    public func item(at indexPath: IndexPath) -> DataSource.Section.Item {
      return sectionItem(at: indexPath)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        updateBackgroundViewIfNeeded(for: tableView)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      guard let tableView = scrollView as? UITableView else { return }
      delegate?.tableViewDidScroll(tableView)
    }

    
    // MARK: - Private Helpers
    
    private func updateBackgroundViewIfNeeded(for tableView: UITableView) {
        tableView.isScrollEnabled = !sections.isEmpty
    }
    
    private func tableViewConfiguration(_ tableView: UITableView?) {
        tableView?.sectionHeaderHeight = 7
        tableView?.sectionFooterHeight = 7
        tableView?.isScrollEnabled = false
    }
    
    private func sectionItem(at indexPath: IndexPath) -> DataSource.Section.Item  {
        return sections[indexPath.section].items[indexPath.row]
    }
    
    private func config(_ cell: inout UITableViewCell, for item: DataSource.Section.Item) {

        if let title = item.description {
            var content = cell.defaultContentConfiguration()
            
            content.image = item.image
            content.attributedText = NSAttributedString(string: title, attributes: [ .font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.black ])
            content.textProperties.alignment = .center
            content.imageToTextPadding = (content.image?.size.width ?? 0) * -1
            
            cell.contentConfiguration = content
            
            cell.layer.backgroundColor = UIColor.black.cgColor
            cell.layer.borderWidth = 0.8
            
            return
        }
        
        cell.textLabel?.text = item.title
        cell.textLabel?.textColor = item.textColor
        cell.detailTextLabel?.text = item.detailTitle
        cell.detailTextLabel?.textColor = .secondaryLabel
        cell.imageView?.image = item.image
        cell.accessoryView = item.isEditable ? editableImageView() : nil
        cell.accessoryType = item.hasNestedContent ? .disclosureIndicator : .none
        
    }
    
    private func editableImageView() -> UIImageView {
        let image = UIImage(systemName: "pencil")?
            .withTintColor(.systemPink, renderingMode: .alwaysOriginal)
        return UIImageView(image: image)
    }
}


protocol DataSourceProvidable {
    associatedtype Section: Sectionable
    var sections: [Section] { get }
}

