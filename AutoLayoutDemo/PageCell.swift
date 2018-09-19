
import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        // page her set edildiğinde kontrol eder
        didSet {
            // uwrap edilmediğinde hata verir. bundan ötürü guard let kullanılıyor. Çok önemli burası.
            guard let unwrappedPage = page else { return }
            bearImage.image = UIImage(named: unwrappedPage.imageName)
            
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
            
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13),NSAttributedStringKey.foregroundColor: UIColor.gray]))
            
            
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
           
            
           
        }
    }
    
    let bearImage: UIImageView = {
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
        
    }()
    
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Elhamdülillah oluyor.", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\n\nBurası bold olmayacak. Daha güzel bir görünüm için daha açık fontlar kullanılıyor. Bunlara dikkat etmelisin zeynel!!!", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13),NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        
        textView.attributedText = attributedText
        
        //        textView.text = "Elhamdülillah oluyor."
        //        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    
    private let previousButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Önceki", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        
        
        return button
        
        
    }()
    
    private let nextButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sonraki", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal) // mainPink için extension a bak
        
        
        return button
        
        
    }()
    
    private let pageControl: UIPageControl = {
        
        let pControl = UIPageControl()
        pControl.currentPage = 0
        pControl.numberOfPages = 4
        pControl.translatesAutoresizingMaskIntoConstraints = false
        pControl.pageIndicatorTintColor = .gray
        pControl.currentPageIndicatorTintColor = .mainPink // extension kısmında mainPink değişkenini oluşturduk
        return pControl
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupView()
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupView() {
        
        let topImageContainerView = UIView()
        addSubview(topImageContainerView) // pagecell içinde olduğumuz için view demeye ihtiyaç yok. pagecell zaten bir view
        addSubview(descriptionTextView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        // aşağıdakilerin üçünü de belirt. bottom eklendiğinde multiplier ile çakışıyor.
        // pagecell zaten view olduğu için standard ViewController için kullandığımız view i referans almıyoruz
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        // topImageContainerView = ancestor of bearImage
        topImageContainerView.addSubview(bearImage)
        
        bearImage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        bearImage.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        
        bearImage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        // Container ın height ini view e göre ayarla...
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        

        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        // -24 e dikkat et
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        
    }
    
}

