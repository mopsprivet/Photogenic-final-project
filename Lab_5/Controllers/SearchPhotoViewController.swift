//import UIKit
//import SwiftUI
//
//struct APIResponse: Codable {
//    let total: Int
//    let total_pages: Int
//    let results: [Result]
//}
//
//struct Result: Codable {
//    let id: String
//    let urls: URLs
//}
//
//struct URLs: Codable {
//    //let full: String
//    let regular: String
//}
//
//
//class SearchPhotoViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {
//        
//    //let urlString = "https://api.unsplash.com/search/photos?page=1&query=office&client_id=ig6Hg1UfpgHgFLwt0eJpwSF6EeDlpYq8YIMxymfi4-o"
//    
//    private var collectionView: UICollectionView?
//    
//    var results: [Result] = []
//    
//    //@IBOutlet var searchbar: UISearchBar!
//    let searchbar = UISearchBar()
//    
//    @IBAction func backButton(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    override func viewDidLoad() {
//        self.view.backgroundColor = #colorLiteral(red: 0.1255135536, green: 0.135696739, blue: 0.1907175183, alpha: 1)
//
//        super.viewDidLoad()
//        searchbar.delegate = self
//        view.addSubview(searchbar)
//        searchbar.isHidden = false
//
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 1
//        layout.minimumInteritemSpacing = 0
//        layout.itemSize = CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
//        
//        let collectionView = UICollectionView (frame: .zero, collectionViewLayout: layout)
//        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
//        collectionView.dataSource = self
//        view.addSubview(collectionView)
//        self.collectionView = collectionView
//        fetchPhotos(query: "Sun")
//        print("viewDidLoad done")
//    }
//    
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        searchbar.frame = CGRect(x: 10, y: Int(view.safeAreaInsets.top), width: Int(view.frame.size.width)-20, height: 50)
//        collectionView?.frame = CGRect(x: 0, y: Int(view.safeAreaInsets.top), width: Int(view.frame.size.width), height: Int(view.frame.size.height-55))
//        print("viewDidLayoutSubviews done")
//    }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//        if let text = searchbar.text {
//            results = []
//            collectionView?.reloadData()
//            fetchPhotos(query: text)
//            print("searchBarSearchButtonClicked works")
//        } else {
//            print("searchBarSearchButtonClicked doesn't work")
//        }
//    }
//    
//    func fetchPhotos(query: String) {
//        let urlString = "https://api.unsplash.com/search/photos?page=1&query=\(query)&client_id=ig6Hg1UfpgHgFLwt0eJpwSF6EeDlpYq8YIMxymfi4-o"
//        guard let url = URL(string: urlString) else {
//            print("URL is invalid")
//            return
//        }
//        print("Data request started")
//        
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            guard let data = data, error == nil else {
//                print("Data task error:", error?.localizedDescription ?? "Unknown error")
//                return
//            }
//            print("Data received!")
//            
//            do {
//                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
//                print("Number of results:", jsonResult.results.count)
//                DispatchQueue.main.async {
//                    self?.results = jsonResult.results
//                    print("Updated results count:", self?.results.count ?? 0)
//                    self?.collectionView?.reloadData()
//                }
//            } catch {
//                //print("JSON decoding error:", error)
//                print("Doesn't work")
//            }
//        }
//        
//        task.resume()
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if !results.isEmpty {
//            print("collectionView Good")
//            return results.count
//        } else {
//            print("collectionView Doesn't work")
//            return 0
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let imageURLString = results[indexPath.row].urls.regular
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
//            print("Could not dequeue cell for indexPath: \(indexPath)")
//            return UICollectionViewCell()
//        }
//        
//        cell.configure(with: imageURLString)
//        print("Cell configured for indexPath: \(indexPath)")
//        return cell
//    }
//    
//}
