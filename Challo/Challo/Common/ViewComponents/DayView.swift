//
//  DayView.swift
//  Challo
//
//  Created by Tan Le Yang on 9/4/21.
//

import HorizonCalendar
import UIKit

// MARK: - DayView
final class DayView: UIView {
    
    // MARK: Lifecycle
    init(invariantViewProperties: InvariantViewProperties) {
        dayLabel = UILabel()
        dayLabel.font = invariantViewProperties.font
        dayLabel.textAlignment = invariantViewProperties.textAlignment
        dayLabel.textColor = invariantViewProperties.isDisabledStyle
            ? invariantViewProperties.disabledColor
            : invariantViewProperties.textColor

        super.init(frame: .zero)

        addSubview(dayLabel)

        layer.borderColor = invariantViewProperties.selectedColor.cgColor
        layer.borderWidth = invariantViewProperties.isSelectedStyle ? 2 : 0
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal
    var dayText: String {
        get { dayLabel.text ?? "" }
        set { dayLabel.text = newValue }
    }

    var dayAccessibilityText: String?

    var isHighlighted = false {
        didSet {
          updateHighlightIndicator()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        dayLabel.frame = bounds
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }

    // MARK: Private
    private let dayLabel: UILabel

    private func updateHighlightIndicator() {
        backgroundColor = isHighlighted ? UIColor.black.withAlphaComponent(0.1) : .clear
    }
}

// MARK: CalendarItemViewRepresentable
extension DayView: CalendarItemViewRepresentable {

    struct InvariantViewProperties: Hashable {
        var font = UIFont.systemFont(ofSize: 18)
        var textAlignment = NSTextAlignment.center
        var textColor: UIColor
        var isDisabledStyle: Bool
        var isSelectedStyle: Bool
        var disabledColor = UIColor.gray.withAlphaComponent(0.2)
        var selectedColor = UIColor.blue
    }

    struct ViewModel: Equatable {
        let dayText: String
    }

    static func makeView(
        withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
        -> DayView {
        DayView(invariantViewProperties: invariantViewProperties)
    }

    static func setViewModel(_ viewModel: ViewModel, on view: DayView) {
        view.dayText = viewModel.dayText
    }
}
