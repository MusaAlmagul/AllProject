//
//  DetailsHeaderView.swift
//  MyApplicationOne
//
//  Created by Almagul Musabekova on 19.02.2023.
//

import UIKit

final class DetailsHeaderView: UIView {

    private lazy var backdropImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = .systemBlue
        //imageView.image = UIImage(named: "avatar")
        return imageView
    }()
    
//    private var wholeView = UIView()
    
//    private lazy var posterImageView: UIImageView = {
//       let imageView = UIImageView()
//        return imageView
//    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        wholeView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
//        wholeView.layer.borderWidth = 2
//
        setupsViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(wiwth model: DetailedMovieModel) {
        let urlString = "\(Constants.Links.image)\(model.backdropPath)"
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.main.async {
            self.backdropImageView.kf.setImage(with: url)
        }
    }
}
//MARK: - Setup View and constrains methods

extension DetailsHeaderView {
    
    func setupsViews() {
      addSubview(backdropImageView)
       // addSubview(wholeView)
    }
    
    func setupConstrains() {
        backdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        wholeView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(10)
//        }
    }
}

