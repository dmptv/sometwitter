//
//  HomeDatasourceController.swift
//  SomeTwitter
//
//  Created by Kanat A on 14/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON


class HomeDatasourceController: DatasourceController {
    
    let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Error occeres"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        view.addSubview(errorMessageLabel)
        errorMessageLabel.fillSuperview()
        
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)

        setupNavigationBarItems()
        
        Service.sharedInstance.fetchHomeFeed { (homeDatasource, err) in
            if let err = err {
                self.errorMessageLabel.isHidden = false
                
                if let apiError = err as? APIError<Service.JSONError> {
                    
                    if apiError.response?.statusCode != 200 {
                        // if error 404 white blanc. 
                        self.errorMessageLabel.text = "Status code was not 200"
                    }
                }
                
                return
            }
            
            self.datasource = homeDatasource
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //first section of users
        if indexPath.section == 0 {
            guard let user = self.datasource?.item(indexPath) as? User else {return .zero}
                
            let estimatedHeight =  estimatedHeightFortext(text: user.bioText)
            return CGSize(width: view.frame.width, height: estimatedHeight + 66)
            
        } else if indexPath.section == 1 {
            // tweets size estimation
            guard let tweet = self.datasource?.item(indexPath) as? Tweet else {return .zero}
            
            let estimatedHeight = estimatedHeightFortext(text: tweet.message)
            return CGSize(width: view.frame.width, height: estimatedHeight + 74)
        }
        
        return CGSize(width: view.frame.width, height: 200)
    }
    
    fileprivate func estimatedHeightFortext(text: String) -> CGFloat {
        let size = CGSize(width: view.frame.width - 12 - 50 - 12, height: 1000)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
        
        let estimatedFrame  = NSString(string: text).boundingRect(with: size, options: [.usesLineFragmentOrigin], attributes: attributes, context: nil)
        return estimatedFrame.height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.width, height: 64)
    }
}









