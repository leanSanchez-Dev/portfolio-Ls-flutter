import 'package:flutter/material.dart';

// Widget para precargar imágenes en background
class ImagePreloader {
  static final Map<String, ImageProvider> _cache = {};

  static Future<void> preloadImages(
      List<String> imagePaths, BuildContext context) async {
    for (String path in imagePaths) {
      if (!_cache.containsKey(path)) {
        try {
          final imageProvider = AssetImage(path);
          await precacheImage(imageProvider, context);
          _cache[path] = imageProvider;
        } catch (e) {
          debugPrint('Error preloading image $path: $e');
        }
      }
    }
  }

  static ImageProvider? getCachedImage(String path) {
    return _cache[path];
  }

  static void clearCache() {
    _cache.clear();
  }
}

// Widget para efecto shimmer de carga
class ShimmerLoader extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerLoader({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  });

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.baseColor ??
        Theme.of(context).colorScheme.surface.withOpacity(0.3);
    final highlightColor = widget.highlightColor ??
        Theme.of(context).colorScheme.surface.withOpacity(0.1);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: [
                (_animation.value - 1).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 1).clamp(0.0, 1.0),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget optimizado para carga de imágenes con estados visuales
class OptimizedImageLoader extends StatefulWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  final bool enableCache;
  final bool useShimmer;

  const OptimizedImageLoader({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeOut,
    this.enableCache = true,
    this.useShimmer = true,
  });

  @override
  State<OptimizedImageLoader> createState() => _OptimizedImageLoaderState();
}

class _OptimizedImageLoaderState extends State<OptimizedImageLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  ImageProvider? _imageProvider;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.fadeInDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.fadeInCurve,
    ));

    _loadImage();
  }

  @override
  void didUpdateWidget(OptimizedImageLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _controller.reset();
      _loadImage();
    }
  }

  void _loadImage() {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    // Intentar obtener de cache primero
    final cachedImage = ImagePreloader.getCachedImage(widget.imageUrl);
    if (cachedImage != null) {
      _imageProvider = cachedImage;
      setState(() {
        _isLoading = false;
        _hasError = false;
      });
      _controller.forward();
      return;
    }

    _imageProvider = AssetImage(widget.imageUrl);

    _imageProvider!.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                  _hasError = false;
                });
                _controller.forward();
              }
            },
            onError: (dynamic error, StackTrace? stackTrace) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                  _hasError = true;
                });
              }
            },
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen principal con animación de fade
          if (!_hasError && !_isLoading)
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Image(
                    image: _imageProvider!,
                    fit: widget.fit,
                    width: widget.width,
                    height: widget.height,
                  ),
                );
              },
            ),

          // Loading placeholder
          if (_isLoading)
            widget.placeholder ??
                (widget.useShimmer
                    ? ShimmerLoader(
                        width: widget.width,
                        height: widget.height,
                        borderRadius: BorderRadius.circular(12),
                      )
                    : Container(
                        color: Theme.of(context).cardColor,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context)
                                        .primaryColor
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Cargando imagen...',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )),

          // Error widget
          if (_hasError)
            widget.errorWidget ??
                Container(
                  color: Theme.of(context).cardColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image_outlined,
                          size: 48,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.4),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error al cargar imagen',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _loadImage,
                          child: Text(
                            'Reintentar',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
