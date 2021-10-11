import 'package:flutter/material.dart';

class VolvCarouselOptions {
  /// Set carousel height and overrides any existing [aspectRatio].
  final double? height;

  /// Aspect ratio is used if no height have been declared.
  /// Defaults to 16:9 aspect ratio.
  final double aspectRatio;

  /// The fraction of the viewport that each page should occupy.
  ///
  /// Defaults to 0.8, which means each page fills 80% of the carousel.
  final double viewportFraction;

  /// The initial page to show when first creating the [CarouselSlider].
  ///
  /// Defaults to 0.
  final int initialPage;

  /// Called whenever the page in the center of the viewport changes.
  final Function(int index)? onPageChanged;

  /// Called whenever the carousel is scrolled
  final ValueChanged<double?>? onScrolled;

  /// How the carousel should respond to user input.
  ///
  /// For example, determines how the items continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? scrollPhysics;

  /// Set to false to disable page snapping, useful for custom scroll behavior.
  ///
  /// Default to `true`.
  final bool pageSnapping;

  /// Pass a `PageStoragekey` if you want to keep the pageview's position when it was recreated.
  final PageStorageKey? pageViewKey;

  /// Whether or not to disable the `Center` widget for each slide.
  final bool disableCenter;

  VolvCarouselOptions({
    this.height,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 0.8,
    this.initialPage = 0,
    this.onPageChanged,
    this.onScrolled,
    this.scrollPhysics,
    this.pageSnapping = true,
    this.pageViewKey,
    this.disableCenter = false,
  });
}
