import UIKit
import SwiftUI 

struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let regular: String
}

class SearchPhotoViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {
    
    //let urlString = "https://api.unsplash.com/search/photos?page=1&query=office&client_id=ig6Hg1UfpgHgFLwt0eJpwSF6EeDlpYq8YIMxymfi4-o"

    private var collectionView: UICollectionView?

    var results: [Result] = []

    let searchbar = UISearchBar()

    override func viewDidLoad() {
        self.view.backgroundColor = #colorLiteral(red: 0.1255135536, green: 0.135696739, blue: 0.1907175183, alpha: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout)) 

        super.viewDidLoad()
        searchbar.delegate = self
        view.addSubview(searchbar)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        self.collectionView = collectionView
        fetchPhotos(query: "Sun")
        print("viewDidLoad done")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let searchBarWidth = view.frame.size.width - 20
            let searchBarHeight: CGFloat = 58
        searchbar.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: searchBarWidth, height: searchBarHeight)
        searchbar.barTintColor = #colorLiteral(red: 0.1255135536, green: 0.135696739, blue: 0.1907175183, alpha: 1)
        searchbar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Enter your request", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        searchbar.layer.cornerRadius = 12
        searchbar.searchTextField.backgroundColor = .systemGray.withAlphaComponent(0.3)
        searchbar.searchTextField.textColor = .white
        collectionView?.backgroundColor = #colorLiteral(red: 0.1255135536, green: 0.135696739, blue: 0.1907175183, alpha: 1)
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top + searchBarHeight, width: view.frame.size.width, height: view.frame.size.height - searchBarHeight)
        print("viewDidLayoutSubviews done")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
        if let text = searchbar.text {
            results = []
            collectionView?.reloadData()
            fetchPhotos(query: text)
        }
    }

    func fetchPhotos(query: String) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=20&query=\(query)&client_id=ig6Hg1UfpgHgFLwt0eJpwSF6EeDlpYq8YIMxymfi4-o"
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    self?.collectionView?.reloadData()
                }
            }
            catch {
                print(error)
            }
        }

        task.resume()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = results[indexPath.row].urls.regular
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCollectionViewCell.identifier,
            for: indexPath
        ) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: imageURLString)
        return cell
    }
    
    @objc private func didTapLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutErrorAlert(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}
