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
//            WishViewController().showPreview()
            UIViewPreview {
                let view = LoginView()
                return view
            }.previewDevice("iPhone 11").previewLayout(.sizeThatFits)

//            UIViewPreview {
//                let view = TopLoginView()
//                return view
//            }.previewDevice("iPhone 11").previewLayout(.sizeThatFits)
        }
    }
}
#endif
