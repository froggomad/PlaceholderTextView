import UIKit

public protocol PlaceholderTextViewDelegate: UIResponder {
    func didEndEditing()
    func didBeginEditing()
}

public class PlaceholderTextView: UITextView {
    weak var placeholderTextViewDelegate: PlaceholderTextViewDelegate!
    weak var view: UIView!
    
    private var disabledColor: UIColor = .systemGray2
    
    private func listen() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(resignFirstResponder))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        view?.addGestureRecognizer(tap)
        
        let center = NotificationCenter.default
        let queue = OperationQueue.main
        let didBeginEditing = Self.textDidBeginEditingNotification
        let didEndEditing = Self.textDidEndEditingNotification
                
        center.addObserver(forName: didBeginEditing, object: self, queue: queue) { [weak self] _ in
            guard let self = self else { return }
            
            if self.textColor == self.disabledColor {
                self.text = nil
                self.textColor = .black
            }
            
            self.placeholderTextViewDelegate?.didBeginEditing()
        }
        
        center.addObserver(forName: didEndEditing, object: self, queue: queue) { [weak self] _ in
            guard let self = self else { return }
            
            if self.text.isEmpty {
                self.text = self.placeholder
                self.textColor = self.disabledColor
            }
            
            self.placeholderTextViewDelegate?.didEndEditing()
        }
        
    }
    
    public var placeholder: String {
        didSet {
            if text.isEmpty {
                text = placeholder
            }
        }
    }
    
    public required init(delegate: PlaceholderTextViewDelegate, view: UIView, placeholder: String, frame: CGRect = .zero) {
        self.view = view
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
