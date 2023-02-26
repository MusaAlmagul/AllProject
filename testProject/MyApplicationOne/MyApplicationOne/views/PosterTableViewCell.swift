//
//  PosterTableViewCell.swift
//  MyApplicationOne
//
//  Created by Almagul Musabekova on 19.02.2023.
//

import UIKit

final class PosterTableViewCell: UITableViewCell {

    private lazy var posterImageCell: UIImageView = {
       let imageView = UIImageView()
        //imageView.image = UIImage(named: "maleficent")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private var labelView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        //label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
//label.text = "Puss in Boots: The Last With"
        return label
    }()
    
    private lazy var tagLineLabel: UILabel = {
        let label = UILabel()
        //label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .systemGray2
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
       // label.text = "Say hola to his little freinds."
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
       // label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .label
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
       // label.text = "Puss in Boots discovers that his passion for adventure has taken its toll: He has eight of his none lives, leaving him with only one life left. Puss sets out on an epic journey mythical Last Wish and restore his nine livesburned through."
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupsViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with model: DetailedMovieModel) {
        let urlString = "\(Constants.Links.image)\(model.posterPath)"
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.main.async {
            self.posterImageCell.kf.setImage(with: url)
            self.titleLabel.text = model.title
            self.tagLineLabel.text = model.tagline
            self.overviewLabel.text = model.overview
            
        }
    }
}
//MARK: - Setup View and constrains methods

extension PosterTableViewCell {
    
    func setupsViews() {
        contentView.addSubview(posterImageCell)
        contentView.addSubview(labelView)
        labelView.addSubview(titleLabel)
        labelView.addSubview(tagLineLabel)
        labelView.addSubview(overviewLabel)
    }
    
    func setupConstrains() {
        posterImageCell.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(10)
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        labelView.snp.makeConstraints { make in
            make.leading.equalTo(posterImageCell.snp.trailing).offset(10)
            make.top.trailing.bottom.equalToSuperview().inset(10)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
       tagLineLabel.snp.makeConstraints { make in
           make.top.equalTo(titleLabel.snp.bottom)
           make.leading.trailing.equalToSuperview()
           make.height.equalToSuperview().multipliedBy(0.2)
        }
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(tagLineLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

