//
//  CategoryCollectionViewCell.swift
//  MyApplicationOne
//
//  Created by Almagul Musabekova on 30.01.2023.
//

import UIKit

 final class CategoryCollectionViewCell: UICollectionViewCell {
   
     
    private var cellSelected: Bool = false
    private lazy var categoryNameLabel: UILabel = {
      let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .label//по теме был того цвета
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print(cellSelected)
        setupsViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with text: String) {
        categoryNameLabel.text = text
    }
}

//MARK: - Setup View and constrains methods

extension CategoryCollectionViewCell {
    
    func setupsViews() {
        contentView.addSubview(categoryNameLabel)
        
    }
    
    func setupConstrains() {
        categoryNameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

