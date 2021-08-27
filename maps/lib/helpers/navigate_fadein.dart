part of 'helpers.dart';

PageRouteBuilder<dynamic> navigateFadeIn(BuildContext context, Widget child) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => child,
    transitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, _, child) {
      return FadeTransition(
        child: child,
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
        ),
      );
    },
  );
}
