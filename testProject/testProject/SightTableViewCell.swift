//
//  SightTableViewCell.swift
//  testProject
//
//  Created by Almagul Musabekova on 28.01.2023.
//

import UIKit

final class SightTableViewCell: UITableViewCell {
    
    private let textView = UIView()
    
    private lazy var sightNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .label
        return label
    }()

    private lazy var priceNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.backgroundColor = .systemGray2
        return label
    }()
    
    private lazy var imageNameLabel: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    static let IDENTIFIER = "SightID"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setupsViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func configure(with sight: Sight) {
        sightNameLabel.text = sight.name
        priceNameLabel.text = "Price:\(sight.tourPrice) $"
        imageNameLabel.image = UIImage(named: sight.imageName)
    }
}

//MARK: - Setup View and constrains methods

extension SightTableViewCell {
    
    func setupsViews() {
        contentView.addSubview(textView)
        textView.addSubview(sightNameLabel)
        textView.addSubview(priceNameLabel)
        contentView.addSubview(imageNameLabel)
    }
    
    func setupConstrains() {
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.bottom.equalToSuperview().inset(15)
            //make.width.equalToSuperview().multipliedBy(0.75)
        }
        sightNameLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(5)
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        priceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(sightNameLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            
        }
        imageNameLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview().inset(5)
            make.leading.equalTo(textView.snp.trailing)
            make.size.equalTo(140)
        }
       
    }
}
