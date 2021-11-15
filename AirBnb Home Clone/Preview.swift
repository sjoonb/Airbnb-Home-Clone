//
//  Preview.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/13.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct Preview: PreviewProvider {
    static var previews: some View {
        Group {
            HomeViewController().showPreview()
//            UIViewPreview {
//                let view = ProfilePreLoginView()
//                return view
//            }.previewDevice("iPhone 11").previewLayout(.sizeThatFits)

//            UIViewPreview {
//                let view = TopLoginView()
//                return view
//            }.previewDevice("iPhone 11").previewLayout(.sizeThatFits)
        }
    }
}
#endif
