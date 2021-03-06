//
//  ViewController.swift
//  BetterSentence
//
//  Created by Myungji Choi on 2020/11/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addSentenceButton: UIButton!
    @IBAction func touchedAddSentenceButton(_ sender: Any) {
        print("aaa")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        exampleSentence.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CSCollectionViewCell
        
        cell.lbl.text = exampleSentence[indexPath.row].sentence
        cell.author.text = exampleSentence[indexPath.row].author
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        
        let size = CGSize(width: width, height: 134)
        return size
    }
    
}

class CSCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func draw(_ rect: CGRect) {
        lbl.font = UIFont(name: "NotoSerifCJKkr-Medium", size: 17)
        author.font = UIFont(name: "NotoSerifCJKkr-Medium", size: 15)
        
        print(frame)
        let line = UIView(frame: CGRect(x: frame.width * 3 / 8, y: frame.height-1, width: frame.width/4, height: 0.5))
        line.backgroundColor = .gray
        self.addSubview(line)
    }
}
