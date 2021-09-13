//
//  HomeView.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/09/13.
//

import Anchorage
import UIKit

class HomeView: ProgrammaticView {
    
    private let headerView = HeaderView()
    private lazy var collectionView = makeCollectionView()
    private lazy var dataSource = makeDataSource()
    
    override func configure() {
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = dataSource
    }
    
    override func constrain() {
        addSubviews(headerView, collectionView)

        // Anchorage package methods
        headerView.topAnchor == topAnchor
        headerView.horizontalAnchors == horizontalAnchors
        headerView.bottomAnchor == collectionView.topAnchor
        
        collectionView.horizontalAnchors == horizontalAnchors
        collectionView.bottomAnchor == bottomAnchor
    }
    
    func apply(_ snapshot: NSDiffableDataSourceSnapshot<Section, Content>) {
        dataSource.apply(snapshot)
    }
}

extension HomeView {
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = Section.allCases[sectionIndex]
            switch section {
            // 이후에 다른 layout 적용을 위해 switch 문을 사용하는듯.
            case .nearby:
                return .sideScrollingTwoItem()
            }
        }
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Content> {
        let dataSource = UICollectionViewDiffableDataSource<Section, Content>(
            collectionView: collectionView) { view, indexPath, item in
            // closure 로 함수를 정의해줬기 때문에, 그 함수가 여기서 계속 실행이 된다는 건가?
            let section = Section.allCases[indexPath.section]
            switch section {
            case .nearby:
                let registration = SmallSquareCell.registration()
                return view.dequeueConfiguredReusableCell(using: registration,
                                                          for: indexPath,
                                                          item: item)
            }
        }
        return dataSource
    }
}
