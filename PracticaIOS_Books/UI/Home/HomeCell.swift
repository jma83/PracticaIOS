//
//  HomeCell.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let COL_CELL_ID = String(describing: HomeCollectionCell.self)
    weak var delegate: HomeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: COL_CELL_ID, bundle: nil), forCellWithReuseIdentifier: COL_CELL_ID)
    }
    
    var viewModel: [BookViewModel]? {
        didSet {
            if viewModel != nil {
                self.collectionView.reloadData()

            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
    
    
}
extension HomeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: COL_CELL_ID, for: indexPath) as! HomeCollectionCell
        
        let cellViewModel = viewModel?[indexPath.row]
        cell.viewModel = cellViewModel
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: COL_CELL_ID, for: indexPath) as! HomeCollectionCell
        
        let cellViewModel = viewModel?[indexPath.row]
        cell.viewModel = cellViewModel
        delegate?.clickBookEvent(self, homeCell: cell)
    }
    
    
}

protocol HomeCellDelegate: class {
    func clickBookEvent(_: HomeCell, homeCell: HomeCollectionCell)
}
