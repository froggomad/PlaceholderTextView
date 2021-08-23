import UIKit

public protocol PlaceholderTextViewDelegate: UITextViewDelegate { }


extension PlaceholderTextViewDelegate {
    private var disabledColor: UIColor { .systemGray2 }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == disabledColor {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = disabledColor
        }
    }
    
}

public class PlaceholderTextView: UITextView {
    public var placeholder: String {
        didSet {
            if text.isEmpty {
                text = placeholder
            }
        }
    }
    
    public required init(placeholder: String, delegate: PlaceholderTextViewDelegate, frame: CGRect = .zero) {
        self.placeholder = placeholder
        super.init(frame: frame, textContainer: nil)
        self.delegate = delegate
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        self.placeholder = ""
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        
    }
}
