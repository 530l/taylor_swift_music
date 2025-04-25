import 'package:flutter/material.dart';

class ErrorView extends StatefulWidget {
  // 样式常量
  static const double _iconSize = 64.0;
  static const double _spacingSmall = 16.0;
  static const double _spacingLarge = 24.0;
  static const double _fontSize = 16.0;
  static const double _buttonIconSize = 20.0;
  static const double _buttonPadding = 12.0;
  static const double _buttonBorderRadius = 8.0;
  static const double _loadingIndicatorSize = 20.0;
  static const double _loadingIndicatorStrokeWidth = 2.0;

  // 颜色常量
  static final Color _errorIconColor = Colors.red[300]!;
  static const Color _textColor = Colors.black87;
  static const Color _buttonColor = Colors.blue;
  static const Color _buttonTextColor = Colors.white;

  final String errorMessage;
  final VoidCallback onRetry;
  final bool isLoading;

  const ErrorView({
    super.key,
    required this.errorMessage,
    required this.onRetry,
    required this.isLoading,
  });

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: _buildMainContainer(
              child: _buildContent(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainContainer({required Widget child}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ErrorView._spacingSmall),
        child: child,
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildErrorIcon(),
        _buildSpacing(height: ErrorView._spacingSmall),
        _buildErrorMessage(),
        _buildSpacing(height: ErrorView._spacingLarge),
        _buildRetryButton(),
      ],
    );
  }

  Widget _buildSpacing({double height = ErrorView._spacingSmall}) {
    return SizedBox(height: height);
  }

  Widget _buildErrorIcon() {
    return Icon(
      Icons.error_outline,
      size: ErrorView._iconSize,
      color: ErrorView._errorIconColor,
    );
  }

  Widget _buildErrorMessage() {
    return Text(
      widget.errorMessage,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: ErrorView._fontSize,
        color: ErrorView._textColor,
      ),
    );
  }

  Widget _buildRetryButton() {
    return _buildStyledButton(
      onPressed: widget.isLoading
          ? null
          : () {
              _controller.reset();
              _controller.forward();
              widget.onRetry();
            },
      icon: _buildButtonIcon(),
      label: _buildButtonLabel(),
    );
  }

  Widget _buildStyledButton({
    VoidCallback? onPressed,
    required Widget icon,
    required Widget label,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: _getButtonStyle(),
      icon: icon,
      label: label,
    );
  }

  ButtonStyle _getButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: ErrorView._buttonColor,
      foregroundColor: ErrorView._buttonTextColor,
      padding: const EdgeInsets.symmetric(
        horizontal: ErrorView._spacingLarge,
        vertical: ErrorView._buttonPadding,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ErrorView._buttonBorderRadius),
      ),
      elevation: 2,
      shadowColor: ErrorView._buttonColor.withOpacity(0.3),
    );
  }

  Widget _buildButtonIcon() {
    return widget.isLoading
        ? _buildLoadingIndicator()
        : TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 2 * 3.14159),
            duration: const Duration(seconds: 2),
            builder: (context, value, child) {
              return Transform.rotate(
                angle: value,
                child: const Icon(
                  Icons.refresh_rounded,
                  size: ErrorView._buttonIconSize,
                ),
              );
            },
          );
  }

  Widget _buildLoadingIndicator() {
    return const SizedBox(
      width: ErrorView._loadingIndicatorSize,
      height: ErrorView._loadingIndicatorSize,
      child: CircularProgressIndicator(
        strokeWidth: ErrorView._loadingIndicatorStrokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(ErrorView._buttonTextColor),
      ),
    );
  }

  Widget _buildButtonLabel() {
    return Text(
      widget.isLoading ? '重试中...' : '重试',
      style: const TextStyle(fontSize: ErrorView._fontSize),
    );
  }
}
