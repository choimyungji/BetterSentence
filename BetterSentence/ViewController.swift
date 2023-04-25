//
//  ViewController.swift
//  BetterSentence
//
//  Created by Myungji Choi on 2020/11/30.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private var bag = Set<AnyCancellable>()
    private var storage = SentenceStorage.shared

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addSentenceButton: UIButton!
    @IBAction func touchedAddSentenceButton(_ sender: Any) {
        let vc = MakeSentenceViewController.make()
        vc.sentence.sink { [weak self] value in
            let sentence = Sentence(sentence: value, author: "Martin Choi", time: Date())
            self?.storage.add(sentence: sentence)
            self?.collectionView.reloadData()
        }.store(in: &bag)

        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        storage.sentencesSubject.sink { _ in
            self.collectionView.reloadData()
        }.store(in: &bag)

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        storage.sentences.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CSCollectionViewCell
        
        cell.lbl.text = storage.sentences[indexPath.row].sentence
        cell.author.text = storage.sentences[indexPath.row].author
        
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

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil, attributes: .destructive) { _ in
            let id = self.storage.sentences[indexPath.row].id
            self.storage.deleteSentence(id: id)
            collectionView.reloadData()
        }

        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            UIMenu(title: "", children: [deleteAction])
        }

        return configuration
    }
}

class CSCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func draw(_ rect: CGRect) {
        lbl.font = UIFont(name: "NotoSerifCJKkr-Medium", size: 17)
        author.font = UIFont(name: "NotoSerifCJKkr-Medium", size: 15)
        
        let line = UIView(frame: CGRect(x: frame.width * 3 / 8, y: frame.height-1, width: frame.width/4, height: 0.5))
        line.backgroundColor = .gray
        self.addSubview(line)
    }
}
