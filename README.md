# SimpleBinding

A Simple MVVM Binding Example in Swift Using a Generic Wrapper Class


## Box ##

Box<T>, a wrapper class for dynamic binding


```swift
class Box<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    /// Setup binding and fire with current Box\<T\>.value
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    /// Setup binding and await change to Box\<T\>.value before executing closure
    func bindAwait(listener: Listener?) {
        self.listener = listener
    }
    
}
```

Example use case, configuring view-viewModel dynamic binding:

```swift

class ViewModel {
    var color: Box<UIColor> = Box(.red)
    var title: Box<String> = Box("Hello, World!")
}

class ViewController: UIViewController {
    
    var viewModel: ViewModel?
    
    func configure(with viewModel: ViewModel) {
        
        self.viewModel = viewModel
        
        // Set up dynamic binding, updating view backgroundColor on viewModel.color.value change
        viewModel.color.bind { [weak self] color in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.view.backgroundColor = color
            }
        }
        
        // Set up dynamic binding, updating someLabel text on viewModel.title.value change
        viewModel.title.bind { [weak self] title in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.someLabel.text = title
            }
        }
    }
}
```
