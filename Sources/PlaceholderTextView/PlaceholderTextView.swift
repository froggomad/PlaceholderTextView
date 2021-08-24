import UIKit

public protocol PlaceholderTextViewDelegate: AnyObject {
    func didEndEditing()
    func didBeginEditing()
}

public class PlaceholderTextView: UITextView {
    weak var placeholderTextViewDelegate: PlaceholderTextViewDelegate?
    
    private var disabledColor: UIColor = .systemGray2
    
    private func listen() {
        
        let center = NotificationCenter.default
        let queue = OperationQueue.main
        let didEndEditing = Self.textDidEndEditingNotification
        let didBeginEditing = Self.textDidBeginEditingNotification
        
        center.addObserver(forName: didEndEditing, object: self, queue: queue) { [weak self] _ in
            self?.placeholderTextViewDelegate?.didEndEditing()
        }
        
        center.addObserver(forName: didBeginEditing, object: self, queue: queue) { [weak self] _ in
            self?.placeholderTextViewDelegate?.didBeginEditing()
        }
        
    }
    
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
    
    public required init(delegate: PlaceholderTextViewDelegate, placeholder: String, frame: CGRect = .zero) {
        self.placeholderTextViewDelegate = delegate
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
        listen()
    }
    
}
