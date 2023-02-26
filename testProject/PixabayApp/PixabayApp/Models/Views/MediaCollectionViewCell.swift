//
//  MediaCollectionViewCell.swift
//  PixabayApp
//
//  Created by Almagul Musabekova on 22.02.2023.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
    
    private lazy var mediaImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .label
        label.text = "Name"
        label.textAlignment = .center
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
    
    func configure(with model: ImageModel) {
            guard let url = URL(string: model.previewURL)  else  { return }
            DispatchQueue.main.async {
                self.mediaImageView.contentMode = .scaleAspectFill
                self.mediaImageView.kf.setImage(with: url)
        }
    }
    
    func configure() {
            DispatchQueue.main.async {
                self.mediaImageView.contentMode = .scaleAspectFit
                self.mediaImageView.image = UIImage(systemName: "play.circle.fill")
              
            }
        }
    }


//MARK: - Setup View and constrains methods

extension MediaCollectionViewCell {
    
    func setupsViews() {
        contentView.addSubview(mediaImageView)
        contentView.addSubview(nameLabel)
    }
    
    func setupConstrains() {
        mediaImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(mediaImageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

