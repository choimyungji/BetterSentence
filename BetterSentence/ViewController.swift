//
//  ViewController.swift
//  BetterSentence
//
//  Created by Myungji Choi on 2020/11/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sentenceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let sentence = exampleSentence.randomElement()
        sentenceLabel.text = sentence?.sentence
        authorLabel.text = sentence?.author
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        exampleSentence.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CSCollectionViewCell
        
        cell.lbl.text = exampleSentence[indexPath.row].sentence
        
        return cell
    }
    
}

class CSCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lbl: UILabel!
    
}
