import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:spell_check_on_client/src/core/data/language_letters.dart';
import 'package:spell_check_on_client/src/core/spell_check.dart';

void main() {
  test('English test', () async {
    DateTime start = DateTime.now();
    String filePath = 'example/assets/en_words.txt';
    String content = await File(filePath).readAsString();
    SpellCheck spellCheck = SpellCheck.fromWordsContent(content);

    DateTime loaded = DateTime.now();

    String didYouMean = spellCheck.didYouMean('Mammalls Canp have babiis');

    DateTime checked = DateTime.now();

    int timeSpentLoading =
        loaded.millisecondsSinceEpoch - start.millisecondsSinceEpoch;

    int timeSpentChecking =
        checked.millisecondsSinceEpoch - loaded.millisecondsSinceEpoch;

    print('didYouMean: $didYouMean');
    assert(didYouMean == 'mammals can have babies');

    assert(timeSpentLoading < 200);

    assert(timeSpentChecking < 200);
  });

  test('Portuguese test', () async {
    DateTime start = DateTime.now();
    String filePath = 'example/assets/pt_words.txt';
    String content = await File(filePath).readAsString();
    SpellCheck spellCheck = SpellCheck.fromWordsContent(content,
        letters: LanguageLetters.portugueseLetters());

    DateTime loaded = DateTime.now();

    String didYouMean = spellCheck.didYouMean('Mamiferos podemm tr bébés');

    DateTime checked = DateTime.now();

    int timeSpentLoading =
        loaded.millisecondsSinceEpoch - start.millisecondsSinceEpoch;

    int timeSpentChecking =
        checked.millisecondsSinceEpoch - loaded.millisecondsSinceEpoch;

    print('didYouMean: $didYouMean');

    assert(didYouMean == 'mamíferos podem ter bébés');

    assert(timeSpentLoading < 200);

    assert(timeSpentChecking < 200);
  });
}
