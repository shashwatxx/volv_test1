library carousel_slider;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:volv_testi/utils/utils.dart';

import 'c_options.dart';
import 'c_state.dart';
import 'vc_controller.dart';

typedef Widget ExtendedIndexedWidgetBuilder(
    BuildContext context, int index, int realIndex);

class CarouselSlider extends StatefulWidget {
  /// [CarouselOptions] to create a [CarouselState] with
  final VolvCarouselOptions options;

  /// The widgets to be shown in the carousel of default constructor
  final List<Widget>? items;

  /// The widget item builder that will be used to build item on demand
  /// The third argument is the PageView's real index, can be used to cooperate
  /// with Hero.
  final ExtendedIndexedWidgetBuilder? itemBuilder;

  /// A [MapController], used to control the map.
  final VolvCarouselControllerImpl _carouselController;

  final int? itemCount;

  CarouselSlider(
      {required this.items,
      required this.options,
      carouselController,
      Key? key})
      : itemBuilder = null,
        itemCount = items != null ? items.length : 0,
        _carouselController = carouselController ??
            VolvCarouselController() as VolvCarouselControllerImpl,
        super(key: key);

  /// The on demand item builder constructor
  CarouselSlider.builder(
      {required this.itemCount,
      required this.itemBuilder,
      required this.options,
      carouselController,
      Key? key})
      : items = null,
        _carouselController = carouselController ??
            VolvCarouselController() as VolvCarouselControllerImpl,
        super(key: key);

  @override
  CarouselSliderState createState() => CarouselSliderState();
}

class CarouselSliderState extends State<CarouselSlider>
    with TickerProviderStateMixin {
  Timer? timer;

  VolvCarouselOptions get options => widget.options;

  late VolvCarouselState carouselState;

  PageController? pageController;

  @override
  void didUpdateWidget(CarouselSlider oldWidget) {
    carouselState.options = options;
    carouselState.itemCount = widget.itemCount;

    // pageController needs to be re-initialized to respond to state changes
    pageController = PageController(
      viewportFraction: options.viewportFraction,
      initialPage: carouselState.realPage,
    );
    carouselState.pageController = pageController;

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    carouselState = VolvCarouselState(options);
    carouselState.itemCount = widget.itemCount;
    widget._carouselController.state = carouselState;
    carouselState.initialPage = widget.options.initialPage;
    carouselState.realPage = carouselState.initialPage;

    pageController = PageController(
      viewportFraction: options.viewportFraction,
      initialPage: carouselState.realPage,
    );

    carouselState.pageController = pageController;
  }

  Widget getGestureWrapper(Widget child) {
    Widget wrapper;
    if (widget.options.height != null) {
      wrapper = SizedBox(height: widget.options.height, child: child);
    } else {
      wrapper =
          AspectRatio(aspectRatio: widget.options.aspectRatio, child: child);
    }

    return RawGestureDetector(
      gestures: {
        _MultipleGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<_MultipleGestureRecognizer>(
                () => _MultipleGestureRecognizer(),
                (_MultipleGestureRecognizer instance) {}),
      },
      child: NotificationListener(
        onNotification: (dynamic notification) {
          if (widget.options.onScrolled != null &&
              notification is ScrollUpdateNotification) {
            widget.options.onScrolled!(carouselState.pageController!.page);
          }
          return false;
        },
        child: wrapper,
      ),
    );
  }

  Widget getCenterWrapper(Widget? child) {
    if (widget.options.disableCenter) {
      return Container(
        child: child,
      );
    }
    return Center(child: child);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getGestureWrapper(
      PageView.builder(
        physics: widget.options.scrollPhysics,
        scrollDirection: Axis.horizontal,
        pageSnapping: widget.options.pageSnapping,
        controller: carouselState.pageController,
        itemCount: widget.itemCount,
        key: widget.options.pageViewKey,
        onPageChanged: (int index) {
          if (widget.options.onPageChanged != null) {
            widget.options.onPageChanged!(index + carouselState.initialPage);
          }
        },
        itemBuilder: (BuildContext context, int idx) {
          final int index = Utils.getRealIndex(idx + carouselState.initialPage,
              carouselState.realPage, widget.itemCount);

          return AnimatedBuilder(
            animation: carouselState.pageController!,
            child: (widget.items != null)
                ? (widget.items!.isNotEmpty
                    ? widget.items![index]
                    : Container())
                : widget.itemBuilder!(context, index, idx),
            builder: (BuildContext context, child) {
              double _distortionValue = 1.0;

              double itemOffset;
              // pageController.page can only be accessed after the first build,
              // so in the first build we calculate the itemoffset manually
              try {
                itemOffset = carouselState.pageController!.page! - idx;
              } catch (e) {
                BuildContext storageContext = carouselState
                    .pageController!.position.context.storageContext;
                final double? previousSavedPosition =
                    PageStorage.of(storageContext)?.readState(storageContext)
                        as double?;
                if (previousSavedPosition != null) {
                  itemOffset = previousSavedPosition - idx.toDouble();
                } else {
                  itemOffset =
                      carouselState.realPage.toDouble() - idx.toDouble();
                }
              }
              final num distortionRatio =
                  (1 - (itemOffset.abs() * 0.3)).clamp(0.0, 1.0);
              _distortionValue =
                  Curves.easeOut.transform(distortionRatio as double);

              return getCenterWrapper(child);
            },
          );
        },
      ),
    );
  }
}

class _MultipleGestureRecognizer extends PanGestureRecognizer {}
