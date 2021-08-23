import UIKit

protocol PlaceholderTextViewDelegate: UITextViewDelegate { }

extension PlaceholderTextViewDelegate {
    private var disabledColor: UIColor { .systemGray2 }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == disabledColor {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = disabledColor
        }
    }
    
}

class PlaceholderTextView: UITextView {
    var placeholder: String {
        didSet {
            if text.isEmpty {
                text = placeholder
            }
        }
    }
    
    required init(placeholder: String, delegate: PlaceholderTextViewDelegate, frame: CGRect = .zero) {
        self.placeholder = placeholder
        super.init(frame: frame, textContainer: nil)
        self.delegate = delegate
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        self.placeholder = ""
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        
    }
}