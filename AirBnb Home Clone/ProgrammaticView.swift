//
//  ProgrammaticView.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/09/13.
//

import UIKit


import UIKit

class ProgrammaticView: UIView {

    @available(*, unavailable, message: "Don't use init(coder:), override init(frame:) instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        constrain()
    }

    func configure() {}
    func constrain() {}
}
