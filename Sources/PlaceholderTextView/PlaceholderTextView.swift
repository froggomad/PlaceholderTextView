import UIKit

public class PlaceholderTextView: UITextView {
    private var disabledColor: UIColor = .systemGray2
    
    public var placeholder: String {
        didSet {
            if text.isEmpty {
                text = placeholder
            }
        }
    }
    
    public override var text: String! {
        didSet {
            if textColor == disabledColor {
                text = nil
                textColor = .black
            } else if text.isEmpty {
                text = placeholder
                textColor = disabledColor
            }
        }
    }
    
    public required init(placeholder: String, frame: CGRect = .zero) {
        self.placeholder = placeholder
        super.init(frame: frame, textContainer: nil)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        self.placeholder = ""
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.text = placeholder
        textColor = disabledColor
    }
}
