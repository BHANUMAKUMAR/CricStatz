import 'package:cricstatz/config/assets.dart';
import 'package:flutter/material.dart';

class CoinFlipWidget extends StatefulWidget {
  const CoinFlipWidget({super.key});

  @override
  State<CoinFlipWidget> createState() => CoinFlipWidgetState();
}

class CoinFlipWidgetState extends State<CoinFlipWidget>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _bounceController;
  late AnimationController _glowController;

  late Animation<double> _rotationAnimation;
  late Animation<double> _heightAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _bounceAnimation;

  bool _isFlipping = false;
  bool _resultHeads = true;
  bool _showFallback = false;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _setUpAnimations();
  }

  void _setUpAnimations() {
    // Main rotation: start at 0, end at N*pi depending on desired outcome
    _rotationAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutExpo),
    );

    // Height arc: rises quickly (0-0.35), falls with bounce (0.35-1.0)
    _heightAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 180),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 180, end: 0),
        weight: 65,
      ),
    ]).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutQuint),
    );

    // Scale: 1.0 -> 1.25 -> 1.0, synced with height
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.25),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.25, end: 1.0),
        weight: 65,
      ),
    ]).animate(_mainController);

    // Bounce: damped sine oscillation after landing
    _bounceAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );

    // Glow: radial pulse
    _glowAnimation =
        Tween<double>(begin: 0, end: 1).animate(_glowController);

    // Listen for main animation end
    _mainController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _bounceController.forward().then((_) {
          _glowController.forward();
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImages();
  }

  Future<void> _precacheImages() async {
    try {
      if (!mounted) return;
      await precacheImage(
        AssetImage(AppAssets.coinHeads),
        context,
      );
      if (!mounted) return;
      await precacheImage(
        AssetImage(AppAssets.coinTails),
        context,
      );
    } catch (e) {
      debugPrint('Error precaching coin images: $e');
      if (mounted) {
        setState(() => _showFallback = true);
      }
    }
  }

  /// Public method to initiate the coin flip animation
  Future<bool> flip() async {
    if (_isFlipping) return _resultHeads;

    setState(() {
      _isFlipping = true;
      _resultHeads = _randomBool();
      _showFallback = false;
    });

    // Calculate target rotation: each full rotation is 2*pi
    // Even number of pi = heads, odd = tails
    double spins = 6.5; // 6 full rotations + half for result variation
    double targetRotation = spins * 3.14159265359;

    // Adjust for desired outcome
    if (!_resultHeads) {
      // If tails, add extra half rotation
      targetRotation += 3.14159265359;
    }

    // Update rotation animation
    _rotationAnimation = Tween<double>(begin: 0, end: targetRotation).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutExpo),
    );

    _mainController.reset();
    _bounceController.reset();
    _glowController.reset();

    await _mainController.forward();

    // Wait for bounce and glow to complete
    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() => _isFlipping = false);

    return _resultHeads;
  }

  bool _randomBool() => DateTime.now().millisecondsSinceEpoch % 2 == 0;

  @override
  void dispose() {
    _mainController.dispose();
    _bounceController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _mainController,
        _bounceController,
        _glowController,
      ]),
      builder: (context, child) {
        // Calculate current rotation angle
        double rotationValue = _rotationAnimation.value;

        // Face swapping logic: every pi radians, we flip which face shows
        // We use rotation angle to determine which face should be visible
        int faceIteration = (rotationValue / 3.14159265359).floor();
        bool showingHeads = faceIteration % 2 == 0;

        // Determine which image to show
        String imageToShow = showingHeads
            ? AppAssets.coinHeads
            : AppAssets.coinTails;

        // Calculate vertical position
        double heightOffset = _heightAnimation.value;
        double bounceOffset = _bounceAnimation.value * 20; // Small bounce
        double totalHeight = heightOffset + bounceOffset;

        // Get scale
        double scale = _scaleAnimation.value;

        // Shadow gets smaller as coin rises
        double shadowScale = 1 - (heightOffset / 180) * 0.6;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Glow effect (appears after landing)
            if (_glowAnimation.value > 0)
              Container(
                width: 120 * _glowAnimation.value,
                height: 120 * _glowAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _resultHeads
                          ? const Color(0xFFFFD700).withValues(
                              alpha: 0.6 * (1 - _glowAnimation.value),
                            )
                          : const Color(0xFFC0C0C0).withValues(
                              alpha: 0.6 * (1 - _glowAnimation.value),
                            ),
                      blurRadius: 40 * _glowAnimation.value,
                      spreadRadius: 10 * _glowAnimation.value,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            // Coin container with transformations
            Transform.translate(
              offset: Offset(0, -totalHeight),
              child: Transform.scale(
                scale: scale,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0015) // Perspective
                    ..rotateY(rotationValue),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Heads
                        if (!_showFallback)
                          Image.asset(
                            imageToShow,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              setState(() => _showFallback = true);
                              return _buildFallbackCoin(showingHeads);
                            },
                          )
                        else
                          _buildFallbackCoin(showingHeads),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Shadow
            Opacity(
              opacity: shadowScale,
              child: Container(
                width: 80 * shadowScale,
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black.withValues(alpha: 0.3),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFallbackCoin(bool isHeads) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isHeads ? const Color(0xFFFFD700) : const Color(0xFFC0C0C0),
        boxShadow: [
          BoxShadow(
            color: (isHeads ? const Color(0xFFFFD700) : const Color(0xFFC0C0C0))
                .withValues(alpha: 0.5),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          isHeads ? 'H' : 'T',
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
