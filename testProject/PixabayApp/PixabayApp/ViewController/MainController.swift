//
//  ViewController.swift
//  PixabayApp
//
//  Created by Almagul Musabekova on 20.02.2023.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire
import AVKit
import AVFoundation


final class MainController: UIViewController {
    
    private var imageModelList: [ImageModel] = []
    private var videoUrlList: [String] = []
    
    private lazy var contentView = UIView()
    private var mediaType: MediaType = .image
    

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [MediaType.image.rawValue, MediaType.video.rawValue])
        segmentedControl.selectedSegmentIndex = 0// переход нажатие
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.resignFirstResponder()
        //searchBar.backgroundColor = .systemBlue
        return searchBar
    }()
    
    private lazy var mediaCollctionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.mediaCollectionViewCell)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
//        collectionView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
//        collectionView.layer.borderWidth = 1
       // collectionView.backgroundColor = .systemBlue
       override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
       // navigationController?.navigationBar.prefersLargeTitles = true
        configureNavBar()
        
        APICaller.shared.delegate = self
        APICaller.shared.fetchRequest()
       // APICaller.shared.fetchRequest(mediaType: .video)
       mediaCollctionView.dataSource = self
        mediaCollctionView.delegate = self
        searchBar.delegate = self
        
        setupsViews()
        setupConstrains()
        //searchBar.resignFirstResponder()
    }
}

//MARK: - Private view controller methods

private extension MainController {
    func configureNavBar() {
        navigationItem.title = "Movies & Images"
        }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mediaType = .image
            videoUrlList.removeAll()
        case 1:
            mediaType = .video
            imageModelList.removeAll()
        default:
            return
        }
        APICaller.shared.fetchRequest(mediaType: mediaType)
        DispatchQueue.main.async {
            self.mediaCollctionView.reloadData()
        }
    }
}

extension MainController: APICallerDelegate {
  func didUpdateImageModelList(with modelList: [ImageModel]) {
        self.imageModelList = modelList
        DispatchQueue.main.async {
            self.mediaCollctionView.reloadData()
        }
    }
    func didUpdateVideoUrlList(with urlList: [String]) {
        videoUrlList =  urlList
        print(videoUrlList)
        DispatchQueue.main.async {
            self.mediaCollctionView.reloadData()
        }
    }
    func didFailWithError(_ error: Error) {
        print("Following error appeared:", error)
    }
}

//MARK: - Collection view data source methods

extension MainController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch mediaType {
        case .image:
            return imageModelList.count
        case .video:
            return videoUrlList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.mediaCollectionViewCell, for: indexPath) as! MediaCollectionViewCell
        switch mediaType {
        case .image:
            cell.backgroundColor = Constants.Colors.imageCell
            cell.configure(with: imageModelList[indexPath.item])
        case .video:
            cell.backgroundColor = Constants.Colors.videoCell
            cell.configure()
        }
        cell.layer.cornerRadius = 8
        return cell
        }
    }

//MARK: - Collection view delegatae methods

extension MainController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2.06
        return CGSize(width: width, height: width * 1.12)
     }
}
extension MainController: UIPageViewControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch mediaType {
        case .image:
            let controller = DetailsViewController()
            controller.modalPresentationStyle = .overCurrentContext
            controller.modalTransitionStyle = .crossDissolve
            controller.configure(with: imageModelList[indexPath.item].largeURL)
            present(controller, animated: true)//present view 1/2
            print("\(indexPath.item)")
        case .video:
            guard let url = URL(string: videoUrlList[indexPath.item]) else {return}
            let player = AVPlayer(url: url)
            //let controller = AVPlayerViewController()
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(playerLayer)
            player.volume = 1
            player.play()
//            controller.player = player
//            controller.allowsPictureInPicturePlayback = true
//            controller.player?.play()
//            present(controller, animated: true)
        }
        
    }
}

//MARK: - Search bar delegate methods

extension MainController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()//keyboard remove
      }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {//метод при каждом нажатия буквы находят подходящий запрос
        let  query = searchBar.text?.replacingOccurrences(of: " ", with: "+" )
        imageModelList.removeAll()
        APICaller.shared.fetchRequest(with: query ?? "")
    }
}

//MARK: - Setup View and constrains methods

extension MainController {
    
    func setupsViews() {
        view.addSubview(contentView)
        contentView.addSubview(searchBar)
        contentView.addSubview(segmentedControl)
        contentView.addSubview(mediaCollctionView)
    }
    
    func setupConstrains() {
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        segmentedControl.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        searchBar.searchTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        mediaCollctionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
       
    }
}

