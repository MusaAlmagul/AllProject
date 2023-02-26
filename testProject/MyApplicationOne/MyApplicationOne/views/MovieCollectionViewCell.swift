//
//  MovieCollectionViewCell.swift
//  MyApplicationOne
//
//  Created by Almagul Musabekova on 05.02.2023.
//

import UIKit
import SnapKit
final class MovieCollectionViewCell: UICollectionViewCell {
    
    private var genreList: [Int:String] = [:]
    private let wholeView = UIView()
    
    private lazy var posterImageV2: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "maleficent")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    private lazy var movieNameLabel: UILabel = {
      let label = UILabel()
       
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        //label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        //label.sizeToFit()
        label.textColor = .label
        label.text = "Maleficent Out: Class Onion"
        return label
    }()
    
    private lazy var genresLabel: UILabel = {
      let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.textColor = .systemGray2
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
    
    func configure(with model: MovieModel, and genreList: [Int:String]) {
        self.genreList = genreList
        var stringGenreList: [String] = []
        for i in 0..<model.genreIds.count {
            stringGenreList.append(genreList[model.genreIds[i]] ?? "")
            
        }
       guard let url = URL(string: "\(Constants.Links.image)\(model.posterPath)") else {fatalError("Incorect link to poster")}
        //let stringGenres = model.genreIds.map { String($0) }
    
        DispatchQueue.main.async {
            self.posterImageV2.kf.setImage(with: url)
            self.movieNameLabel.text = model.title
            self.genresLabel.text = stringGenreList.joined(separator: ", ")
        }
    }
    
}


//MARK: - Setup View and constrains methods

extension MovieCollectionViewCell {
    
    func setupsViews() {
        contentView.addSubview(wholeView)
        wholeView.addSubview(posterImageV2)
        wholeView.addSubview(movieNameLabel)
        wholeView.addSubview(genresLabel)
    }
    
    func setupConstrains() {
        wholeView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        posterImageV2.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageV2.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.02)
        }
        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            
        }
    }
}

