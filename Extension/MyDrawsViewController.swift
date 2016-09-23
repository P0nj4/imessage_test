//
//  MyDrawsViewController.swift
//  WriteAndSendOnMessage
//
//  Created by German Pereyra on 9/23/16.
//  Copyright © 2016 German Pereyra. All rights reserved.
//

import UIKit
import Messages

protocol MessageExpandableDelegate {
    func expandConveration()
}


class MyDrawsViewController: UICollectionViewController {
    
    enum CollectionViewItem {
        case draw(NSURL)
        case create
    }

    private var items: [CollectionViewItem] = []
    var delegate: MessageExpandableDelegate?
    
    init() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 90)
        
        super.init(collectionViewLayout: layout)
        
        self.collectionView?.registerClass(StickerCell.self, forCellWithReuseIdentifier: StickerCell.reuseIdentifier)
        self.collectionView?.registerClass(CreateStickerCell.self, forCellWithReuseIdentifier: CreateStickerCell.reuseIdentifier)
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.frame = self.view.bounds
        
        self.items.insert(.create, atIndex: 0)
        let imagesPath = getDocumentsDirectory().path!
        do {
            let images = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(imagesPath)
            for imageName in images {
                print(imageName)
                if let _ = UIImage(contentsOfFile: imagesPath.stringByAppendingString("/\(imageName)")) {
                    let path = imagesPath.stringByAppendingString("/\(imageName)")
                    items.append(.draw(NSURL(fileURLWithPath: path)))
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        
        // The item's type determines which type of cell to return.
        switch item {
        case .draw(let url):
            guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StickerCell.reuseIdentifier, forIndexPath: indexPath) as? StickerCell else { fatalError("Unable to dequeue am StickerCell") }
            cell.stickerView.sticker = try! MSSticker(contentsOfFileURL: url, localizedDescription: "test localization")
            return cell
            
        case .create:
            guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CreateStickerCell.reuseIdentifier, forIndexPath: indexPath) as? CreateStickerCell else { fatalError("Unable to dequeue a CreateStickerCell") }
            return cell
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.expandConveration()
    }
    
    
    func getDocumentsDirectory() -> NSURL {
        let paths = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains:.UserDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

class StickerCell: UICollectionViewCell {
    
    static let reuseIdentifier = "StickerCell"
    var stickerView: MSStickerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.stickerView = MSStickerView(frame: self.bounds)
        self.contentView.addSubview(self.stickerView)
        self.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.contentView.layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CreateStickerCell: UICollectionViewCell {
    static let reuseIdentifier = "CreateStickerCell"
    
    let image = UIImageView(image: UIImage(named: "create"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(image)
        image.frame = self.bounds
        image.contentMode = .ScaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

