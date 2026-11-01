import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';

import '../../support/l10n.dart';
import 'ideas_test_support.dart';

Finder _key(String key) => find.byKey(ValueKey<String>(key));

/// The ideas the page lists, by the keys of their rows.
Finder get _rows => find.byWidgetPredicate(
  (Widget w) =>
      w.key is ValueKey<String> &&
      (w.key! as ValueKey<String>).value.startsWith('ideas-preset-'),
);

Future<void> _closeSheet(WidgetTester tester) async {
  final NavigatorState nav = tester.state(find.byType(Navigator).first);
  nav.pop();
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the heart of a card marks the idea as a favourite', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpIdeas(tester);

    expect(scope.ideaFavorites.favorites, isEmpty);
    await tester.ensureVisible(_key('ideas-heart-one_color'));
    await tester.tap(_key('ideas-heart-one_color'));
    await tester.pumpAndSettle();
    expect(scope.ideaFavorites.favorites, <String>{'one_color'});
    expect(
      find.descendant(
        of: _key('ideas-heart-one_color'),
        matching: find.byTooltip(l10n.commonRemoveFromFavourites),
      ),
      findsOneWidget,
    );

    // A second tap takes it out again.
    await tester.tap(_key('ideas-heart-one_color'));
    await tester.pumpAndSettle();
    expect(scope.ideaFavorites.favorites, isEmpty);
    expect(
      find.descendant(
        of: _key('ideas-heart-one_color'),
        matching: find.byTooltip(l10n.commonAddToFavourites),
      ),
      findsOneWidget,
    );
  });

  testWidgets('the idea of the day has a heart too', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpIdeas(tester);
    final String featured = IdeasEngine.featuredFor(DateTime(2026, 10, 29)).id;

    await tester.tap(_key('ideas-heart-$featured-featured'));
    await tester.pumpAndSettle();

    expect(scope.ideaFavorites.favorites, <String>{featured});
  });

  testWidgets(
    'the Favourites chip shows only the hearts, with an empty state',
    (WidgetTester tester) async {
      final AppScope scope = await pumpIdeas(tester);
      final int all = _rows.evaluate().length;
      expect(all, greaterThan(3));

      // Nothing is a favourite yet: the empty state explains how.
      await tester.tap(_key('ideas-category-favorites'));
      await tester.pumpAndSettle();
      expect(_key('ideas-favorites-empty'), findsOneWidget);
      expect(find.text(l10n.ideasFavoritesEmptyTitle), findsOneWidget);
      expect(find.text(l10n.ideasFavoritesEmptyMessage), findsOneWidget);
      expect(_rows, findsNothing);
      // The idea of the day and the recent row are for browsing only.
      expect(
        find.text(l10n.ideasRecentTitle),
        findsNothing,
      );

      await scope.ideaFavorites.toggle('one_color');
      await scope.ideaFavorites.toggle('neon');
      await tester.pumpAndSettle();
      expect(_key('ideas-favorites-empty'), findsNothing);
      expect(_rows, findsNWidgets(2));
      expect(_key('ideas-preset-one_color'), findsOneWidget);
      expect(_key('ideas-preset-neon'), findsOneWidget);

      // Taking the heart off removes the idea from the filter at once.
      await tester.tap(_key('ideas-heart-one_color'));
      await tester.pumpAndSettle();
      expect(_rows, findsOneWidget);

      // "All" shows the whole list again.
      await tester.tap(_key('ideas-category-all'));
      await tester.pumpAndSettle();
      expect(_rows.evaluate().length, all);
    },
  );

  testWidgets(
    'a search with no result under Favourites is not the empty state',
    (WidgetTester tester) async {
      final AppScope scope = await pumpIdeas(tester);
      await scope.ideaFavorites.toggle('one_color');
      await tester.tap(_key('ideas-category-favorites'));
      await tester.pumpAndSettle();

      await tester.enterText(_key('ideas-search'), 'zzzzzz');
      await tester.pumpAndSettle();

      expect(find.text(l10n.ideasEmptySearch), findsOneWidget);
      expect(_key('ideas-favorites-empty'), findsNothing);
    },
  );

  testWidgets(
    'opening an idea records it; Recently viewed lists the last ones',
    (WidgetTester tester) async {
      final AppScope scope = await pumpIdeas(tester);
      // Nothing was viewed yet: no row.
      expect(_key('ideas-recent'), findsNothing);

      await tester.ensureVisible(_key('ideas-preset-one_color'));
      await tester.tap(_key('ideas-preset-one_color'));
      await tester.pumpAndSettle();
      expect(scope.ideaFavorites.recent, <String>['one_color']);
      await _closeSheet(tester);

      await tester.ensureVisible(_key('ideas-preset-neon'));
      await tester.tap(_key('ideas-preset-neon'));
      await tester.pumpAndSettle();
      await _closeSheet(tester);
      expect(scope.ideaFavorites.recent, <String>['neon', 'one_color']);

      // The row shows them newest first.
      await tester.ensureVisible(_key('ideas-recent'));
      expect(
        find.text(l10n.ideasRecentTitle),
        findsOneWidget,
      );
      final double newest = tester.getTopLeft(_key('ideas-recent-neon')).dx;
      final double older = tester.getTopLeft(_key('ideas-recent-one_color')).dx;
      expect(newest, lessThan(older));

      // A card of the row opens the idea and moves it to the front.
      await tester.tap(_key('ideas-recent-one_color'));
      await tester.pumpAndSettle();
      expect(_key('ideas-detail-one_color'), findsOneWidget);
      expect(scope.ideaFavorites.recent.first, 'one_color');
      await _closeSheet(tester);

      // Filtering hides the row (it is for browsing).
      await tester.tap(_key('ideas-category-mood'));
      await tester.pumpAndSettle();
      expect(_key('ideas-recent'), findsNothing);
    },
  );

  testWidgets('the idea sheet has a heart that follows the favourites', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpIdeas(tester);

    await tester.ensureVisible(_key('ideas-preset-one_color'));
    await tester.tap(_key('ideas-preset-one_color'));
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: _key('ideas-heart-sheet-one_color'),
        matching: find.byTooltip(l10n.commonAddToFavourites),
      ),
      findsOneWidget,
    );

    await tester.tap(_key('ideas-heart-sheet-one_color'));
    await tester.pumpAndSettle();
    expect(scope.ideaFavorites.favorites, <String>{'one_color'});
    expect(
      find.descendant(
        of: _key('ideas-heart-sheet-one_color'),
        matching: find.byTooltip(l10n.commonRemoveFromFavourites),
      ),
      findsOneWidget,
    );

    // The card behind the sheet shows the heart as well.
    await _closeSheet(tester);
    expect(
      find.descendant(
        of: _key('ideas-heart-one_color'),
        matching: find.byTooltip(l10n.commonRemoveFromFavourites),
      ),
      findsOneWidget,
    );
    expect(find.byType(IdeaHeartButton), findsWidgets);
  });
}
