//
//  GridLayoutScene.swift
//  ContainerViewSample
//
//  Created by Ysk.Manabe on 2023/01/03.
//

import UIKit


class GridLayoutScene: UICollectionViewController {

    private static let reuseIdentifier = "GridLayoutCell"

    weak var dataSource: GridLayoytSceneDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource?.numberOfRows ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.reuseIdentifier, for: indexPath) as! GridLayoutCell
    
        guard let dataSource = self.dataSource?.dataSourceforCell(at: indexPath.row) else {
            return cell
        }

        cell.titleLabel.text = dataSource.title
        cell.imageView.image = dataSource.image
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

protocol GridLayoytSceneDataSource: AnyObject {

    var numberOfRows: Int {get}

    func dataSourceforCell(at index: Int) -> GridLayoutSceneDataSource
}

protocol GridLayoutSceneDataSource {

    var title: String {get}
    var image: UIImage {get}
}

extension GridLayoutScene: ListSceneEmbededDelegate {

    func reloadData() {
        self.collectionView.reloadData()
    }
}
