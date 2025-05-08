import UIKit

class PhotoGalleryViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let images: [UIImage] = Array(repeating: (1...9).compactMap { UIImage(named: "image\($0)") }, count: 8).flatMap { $0 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        // Setup
        let padding: CGFloat = 10.0
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width / 3 - padding, height: view.bounds.width / 3 - padding)
        layout.minimumInteritemSpacing = padding / 2
        layout.minimumLineSpacing = padding / 2
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        // Header
        layout.headerReferenceSize = CGSize(width: view.bounds.width, height: 50)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCellView.self, forCellWithReuseIdentifier: PhotoCellView.identifier)
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.identifier
        )
        view.addSubview(collectionView)
    }
}

// MARK: - UICollectionViewDelegate
extension PhotoGalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped on image \(indexPath.item + 1)")
    }
}

// MARK: - UICollectionViewDataSource
extension PhotoGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCellView.identifier, for: indexPath) as? PhotoCellView else {
            return UICollectionViewCell()
        }
        cell.configure(with: images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as? HeaderView else {
                return UICollectionReusableView()
            }
            header.configure(with: "Photo Library")
            return header
        }
        return UICollectionReusableView()
    }
}
