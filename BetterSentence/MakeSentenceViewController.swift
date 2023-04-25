//
//  MakeSentenceViewController.swift
//  BetterSentence
//
//  Created by Myungji Choi on 2022/09/16.
//

import UIKit
import SnapKit
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
        setKeyboardNotification()
    }

    private func setKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        completeButton.snp.updateConstraints {
            $0.bottom.equalToSuperview().offset(-keyboardFrame.height)
        }
    }

    @objc private func keyboardWillHide() {
        completeButton.snp.updateConstraints {
            $0.bottom.equalToSuperview()
        }
    }

    func setupUI() {
        let safeAreaInset = UIApplication.shared.windows.first?.safeAreaInsets ?? .zero

        view.backgroundColor = .white
        view.addSubview(textView)
        view.addSubview(completeButton)

        textView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(safeAreaInset)
        }

        completeButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(48 + safeAreaInset.bottom)
        }
    }

    @objc
    func touchedCompleteButton() {
        sentence.send(textView.text)
        dismiss(animated: true)
    }
}

extension UIResponder {
    private weak static var _currentFirstResponder: UIResponder? = nil

    public static var current: UIResponder? {
        UIResponder._currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder(sender:)), to: nil, from: nil, for: nil)
        return UIResponder._currentFirstResponder
    }

    @objc internal func findFirstResponder(sender: AnyObject) {
        UIResponder._currentFirstResponder = self
    }
}
