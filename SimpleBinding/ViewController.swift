//
//  ViewController.swift
//  SimpleBinding
//
//  Created by Zak Barlow on 28/01/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var goToNextVCButton: UIButton!
        
    @IBAction func goToNextVCButtonPressed(_ sender: UIButton) {
        print("Button pressed")
        
        let newVC = ColorVC()
        newVC.configure(with: ColorViewModel())
        navigationController?.pushViewController(newVC, animated: true)
    }
}

class ColorVC: UIViewController {
    
    var viewModel: ColorViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getNewColorFromApi()
    }
    
    
    func configure(with viewModel: ColorViewModel) {
        
        self.viewModel = viewModel
        
        viewModel.color.bind { [weak self] color in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.view.backgroundColor = color
            }
        }
    }
}

class ColorViewModel {
    
    var color: Box<UIColor> = Box(.red)
    
    func getNewColorFromApi() {
        //Simulating fetch of a color from API, and then updating the bound property, boxed UIColor
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            self.color.value = [.green, .purple, .blue, .orange, .yellow, .cyan, .magenta, .brown].randomElement() ?? .red
        }
    }
    
}
