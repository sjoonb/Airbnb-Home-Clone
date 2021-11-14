//
//  AuthContent.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/08.
//


import UIKit

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

