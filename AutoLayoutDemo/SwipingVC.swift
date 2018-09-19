//
//  SwipingVC.swift
//  AutoLayoutDemo
//
//  Created by Demo on 17.09.2018.
//  Copyright © 2018 Demo. All rights reserved.
//



import UIKit

class SwipingVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
   
    
    let pages = [
        Page(imageName: "bear_first", headerText: "Bismillah her hayrın başıdır.", bodyText: "Burası Bold olmayacak. Daha güzel bir görünüm için daha açık fontlar kullanılıyor. Bunlara dikkat etmelisin. Zeynel..."),
        Page(imageName: "heart_second", headerText: "Ortada Leziz nimetleri vereni isim ve sıfatlarının tecellilerini tefekkür ederek fikrediyoruz.", bodyText: "Burası Bold olmayacak. Daha güzel bir görünüm için daha açık fontlar kullanılıyor. Bunlara dikkat etmelisin. Zeynel!!!"),
        Page(imageName: "leaf_third", headerText: "Sonda Elhamdülillah Diyoruz.", bodyText: "Burası Bold olmayacak. Daha güzel bir görünüm için daha açık fontlar kullanılıyor. Bunlara dikkat etmelisin. Zeynellll")
    ]
    private let previousButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Önceki", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        
        
        return button
        
        
    }()
    
    @objc private func handlePrev() {
        
        print("prev btn pressed")
     
        
        // Returns the lesser of two comparable values.
        // anlaşıldı. üzerinde düşün.
        let nextIndex = max(pageControl.currentPage - 1, 0)

        let indexPath = IndexPath(item: nextIndex, section: 0)
        // bir nevi reset ediyoruz. butona her basıldığında ilk duruma getirmemiz gerekir.
        pageControl.currentPage = nextIndex
        
        // Scrolls the collection view contents until the specified item is visible.
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    
    private let nextButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sonraki", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal) // mainPink için extension a bak
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        return button
        
        
    }()
    
    @objc private func handleNext() {
    
        print("next btn pressed")
        // Returns the lesser of two comparable values.
        let nextIndex = min(pageControl.currentPage + 1, pages.count-1)
        
        let indexPath = IndexPath(item: nextIndex, section: 0)
        // bir nevi reset ediyoruz. butona her basıldığında ilk duruma getirmemiz gerekir.
        pageControl.currentPage = nextIndex
        
        // Scrolls the collection view contents until the specified item is visible.
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    
    }
    
    // lazy var kullanılda instance lara erişebiliyorsun.
     lazy var pageControl: UIPageControl = {
        
        let pControl = UIPageControl()
        pControl.currentPage = 0
        pControl.numberOfPages = pages.count
        pControl.translatesAutoresizingMaskIntoConstraints = false
        pControl.pageIndicatorTintColor = .gray
        pControl.currentPageIndicatorTintColor = .mainPink // extension kısmında mainPink değişkenini oluşturduk
        return pControl
        
    }()
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
    }
    

    fileprivate func setupBottomControls() {

        let bottomStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomStackView.distribution = .fillEqually
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false

        // üstte alındığında hata veriyor. tanımlanan değişkenlerden sonra ekle view i.
        view.addSubview(bottomStackView)


        NSLayoutConstraint.activate([bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor), bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor), bottomStackView.heightAnchor.constraint(equalToConstant: 50)])

    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.isPagingEnabled = true
        
        setupBottomControls()
    }
    
    
    

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let pageIndex = pages[indexPath.item]
        
        cell.page = pageIndex

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
 
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    // swipe edilen sayfalar arasındaki boşluğu döner.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
}
extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}
