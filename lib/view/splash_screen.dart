import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ghar_sewa/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _loadingController;
  late AnimationController _particleController;
  
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _logoRotation;
  late Animation<Offset> _textSlide;
  late Animation<double> _textFade;
  late Animation<double> _loadingProgress;
  late Animation<double> _particleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    // Logo animations
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _logoRotation = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    // Text animations
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutBack,
    ));

    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeIn,
      ),
    );

    // Loading animation
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _loadingProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _loadingController,
        curve: Curves.easeInOut,
      ),
    );

    // Particle animation
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      _particleController,
    );
  }

  void _startAnimationSequence() async {
    // Start logo animation immediately
    _logoController.forward();
    
    // Start particle animation
    _particleController.forward();
    
    // Start text animation after 800ms
    Timer(const Duration(milliseconds: 800), () {
      if (mounted) _textController.forward();
    });
    
    // Start loading animation after 1200ms
    Timer(const Duration(milliseconds: 1200), () {
      if (mounted) _loadingController.forward();
    });
    
    // Navigate after 3.5 seconds
    Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        navigatorKey.currentState?.pushReplacementNamed('/login');
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _loadingController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF64B5F6), // Light blue
              Color(0xFF2196F3), // Material blue
              Color(0xFF1976D2), // Darker blue
              Color(0xFF0D47A1), // Deep blue
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated particles background
            AnimatedBuilder(
              animation: _particleAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: ParticlePainter(_particleAnimation.value),
                  size: Size.infinite,
                );
              },
            ),
            
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated logo with your asset
                  AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoScale.value,
                        child: Transform.rotate(
                          angle: _logoRotation.value,
                          child: FadeTransition(
                            opacity: _logoFade,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 25,
                                    offset: const Offset(0, 15),
                                    spreadRadius: 5,
                                  ),
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, -5),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/logo/splash.png',
                                  width: 280,
                                  height: 280,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 50),
                  
                  // Animated text for Ghar Sewa
                  SlideTransition(
                    position: _textSlide,
                    child: FadeTransition(
                      opacity: _textFade,
                      child: Column(
                        children: [
                          Text(
                            'घर सेवा',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(0, 3),
                                  blurRadius: 6,
                                ),
                                Shadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  offset: const Offset(0, 0),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ghar Sewa',
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1.5,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Your Home Service Partner',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Animated loading indicator
            Positioned(
              bottom: 80,
              left: 50,
              right: 50,
              child: AnimatedBuilder(
                animation: _loadingProgress,
                builder: (context, child) {
                  return Column(
                    children: [
                      // Custom circular progress with home service theme
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Stack(
                          children: [
                            CircularProgressIndicator(
                              value: _loadingProgress.value,
                              strokeWidth: 4,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                            Center(
                              child: Icon(
                                Icons.home_work_outlined,
                                color: Colors.white.withOpacity(0.8),
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Loading text with dots animation
                      AnimatedBuilder(
                        animation: _particleController,
                        builder: (context, child) {
                          int dotCount = ((_particleController.value * 3) % 3).floor() + 1;
                          return Text(
                            'Loading Services${'.' * dotCount}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.5,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            
            // Floating home service icons
            Positioned(
              top: 120,
              right: 40,
              child: AnimatedBuilder(
                animation: _particleController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      sin(_particleController.value * 2 * pi) * 15,
                      cos(_particleController.value * 2 * pi) * 15,
                    ),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.cleaning_services,
                        color: Colors.white.withOpacity(0.6),
                        size: 20,
                      ),
                    ),
                  );
                },
              ),
            ),
            
            Positioned(
              top: 250,
              left: 30,
              child: AnimatedBuilder(
                animation: _particleController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      cos(_particleController.value * 2 * pi + 1) * 20,
                      sin(_particleController.value * 2 * pi + 1) * 20,
                    ),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(17.5),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.handyman,
                        color: Colors.white.withOpacity(0.6),
                        size: 18,
                      ),
                    ),
                  );
                },
              ),
            ),
            
            Positioned(
              bottom: 200,
              right: 60,
              child: AnimatedBuilder(
                animation: _particleController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      sin(_particleController.value * 2 * pi + 2) * 12,
                      cos(_particleController.value * 2 * pi + 2) * 12,
                    ),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.home_repair_service,
                        color: Colors.white.withOpacity(0.6),
                        size: 16,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final double animationValue;
  
  ParticlePainter(this.animationValue);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.fill;
    
    final random = Random(42); // Fixed seed for consistent particles
    
    for (int i = 0; i < 25; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final offset = Offset(
        x + sin(animationValue * 2 * pi + i) * 25,
        y + cos(animationValue * 2 * pi + i) * 15,
      );
      
      final radius = 1.5 + sin(animationValue * 3 * pi + i) * 1.5;
      canvas.drawCircle(offset, radius, paint);
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
