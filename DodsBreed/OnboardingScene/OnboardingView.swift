//
//  OnboardingView.swift
//  DodsBreed
//
//  Created by Татьяна Исаева on 04.07.2024.
//

import UIKit
import Lottie


extension OnboardingView {
	struct ViewMetrics {
		let scrollViewInsets = UIEdgeInsets(top: 16.0, left: 0.0, bottom: 32.0, right: 0.0)
		let pageControlInsets = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 16.0, right: 16.0)
		let lottieViewAnimationName = "Animation - dog and man"
		let lottieSliderViewAnimationName = "Animation - dog"
		let lottieViewSize = CGSize(width: 192.0, height: 192.0)
	}
}


final class OnboardingView: UIView {

	// MARK: Output
	var onTapSignInButton: (() -> Void)?
	var indexControl = 1


	// MARK: Private Properties
	private let viewMetrics = ViewMetrics()
	private let makeTopOffset = (UIScreen.main.bounds.height * 4.2) / 100
	private let previousProgress: AnimationProgressTime = 0.0
	private let slides = [
		OnboardingSlideView(title: "Свайпай влево"),
		OnboardingSlideView(title: "Продолжай!"),
		OnboardingSlideView(title: "Движение пошло!"),
		OnboardingSlideView(title: "Круто!"),
		OnboardingSlideView(title: "Скоро добежит!"),
		OnboardingSlideView(title: "Свайпай вправо")
	]

	
	// MARK: View Properties
	private lazy var lottieView: AnimationView = {
		let view = AnimationView()
		let animation = Animation.named(viewMetrics.lottieViewAnimationName)
		view.animation = animation
		view.loopMode = .loop
		view.play()
		view.contentMode = .scaleAspectFit
		view.backgroundBehavior = .pauseAndRestore
		
		return view
	}()

	private lazy var lottieViewSlider: AnimationView = {
		let view = AnimationView()
		let animation = Animation.named(viewMetrics.lottieSliderViewAnimationName)
		view.animation = animation
		view.contentMode = .scaleAspectFit

		return view
	}()

	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.isPagingEnabled = true
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.showsVerticalScrollIndicator = false
		scrollView.delegate = self

		return scrollView
	}()

	private lazy var pageControl: UIPageControl = {
		let pageControl = UIPageControl()
		pageControl.pageIndicatorTintColor = UIColor.brown
		pageControl.currentPageIndicatorTintColor = UIColor.red
		pageControl.numberOfPages = self.slides.count

		return pageControl
	}()

	private func nextButtonTap() {
		if indexControl < slides.count {
			if scrollView.contentOffset.x < self.bounds.width * CGFloat(slides.count)
			{
				scrollView.contentOffset.x += self.bounds.width
				indexControl += 1
			}
		} else if indexControl >= slides.count {
			self.onTapSignInButton?()
		}
	}

	private lazy var slideStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		stackView.alignment = .bottom

		return stackView
	}()


	// MARK: Init
	init(frame: CGRect, viewMetrics: ViewMetrics = .init()) {
		super.init(frame: frame)
		
		addSubview(lottieView)
		addSubview(lottieViewSlider)
		addSubview(scrollView)
		scrollView.addSubview(slideStackView)
		slides.forEach { slideStackView.addArrangedSubview($0) }
		addSubview(pageControl)
		configureLayout()
	}

	// MARK: Private Method
	private func configureLayout() {

		lottieView.snp.makeConstraints { (make) in
			make.centerX.equalToSuperview()
			make.top.equalToSuperview().offset(96)
			make.size.equalTo(viewMetrics.lottieViewSize)
		}

		lottieViewSlider.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(makeTopOffset + 8)
			make.left.right.equalToSuperview()
		}

		scrollView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(16 + viewMetrics.scrollViewInsets.top)
			make.left.right.equalToSuperview().inset(viewMetrics.scrollViewInsets)
			make.bottom.equalTo(pageControl.snp.top)
		}

		slideStackView.snp.makeConstraints { (make) in
			make.height.equalToSuperview()
			make.left.right.equalToSuperview()
			make.top.equalTo(scrollView.snp.bottom).offset(-makeTopOffset)
		}

		slides.forEach { (view) in
			view.snp.makeConstraints({ (make) in
				make.width.equalTo(self)
			})
		}

		pageControl.snp.makeConstraints { (make) in
			make.left.right.equalToSuperview().inset(viewMetrics.pageControlInsets)
			make.bottom.equalToSuperview().offset(-viewMetrics.pageControlInsets.bottom)
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	// MARK: View Actions
	@objc
	private func skipTap() {
		self.onTapSignInButton?()
	}
}

// MARK: - UIScrollViewDelegate
extension OnboardingView: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let pageIndex = round(scrollView.contentOffset.x / frame.width)
		pageControl.currentPage = Int(pageIndex)
		self.indexControl = Int(pageIndex)

		let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
		let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x

		lottieViewSlider.currentProgress = currentHorizontalOffset / maximumHorizontalOffset
	}
}
