import UIKit

private let reuseIdentifier = "Cell"

class HourlyWeatherCollectionViewController: UICollectionViewController { 
    private var items: [ForecastItem] = []
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        if let layout = layout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal 
            layout.itemSize = CGSize(width: 100, height: 150)
            layout.minimumLineSpacing = 10
        }
        super.init(collectionViewLayout: layout)
        self.collectionView.collectionViewLayout = layout
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.dataSource = self
        self.collectionView.register(HourlyForecastViewCell.self, forCellWithReuseIdentifier: HourlyForecastViewCell.identifier)
    }
    
    func config(recivedItems: [ForecastItem]) {
        self.items = recivedItems
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastViewCell.identifier, for: indexPath) as! HourlyForecastViewCell
        let currentItem = items[indexPath.row]
        print(currentItem)
        cell.config(with: currentItem.dtTxt, temp: currentItem.main.temp, imagePath: "cloud")
        
        return cell
    }
}
