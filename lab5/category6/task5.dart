import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum Trans { fade, slide, scale, slideScale }

CustomTransitionPage<void> buildPage(
  GoRouterState state,
  Widget child, {
  Trans trans = Trans.slideScale,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );
      final slideFromRight = Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(curved);

      switch (trans) {
        case Trans.fade:
          return FadeTransition(opacity: curved, child: child);
        case Trans.slide:
          return SlideTransition(position: slideFromRight, child: child);
        case Trans.scale:
          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(curved),
              child: child,
            ),
          );
        case Trans.slideScale:
          return SlideTransition(
            position: slideFromRight,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.0).animate(curved),
              child: child,
            ),
          );
      }
    },
  );
}

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

    // Raw version from the lab text (fade).
    GoRoute(
      path: '/details',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const DemoScreen('Raw CustomTransitionPage (fade)'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),

    // Reusing the helper for all other routes.
    GoRoute(
      path: '/fade',
      pageBuilder: (context, state) =>
          buildPage(state, const DemoScreen('Fade'), trans: Trans.fade),
    ),
    GoRoute(
      path: '/slide',
      pageBuilder: (context, state) => buildPage(
          state, const DemoScreen('Slide from right'),
          trans: Trans.slide),
    ),
    GoRoute(
      path: '/scale',
      pageBuilder: (context, state) =>
          buildPage(state, const DemoScreen('Scale + fade'), trans: Trans.scale),
    ),
    GoRoute(
      path: '/combo',
      pageBuilder: (context, state) =>
          buildPage(state, const DemoScreen('Slide + scale (default)')),
    ),
  ],
);

void main() => runApp(MaterialApp.router(routerConfig: router));

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const entries = {
      '/details': 'Raw fade (from the lab text)',
      '/fade': 'buildPage: fade',
      '/slide': 'buildPage: slide from right',
      '/scale': 'buildPage: scale + fade',
      '/combo': 'buildPage: slide + scale',
    };
    return Scaffold(
      appBar: AppBar(title: const Text('go_router transitions')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final e in entries.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  onPressed: () => context.push(e.key),
                  child: Text(e.value),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DemoScreen extends StatelessWidget {
  final String title;
  const DemoScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.pop(),
          child: const Text('pop (watch the reverse animation)'),
        ),
      ),
    );
  }
}
