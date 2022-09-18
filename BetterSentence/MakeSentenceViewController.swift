//
//  MakeSentenceViewController.swift
//  BetterSentence
//
//  Created by Myungji Choi on 2022/09/16.
//

import UIKit
import Combine

final class MakeSentenceViewController: UIViewController {

    var sentence = PassthroughSubject<String, Never>()

    private lazy var textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "NotoSerifCJKkr-Medium", size: 17)
        return view
    }()

    private lazy var completeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.touchedCompleteButton), for: .touchUpInside)

        return button
    }()

    static func make() -> MakeSentenceViewController {
        let vc = MakeSentenceViewController()
        return vc
    }

    override func viewDidLoad() {
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(textView, completeButton)

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            completeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            completeButton.heightAnchor.constraint(equalToConstant: 48 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)),
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    @objc
    func touchedCompleteButton() {
        sentence.send(textView.text)
        dismiss(animated: true)
    }
}
