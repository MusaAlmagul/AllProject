//
//  SectionHeaderView.swift
//  testProject
//
//  Created by Almagul Musabekova on 27.01.2023.
//

import UIKit

final class SectionHeaderView: UIView {

    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .label
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupText(on text: String) {
        mainLabel.text = text
    }
    
}
//MARK: - Setup views and constrains methods

private extension SectionHeaderView {
    
    func setupViews() {
       addSubview(mainLabel)
    }
    func setupConstrains() {
        mainLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
