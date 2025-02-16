import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:ice_cream_ui/icecream/model/ice_cream_model.dart';

class IceCreamCard extends StatefulWidget {
  final IceCream drink;
  final double pageOffset;
  final int index;

  const IceCreamCard(this.drink, this.pageOffset, this.index, {super.key});

  @override
  State<IceCreamCard> createState() => _IceCreamCardState();
}

class _IceCreamCardState extends State<IceCreamCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _translateAnimation;

  double columnAnimation = 0;
  double rotate = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant IceCreamCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pageOffset != widget.pageOffset) {
      _controller.repeat(); // إعادة تشغيل الأنيميشن عند تغير الصفحة
      _controller.forward();
    }
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _translateAnimation = Tween(begin: -50.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose(); // إيقاف الأنيميشن عند الخروج
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth = size.width - 60;
    double cardHeight = size.height * .55;

    rotate = widget.index - widget.pageOffset;

    return Stack(
      clipBehavior: Clip.none, // Use clipBehavior instead of overflow
      children: <Widget>[
        buildTopText(),
        buildBackgroundImage(cardWidth, cardHeight, size),
        buildAboveCard(cardWidth, cardHeight, size),
        buildIceCreamImage(size),
        buildSmallImage(size),
        buildTopImage(size, cardHeight, cardWidth),
      ],
    );
  }

  Widget buildTopText() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 5),
          FadeTransition(
            opacity: _opacityAnimation,
            child: Text(
              widget.drink.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: widget.drink.lightColor,
              ),
            ),
          ),
          FadeTransition(
            opacity: _opacityAnimation,
            child: Text(
              widget.drink.conName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: widget.drink.darkColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBackgroundImage(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .15,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            widget.drink.backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildAboveCard(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .15,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: widget.drink.darkColor.withOpacity(0.50),
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.all(30),
        child: Transform.translate(
          offset: Offset(-columnAnimation, 0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: Text(
                      widget.drink.name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: Text(
                      widget.drink.conName,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              FadeTransition(
                opacity: _opacityAnimation,
                child: Text(
                  widget.drink.description,
                  style: const TextStyle(color: Colors.white70, fontSize: 18),
                ),
              ),
              const Spacer(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIceCreamImage(Size size) {
    return Positioned(
      bottom: 0,
      left: -30,
      child: Transform.rotate(
        angle: -math.pi / 14 * rotate,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset(
            widget.drink.cupImage,
            height: size.height * .55 - 15,
          ),
        ),
      ),
    );
  }

  Widget buildSmallImage(Size size) {
    return Positioned(
      right: -10 + _translateAnimation.value,
      top: size.height * .3,
      child: Image.asset(widget.drink.smallImage, height: 100),
    );
  }

  Widget buildTopImage(Size size, double cardHeight, double cardWidth) {
    return Positioned(
      left: cardWidth / 4 - _translateAnimation.value,
      bottom: size.height * .15 + cardHeight - 25,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: Image.asset(widget.drink.topImage, height: 100),
      ),
    );
  }
}
