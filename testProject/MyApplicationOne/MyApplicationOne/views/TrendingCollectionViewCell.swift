//
//  TrendingCollectionViewCell.swift
//  MyApplicationOne
//
//  Created by Almagul Musabekova on 05.02.2023.
//

import UIKit
import Kingfisher
 
final class TrendingCollectionViewCell: UICollectionViewCell {
    
    private lazy var trendingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupsViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with backdropPath: String) {
        guard let url = URL(string: "\(Constants.Links.image)\(backdropPath)") else { fatalError("Incorrect to configure!") }
        DispatchQueue.main.async {
            self.trendingImageView.kf.setImage(with: url)
        }
    }
}
//MARK: - Setup View and constrains methods

extension TrendingCollectionViewCell {
    
    func setupsViews() {
        contentView.addSubview(trendingImageView)
    }
    
    func setupConstrains() {
        trendingImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
    }
}

