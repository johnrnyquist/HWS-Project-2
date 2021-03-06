import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numQuestionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        numQuestionsAsked += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = "\(countries[correctAnswer].uppercased()) Score: \(score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard numQuestionsAsked < 11 else { return }
        
        var alertTitle: String
        if sender.tag == correctAnswer {
            alertTitle = "Correct"
            score += 1
        }else{
            alertTitle = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }

        var ac: UIAlertController
        if numQuestionsAsked < 10 {
            ac = UIAlertController(title: alertTitle, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }else{
            ac = UIAlertController(title: "Game Over", message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            title = "\(countries[correctAnswer].uppercased()) Score: \(score)"
        }
        UIView.animate(withDuration: 0.125,
                       delay: 0,
                       options: [],
                       animations: { sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) })
                    { _ in
                        UIView.animate(withDuration: 0.125,
                                       delay: 0,
                                       options: [],
                                       animations: { sender.transform = .identity }) { _ in self.present(ac, animated: true) }
                    }
    }
    
    @objc func shareTapped() {

        let ac = UIAlertController(title: "Score", message: "Your score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        
        present(ac, animated: true)
    }
}


