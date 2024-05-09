import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    let photoNames = ["image1", "image2"]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoNames.count // Количество ячеек равно количеству фотографий
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        // Получаем имя фотографии из списка и загружаем изображение
        let photoName = photoNames[indexPath.item]
        if let image = UIImage(named: photoName) {
            cell.imageView.image = image // Устанавливаем изображение в ячейку
        }
        
        return cell
    }
}
