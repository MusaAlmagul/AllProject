//
//  SectionHeaderView.swift
//  MyApplicationOne
//
//  Created by Almagul Musabekova on 04.02.2023.
//

import UIKit

final class SectionHeaderView: UIView {
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .label
        return label
    }()
    
    private lazy var allLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemOrange
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupsViews()
        setupConstrains()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(widht text: String, number: Int) {
        categoryLabel.text = text
        allLabel.text = "All \(number)"
    }

}
//MARK: - Setup View and constrains methods

extension SectionHeaderView {
    
    func setupsViews() {
        addSubview(categoryLabel)
        addSubview(allLabel)
    }
    
    func setupConstrains() {
        categoryLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        allLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryLabel.snp.trailing)
            make.top.bottom.trailing.equalToSuperview()
        }
    }
}

