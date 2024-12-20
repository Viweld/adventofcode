import 'dart:math';

import '../core/daily_challenge.dart';

/// Conditions of the puzzle [https://adventofcode.com/2024/day/4]
final class CeresSearch implements DailyChallenge {
  CeresSearch() {
    _matrixContent = _parseInitialData(initialData);
    _matrixSize = _getMatrixSize(initialData);
  }

  late Map<Point, String> _matrixContent;
  late Rectangle _matrixSize;

  /// initialize input data
  static Map<Point, String> _parseInitialData(String src) {
    Map<Point, String> matrix = Map<Point, String>();
    final linesRaw = src.split('\n');
    for (int y = 0; y < linesRaw.length; y++) {
      final line = linesRaw[y].trim();
      if (line.isEmpty) continue;
      final chars = line.split('');
      for (int x = 0; x < chars.length; x++) {
        matrix.update(
          Point(x, y),
          (_) => chars[x],
          ifAbsent: () => chars[x],
        );
      }
    }
    return matrix;
  }

  static Rectangle _getMatrixSize(String src) {
    Rectangle? size;
    final linesRaw = src.split('\n');
    for (int y = 0; y < linesRaw.length; y++) {
      final line = linesRaw[y].trim();
      if (line.isEmpty) continue;
      final chars = line.split('');
      if (size != null && size.width != chars.length) {
        throw UnsupportedError('is not rectangle');
      } else if (size != null && size.width == chars.length) continue;
      size = Rectangle(0, 0, chars.length, linesRaw.length);
    }
    return size!;
  }

  /// Solving the part one of the puzzle
  int solvePuzzlePartOne() {
    Set<Xmas> xmasSet = {};

    for (int y = 0; y < _matrixSize.height; y++) {
      for (int x = 0; x < _matrixSize.width; x++) {
        final foundXmasToUp = _matrixContent.toUp(x, y);
        if (foundXmasToUp != null) xmasSet.add(foundXmasToUp);
        final foundXmasToRightUp = _matrixContent.toRightUp(x, y);
        if (foundXmasToRightUp != null) xmasSet.add(foundXmasToRightUp);
        final foundXmasToRight = _matrixContent.toRight(x, y);
        if (foundXmasToRight != null) xmasSet.add(foundXmasToRight);
        final foundXmasToRightDown = _matrixContent.toRightDown(x, y);
        if (foundXmasToRightDown != null) xmasSet.add(foundXmasToRightDown);
        final foundXmasToDown = _matrixContent.toDown(x, y);
        if (foundXmasToDown != null) xmasSet.add(foundXmasToDown);
        final foundXmasToLeftDown = _matrixContent.toLeftDown(x, y);
        if (foundXmasToLeftDown != null) xmasSet.add(foundXmasToLeftDown);
        final foundXmasToLeft = _matrixContent.toLeft(x, y);
        if (foundXmasToLeft != null) xmasSet.add(foundXmasToLeft);
        final foundXmasToLeftUp = _matrixContent.toLeftUp(x, y);
        if (foundXmasToLeftUp != null) xmasSet.add(foundXmasToLeftUp);
      }
    }

    return xmasSet.length;
  }

  /// Solving the part two of the puzzle
  int solvePuzzlePartTwo() {
    // TODO(Vadim): #unimplemented - Not ready
    return 0;
  }
}

final class Xmas {
  Map<String, Point> _chars = {};

  static const String word = 'XMAS';

  void addChar(Point point, String char) => _chars.update(
        char,
        (_) => point,
        ifAbsent: () => point,
      );

  bool get isCorrect =>
      _chars.keys.join('') == word ||
      _chars.keys.toList().reversed.join('') == word;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is Xmas &&
        _chars.keys.every((key) => _chars[key] == other._chars[key]);
  }

  @override
  int get hashCode => Object.hashAll(_chars.entries.map((e) => e.value));
}

extension Finders on Map<Point, String> {
  Xmas? toUp(int x, int y) {
    final char = this[Point(x, y)];
    if (char == null) throw UnsupportedError('No char with x=$x, y=$y');
    if (!Xmas.word.contains(char)) return null;
    final index = Xmas.word.indexOf(char);
    final testWord = Xmas();
    for (int i = 0 - index; i < Xmas.word.length - index; i++) {
      testWord.addChar(Point(x, y - i), this[Point(x, y - i)] ?? '');
    }
    return testWord.isCorrect ? testWord : null;
  }

  Xmas? toRightUp(int x, int y) {
    final char = this[Point(x, y)];
    if (char == null) throw UnsupportedError('No char with x=$x, y=$y');
    if (!Xmas.word.contains(char)) return null;
    final index = Xmas.word.indexOf(char);
    final testWord = Xmas();
    for (int i = 0 - index; i < Xmas.word.length - index; i++) {
      testWord.addChar(Point(x + i, y - i), this[Point(x + i, y - i)] ?? '');
    }
    return testWord.isCorrect ? testWord : null;
  }

  Xmas? toRight(int x, int y) {
    final char = this[Point(x, y)];
    if (char == null) throw UnsupportedError('No char with x=$x, y=$y');
    if (!Xmas.word.contains(char)) return null;
    final index = Xmas.word.indexOf(char);
    final testWord = Xmas();
    for (int i = 0 - index; i < Xmas.word.length - index; i++) {
      testWord.addChar(Point(x + i, y), this[Point(x + i, y)] ?? '');
    }
    return testWord.isCorrect ? testWord : null;
  }

  Xmas? toRightDown(int x, int y) {
    final char = this[Point(x, y)];
    if (char == null) throw UnsupportedError('No char with x=$x, y=$y');
    if (!Xmas.word.contains(char)) return null;
    final index = Xmas.word.indexOf(char);
    final testWord = Xmas();
    for (int i = 0 - index; i < Xmas.word.length - index; i++) {
      testWord.addChar(Point(x + i, y + i), this[Point(x + i, y + i)] ?? '');
    }
    return testWord.isCorrect ? testWord : null;
  }

  Xmas? toDown(int x, int y) {
    final char = this[Point(x, y)];
    if (char == null) throw UnsupportedError('No char with x=$x, y=$y');
    if (!Xmas.word.contains(char)) return null;
    final index = Xmas.word.indexOf(char);
    final testWord = Xmas();
    for (int i = 0 - index; i < Xmas.word.length - index; i++) {
      testWord.addChar(Point(x, y + i), this[Point(x, y + i)] ?? '');
    }
    return testWord.isCorrect ? testWord : null;
  }

  Xmas? toLeftDown(int x, int y) {
    final char = this[Point(x, y)];
    if (char == null) throw UnsupportedError('No char with x=$x, y=$y');
    if (!Xmas.word.contains(char)) return null;
    final index = Xmas.word.indexOf(char);
    final testWord = Xmas();
    for (int i = 0 - index; i < Xmas.word.length - index; i++) {
      testWord.addChar(Point(x - i, y + i), this[Point(x - i, y + i)] ?? '');
    }
    return testWord.isCorrect ? testWord : null;
  }

  Xmas? toLeft(int x, int y) {
    final char = this[Point(x, y)];
    if (char == null) throw UnsupportedError('No char with x=$x, y=$y');
    if (!Xmas.word.contains(char)) return null;
    final index = Xmas.word.indexOf(char);
    final testWord = Xmas();
    for (int i = 0 - index; i < Xmas.word.length - index; i++) {
      testWord.addChar(Point(x - i, y), this[Point(x - i, y)] ?? '');
    }
    return testWord.isCorrect ? testWord : null;
  }

  Xmas? toLeftUp(int x, int y) {
    final char = this[Point(x, y)];
    if (char == null) throw UnsupportedError('No char with x=$x, y=$y');
    if (!Xmas.word.contains(char)) return null;
    final index = Xmas.word.indexOf(char);
    final testWord = Xmas();
    for (int i = 0 - index; i < Xmas.word.length - index; i++) {
      testWord.addChar(Point(x - i, y - i), this[Point(x - i, y - i)] ?? '');
    }
    return testWord.isCorrect ? testWord : null;
  }
}

const String initialData =
    '''SSSMMSAMXSSSSSSMSSSSMAMSMMSMSMXSASMMMMAMXAXMAXXSSMSSSMSMMSXMAXXMAXSAMXMXMAXXMAAMMMMMAASXMSAMXMASMMSMSMSXXMSMSXAXMSMMSXASXSMMSMMXMMMMXMXAMMSX
XAAAASMSAAAASAAASAAXSAAAMMXAAAASAMXAMMSSSSSMXSAXSAAAASMAAXASMSMAMXAMASXMMSMSMMXSMAASAMXAXXXMAMXSXMSMSASMXAAAMMMAMXAASMXSAAMASASAMSAMAMXMSAMS
MSMMMSAMMMMMMSMMMMMMSMSMSAASMXMMAMSXSAAAXAAAAMAMMMMSMMXMMSXMAAAAXMXSAAAMAXXAAAASXSMXMASMMMSSSMAXAXSAMAMAMSMSMAMSMMMMMAXMMMMXSAMAMSASMSAAMXMA
XAAMXMAMXXAAMASXXXXAXMXXAAMXSAXMAMAAMMMXMSMMMMMMXMXMASXMMXMMSMSMSMAXMAMMASMSMMXSAMMSMAAXAAAAAMSSSMMAMMMAMXAMMXMAAAAAXSMMSXMMMXMXMSAMAMMMMAXM
MXMAXMAMMMSXSASMMAMMSMSAMMMASXMSXMMSMAMSXAXXAAAAASXAXAAAASAAXXXAXMASXSXAXXAAXXAMASAAMSMSXMMSXMAMASMMMAMAMMSMMXSSMMXMXMAXSASAAAMAMMSMMMSASXSX
AAMASMSSMAMMMAMMMASAAAMAXXMAMSASAMMMMMSAMXMSSSSSSSMMMSSMMAMXMMMMMSXSAMASMMSMMMXSAMMSMXMAXXMMMMASAMXMSXSASXMAMXXAXSASMSSMXASAMASXSAAXAASAXAAX
SASAXXMAMAXAMXMXSASMSMSXMXMAMAXSAMMSSMAXXMMAAMAMXMAMMAMXMMMMSMAMAXSMAMAXXAXAXXMMASXMXMAMMMMAXSASAXXMAASAMMSAMXMMMMAXASMAMMMMSXMAMXMSMXSASAMM
XXMASMMSMASMMSMAMASAMXXMSMMSXMXMAMXAAMAMXXMXMSMMASAXXXMAMAAAASMMXMXSXMASMXMASXXSXMAMXMMSSMSAMMASMSSMAXMAMASAMMSMSMAMSMMMXMAMXAAAXAMXMASASAMX
MAMAMAAXMXSAAAMASMMAAMSAXMAXAXXSMMMSSMAMMMMAMAAXAXXSSSSMSSSSMMXXMAMMXMASAXMASAAAMMAMMSAAAMXMSMMMMAAMMMMAMXSAMAAAMXXXMASMSMMMSMMXXASXMMMXMASX
AMMAXMMMSMSMMMSASXSXMAASMMMXAMXAAAMAMXAMMASASXSMXSSMMAAXMAAAXMMSMMXAAMMXMMXAXMXMAXXAAMMSMMAXMMAAMMXMAMSSSXMASXMSMMXMSSMXAAAXSMAXSSMMMASASXMX
SMXAMSMMXAXAXXMXSASXMXMAMASMASMAXSMASMMXSASASAXAAMAAMSMMMMMMAAAMAAMMMSAMSSSSSXSXMXXMSSMMMSSSSSSSSSSMMMAMXXXXMAXAMXAMMXASXSMXMMMXMAAMSASXXAAM
MMMSMMAMMSMMMSMXMXMASMXMSAMMAMAXSMXXMAAAMAMXMMMMMMSMMXSSXMASMMXSMMSAAXMAXAAAXASASMXXMXMAAXAAAAXAAAAASMMSXSSMMSSSSSMSAMXXAXMASAMASXMMXMSXXMMM
MXAXASAMXAAAAAAXMAMMMMXXMAXMSSSXSAASMMMSSSMMSXMASXMAXAMMXMASMMMSXAXMMMSSMMMMMMMXAXSXMASMMMMMMMMMMMMXMASAMSAXSAAXXAMMMSMMMMSASASASAMSAMXMASAS
MMMSMSAMSSSMSMMSSSXSASXMMMSAMAXAMXMSMMAXAMXAXMSAAMSSMMMSASXSMSAMMMSAMXAAAXMAXXMSMMMASAMAAXSXXSXXSXXSXXMAMSAMMMXMSMMAAAXASAMXMMMXSMMXAMXAMSAS
XSASXXAMXXMXMXMMAMASXSAMAAMAMMMXMXMSAMXMAMMSSMXSMMAMAAXSASAMAMASMAMMMMSXMMSXMSAMXASXMMSSMMMMMMAMXMAMXMSMMMAMAXSAAASMSSSMSXMMSMXMMASXMMSSXMAM
AMAXAMSMMAMXMAMMAMAMXMAMMSSSSXSMSXASAMXXASAMAMMMXMAXMMMMAMXMAXMMMASMSAMAXXXMXMAXSMSSXAXMAMAAAXSXAMAMAXAXAXAAXMASMXMAAAXASMMAAXAXSAMASAMXAMMM
SMAMSMMASXMASAXSXMXSMSMMMMAAXASAAMXMAXXSMAXSAMASMMMMASAMXMASXXSASMSXMASMMMMAXSXMXXSXMSMSMSSMSAMXXSASMSASMSSMSAMAMMSMXXMSMAMMSSSXMXXAMAXSMMMS
XMAXXASAMXSXXAMSXSAAMAMAAMSMMMMMMXXSXMMXAMXSASMSAASXMMXSAMXXMASASMXAMAMAMSASMXXAXMXXAAXAAMAAAMSAMSAXXMAMAAAAXXXAXASASMSXSXMSMMMAMXMMSXMMXAAA
SMSMSMMAXMXSMSXSAMXMMAXSXXAMMMAMXSAMMSXXSXASXMXSMMMAAAMSAMXMXMMAMAMSMMXAMXXXAAXSXASXSSSMSMMSMXMAMMXMSSMMMMMMMSSSMMSAMSAAMSMAASXXMASAAMSSSMSM
AAAXAXSMMSAMXXAMXMAMXMMMXSASMSMXMMXSASAMXMASXMASMMSSMMASXSAXSAMXMAMXAMSSSMXSXMAMXSMAAXAAXMAMXXSSMMXMAAAXSAMAXMAMAMMAMXMXMASXSMAXMAMMXMMAMAAX
MSMSXMSXAMAMAMMXAMASAMAMXXAMMAMXMMMMASASXMAMAMASAMXMASXMASAMXAMXMXXXAMAMAMASMSAAMXMMMMMMMMMSMXAAXAXMAXMMSASMMAMSSMMXMAMASXSMXXMMMSXSAAAMMMMS
XMXMXMXMXMMMXSMSXXASMXAMSMSMSXSAAAXMMMAMXAASXMMSMMAMMSAXAMMMXSMMXSMSSMMSAMMSASASASXXXXAXAAMAMSSMMSXMMSSXSAMXAAMMAXAXSXSMXASAXXXXMXAMXSMXMSAM
XAAMAMAASMSSMAMASMAMXSSSMAXAXAXXXMXMSMXMXSMSXSAMASXMASAMXXMSMXAMAMXMXAXXXXXMXMXMXMMMSSMMSSSMMXAXAMASAAXMMMMMSMSSMMMXSASXMAMMMSSMSMSMAXAXXMAS
SSXMASXSAMXAXMMAXMASMMMAMXMMMMMSMMXSAMMSAXAMMMAMASMMASAMXSMXASAMASMSMSMSASXSAMAMXSAAAAAMAAMXXSXMASAMMSMMSSMMAMAAMAMAMXMXMXXAAAAAAAAMMSAMXSAM
XAXSAMXXXSSSMXMSSMSAASMSMXMMASASAAMSASAXASAMXSXMASASMMAAAAXMMMASAXXAAAXSAMXSASMSMSMSSSMMMSMMXMASMMXSXXAAAAASAMMSMMMASMMXMXSMMSSMMSMSXSAMAMAS
MAMMSAMXAAAAMXAXXMXMMMXMXAMSMSASMMMSAMMSASXMASXMAMAMXSMMASAMXMMXAXXMMMXMXMMSMMAAMXMXMAMXAAAAAMMMAAAMAMMMMXMMASXMAXSAMXSASXXSAMAAAXXXASAMXSAM
MMMMMXXMAXXAMSAMXXXXASAMMXXAAMAMAXAMXAMMMMAMASMMSMMAMMASAAMMASXMSMXXASAMAMXXMASXMASAMAMSXSMSMSAMMMSSMXSXSXMMMMAMAMAAAMXAMMXMSSMMSXSMMMXSMMAS
SASASMXMASMSMXMXMMMSMXASAMSMMMSSSMXSMXSAMXMMXXAAMXSMASAMXMXSASAAAAAXMSASXXAAMAXMSXSMSAXSAXAMXSXSXAMAMSMASAMSSMMMMMSXMXMSMMSMASXAMMMAMXAXAXXM
MAMASAAMAXAAXAXAMXXXSMSMXXAXAXMAMAXXAMSMMSXSMSMMSXXAMMMSASXMMSMSMXSAMXXMAXSMMASAMXMAMXSMAMAMAXAXMXSAMAXAMAMAAAXSAMXXMMMMAAXMASMXMASAMMSSMSSS
MAMAMMXMSSSMMMSMSMAAMXXSXSASXSMMMSSMSMMAXXAAAAMAXMMSMAMMMAMXAXMMXAAAMMAMXAXASASMSAMAMXSMAMXMMMXMMXXAXMAXSXMXSMMXAXXXXAASMMSMASAMSAXAXAMXXAAA
SMMSAMXSAAAXSXAAMXMXMAMAXMAAAMMXAXMAAMSSMMSMSMMMMAAASXMASMAMMSASMSSMMMMMMASAMXSASXSASAMXAXSAMXMASMSXMXSXSASXAASMMMSMXXMXXAXMAXMMMMMSMMXSMMSM
AAAMAMSMMXMAAXMXMAMAMASMSXSMSMAMXSSSXMAAAAAAAMASMMSMSXSXXXSMXAAMXMXMAMSAMXMXSMMMMASAMMSSMSMMSMSASXSAMXXAMAXSAMXAAAAMMSSMMSXMASXMASAXAXSAAXMM
MMMSSMSASXSAMXSASASASASXAAMXXMAMXMAAMMSSSMMSMMASAAXMXMMSMSMSSMXMXXAMMSSXXMSAMXAAMMMAMXXXMAMAAAMASAMAMASAMAMXXSSSMSXSAAAMAAXMXAXSAXMSSMMSMMSX
MXMXAAXAMAXSXXSASASMSXSMMSMAMMSMXMASMXXMMAMXXMMSMMMMSAAAMSXAMMMSXSMSXMXSAAMASMSSMMSAMXMXSASMMMMMMMSXMASXMASMMAMAAXAMMSSMMSAMXSMMSXMAAAAXXASM
SAMSMMMSSMSAMAMMMASASAMXAXXXXAAAXASMMXMAMSAMXSAMXMAXMMMSSMMXSXAMAXMAMMAXMXMAMMAXAXAAXSAMSASAMXSXAXAXMXMXMAAMMASMMMXMMAXMXXAMAAAAAXMASMMMMSSM
SAMXMXAAAXMAMSXSXXSAMMMMXSASMSMSSMMMMAMXAMMSMMASMSMSAAXMAMASXMAMSASMMMAMXMMXMMAMXMSAMASAMMMXXAXAXMMXSAMMMMMXSASAAXSAMXSMASAMSSMMSSSMMAXSXAXA
SMMAAMMSSMSAMXAAXMMAMMAMAMAMAXXAAMAAXAXMASAMASXMAXMAXMXMAMXXSAAAMXMAMXAXXSMMXMXXAMXSMSMMMASAMSSMMMXMSMMAXASXXAXXMMXMASXMXSAMMAMAXMXAMMMAMMSM
XASMMMAXAMSASMMMMXSSMSASAMAMAMMSSMSXSAASAMXSMXAMSAMXASXSASXMASMXXXMAMXSSMXAMSMMSASAXXXAXSMSMXXAMMXAXMXSXSASAMSSMMSMMMMMSMSAMMAMSSMSSMMMMSMAM
SMXAAMMSMASXMXMASMMMAXASASMMASXXMAXAAMMMASAAXXMMAAMAMAMSAXASXXMSSXSASXMAMMAMMAMXAXXMSMMMAMSXXMAMXSMSSXAAMXMAMAAMSAMXAAMSASXMXXMXAAAAXXAXMASX
AXSSMSMAXAMASMMAXAASXMXMMMXSAMXXMAMMMMXSAMASXMXSMXMMSMMMSMAXAAXAAASAMXXAMMAXMAMMXMAMSAASAMSASMMMMXAAMMMMMAMAMMXMSAMXXXXMXMASXMMSMMMXMSMMSAMX
MMXAAXMMMASAMAMSSSMSAMXAXAXMASXXMAMXAXMAMXMMMAAXXAXXMXSAMMAMXSMMSMMASXSXMXMSSXXAAMAMMSMXMSMAMMXSMXMAMXAAXMSSMXSASAMSXSAAMMAMASMMXSXAASAMSAMS
MMAMMMMXSAMAMSAMAMXSMMSXMMMSAMXMASXSASMAMSXAAMSMSMSSXAMSMMMSMAXMAXMAXMAXSAMXMMMSMSAMMAMSXAMAMSMSMASXMSMSXMAXAAAMMAMAASXMMMAXSMAMASXMSMAMMAMM
SMSMAXMAMASXMMAMXMASMASXXAAMASAMXXMASMMAMAMXXSAMXAAXMXMAXMAAXSMSASXSSXSASASXXAXAASAMSAMASXSASXAMSASAAXAAXMASMXMXXSMMMMMXSSSSXSSMAMXMAMAMSMMX
AAAXXXMXSMMMSSXMAXMXMASXSMSSXMASMXXXAXMXXAAMXXMASMSMSASXSMSSXMAMMSAAAAXXSMMXSMSMMMAMSASMSXXXMMSMMXMMMMXMSMASXMXSAMASXMMAAXMAMAMMMXAMSSMMAMMX
MSMXMSMXSAASMMMXXXXXMMSAMAMXMXMAMMSMSMSSSMSAMXXAMXXASASXAAAMAMAMAMMXMMMMMXAMXAAAASAMXAMXMMMMSAMAMSSSMMAXAMMSMAMMMXAMAAMMMSMMMSMAAXSMMAXSAXSA
MAAASAMXSMMSAMMMSAMXMAMAMXMASASAXMAAAAAAAXXMAXMMSAMMMMXXAMXSMSAMXSXSMMAAAMXXXMMSMSMMMXMAXXXAAXSAMMAAXSXSXSXMASXAMMASMMMMSMASAMMASAXASAMSMMAX
MMSMSASAXXXSAMAAAASXMASAMAMAXAXAMSMSMSMMMMSXSMSAMMSXSXMSMSXSXSAMXAAXASMSSSSXASAMXMMSMSMSSXMASMSMMMMMMAAMAXAMSASAMAASXMAMASAMXSXXMAMAMMXXXAMX
MXAXSAMXMAMXAMMMMXMMSMSASXSSSSMSAMAMAXXMSASXXAMASXXAXMAAAXAXXXAMSSSMAMAAAAXSAMXMAMAAAAAMMAMAXXXAMMAAMMXMASXMMMXSMSXMMSMSAMXXAMMAMAMXMXMAMSXM
XSAMMXMASXXSAMXXMMSAXASMMMAXAXAXMMAXXXAXMASAMMMMXMMSMASMSMXMMMAMXAAMAMMMMMMSXMSXSXSXSMSMSMMMSMSSMSSSSXMMAMAAAXXXXMAAMAMXXMASAAAASAMASAMAMAAS
MSXMAXXXXMAMAMXSAAXMMMMMAMXMMMSMXSSSSMSMMXMXMMAMAMAXAMXAAASMSAMSMMMXMXAAAXXMAASAXAMXAAXAAXMXAXMAAAAAMMAMXSSSMSSMASXMMASXMAXASXSMSASASXMAXSAM
ASAMXMSAMAXMSMASMSMXAAAMXSMSXAAMXMAAXAXXSAMXXXAXSMMSSSMXMXAAXXSAAAAASMSMSASXMMMAMAMSMMMSMSXSXSSMMMSMAMSMMAAAXXASXMMMSAMAAMSMMMAXSXMXSAXMXXAX
SMAMAMSASXSAXMXMMXMXSSSSXXAXMXSMAMMMMXMAXASXXSSSXAXAAAAASAMXMSMMSMSXSAAXMASXAAXAMAMASMAAAMAXAMAMXAXAMXAAAMXMMSMMMMAMMMSSMMXAASAMXXMMXMASMSXM
ASMMXMSAMAMASXMXSMSXAAXAMMXMAAAMSMXMASMSSMMXXMMAMSMMMMSASAXAXSAAMMMMMMMMMXSMSMSXSXSASMSMMMAMMMAAMMSAMSMSXSAAAXXMASASAMXMMAXXMMXMAXSAAXXMASXM
MAXXSAMXMXMAMMAXXAMMMMMAXXMASMSMMAXSSXXAAAMMMMMXMXAAXXAAMAMXMMMMSXAAAAAXXXSAXXMXXMMXMMASAMMXSAMXSAMAMSAAAMXMMSMSASMSASAMXMSSMSASAMXSMSAMAMAM
XXMXMAXSAMMSSXSXMSMSMSSXXSMXMAMAXSMMXSMSMMMAAXSSMXSMSMSSSMSXMAMASXSSSMSASXMMMAXMMMMSMSASMSASMMMXMASXMMMMSMSMAAMMMSMMXSXMXXAAASXMAAAMXSAMSSXM
XMXAXSMMSAMXMAAMAAAAAMAMMASAMXMMMMAXXMXXASXSMSAXMAXXXAAXAAAASMSMSAMAMXMMSAAASAAASAAAXMASAMMMAAXAMXAMAASXMMSMSSSMASAMASMSMSMMMMASAMXMAMXMAAAM
ASMMMAXXAMMAMXMSSMSMSMAMMAMXMXAXASMMSSMSMMAAXMMMMMSMMMMSMMMAMAAASXMAAXMASMMMSMMMMMMXMMXMXMXXSMSXSXMXSMSXMASAAMAMAXAMAMXAAAXSAMXSMMAMASAMXXXM
XMAMSMMMMMSXSXXXAAAXAMXMASXMMSMSMSMAAAAAAMMMMSXSXAAAASAXXXSXMSMMMASXSAXASASASMSASMSSMMMMAMAXMAMASMXMMSXXMMMMMSSMMXSMSSSMSMSSXMASASMSMSASMSMS
MMMMAAAAXASASAAXMASXXXASXMAAMAAAASMMSMXAMAMXAAAXMSSSMSMSSXMAAXAAXXMAXAMASMMASASXSAAXAAAMMMMXMAMXMASASAMXSAMXAAMASMAAAXAAAXMXAMASXMASASASXAAA
AAASMSMSMASAMMSXXXMAMMAMAXMMSMSMSMAMMMMMSAXSAMXMXMAMAXMAXAMSMSXMSXMXMASASXMMMAMAMMMMSSSXASXMSAMXXXMXSAMSAMXMMMMAMMMMMSSSMSMSSMMSAXAMXMAMMMSM
MSXSAXMXXAMAMXMAMMSXMASMXMXAXAXMAMAMXSAMMMMAMXMMASAMXMMSSMMAAAMXXMASMMMASXAAMAMAMAAMAXXXAMAASASMSMMXSAMXMASMAAMMMMASXAAAXXAAAAASMMXSXMMMAMAM
MXAMXMSMMXMXMAMAMAAAAAXAXXMSMMMSXSXSAMMSSXSAMXMXASASMXMMAXSMMMMSAXAAMXMAMMSASXSMSXSMASMMSMMMMASAAAXMXXMAXXXMMMSAASASMMSMASMXSMMMXSASAMXXXSAM
XMAMAMXAXMSASAMAMXXSMMMASXAMAXXAMXXMAMXXAXSXSMXMASMMAAXMMMXAAAASXMMXMAXXXMMXMXXAXXMAMMAAXMAXMAXMSSMASMMXSMXXMAXXMMASXAMXMXAXMMSMAMAMAMAAXMXS
SSMMAAXSAAAXMAASMSMXASXAAMXMAMMASXMMSXXMAAMMSMXAXXASXMSAASXSMMMSAXAASXSSMXMASAMXMMSASXMMSSSXMASMMMXSXAAMMMSASMSXXMAMMMSSXMSMSAAMXMAMXMMSXAAX
XAASMSMXASMSMXMAAAAMAMMXMSAMXMSAMAMAMMXMSMMASAMMMSAMAAXXASAMMXXSAMMXMAAXAAXXMAMXAAXXXAMXXAMMMMXMAMXXSMMSAXXAMAAMSMSAMXAXXAXAMSMMAMAXAAMAMXMX
XSMMSAMXXXXAAAMMSMMMAMASXSASXXMAMXMAXAAXAAMXSAMAXMMMMMMMMMXMSMMSAMXSMMMMSXSAAAMMSSMSSXMMMMMMAMASMSAMASMMMSMSMMMSAAAMMMAXSMMSMMMSMSASXSMSAMXM
MAMXMMSMMMSMSXXMAMXSXSAMMMMMXMASMMSSSMMXSXMAXAMXMAAXASMXSAAMAAASAMAMAXSXAXMMMMMAMAXMAMXAXSASASMSXMASAMSAMXAAMMMXMSMSMMSXAMAMASAAXMASAAAAMXAA
AMMSSMAAAAAXMXXSMXXAMMASMMAXXXAMXMAXXASAXASMMMMXSSMSASAAMSSSMMMSSMAMAMSMMSSMASMMSSMXMMMSMAASASAMXMMMXSMMMMSMSSXMAXAXXAMSSMASXMMSSMMMXMMMSSSS
XAAXASXMMSASMXMMSMMMMSMMASASXMSSSMSSMMMAMAAXAAXXMAAXAMMMMAMXXMAMAMSSSXXAMAAMASXMAXMAAAAMAMAMAMMMXSAMXMASXAAASASAAXMXMAXMMXAMMXAAAAXAAXMAMAXA
MMSXMMMXMMMMMAMAAXAMAMASMMXXAAAAAAAAXSMSMSMSSMSMSMMMMXMSMSSSSMMSMMMAMMSSMMXMMSAMASXSSMSSSMXMXMAAXXASASMMMSSMMAMMMMMASXSASMXSAMMXSMMSMXMAMSMM
MAXAXSMMAAAASXMSXSMSASMXAXXXMMMXMMMXMAAMAMMXMXAMAMMSMAAAAMAMXAMXMXMAMXMASAMXMSMMAXXAXAXAXXMASXMSMSAMAXSAAAAAMAMASASASMSAMAAAMXXMAMXMAMSAMXSX
MASMMAAAMSXMMAMXASASASXSSSSXSASASASXAMXMASXAXMASMSAAMXXMXMAMSMMMMMXSMASAMXSAAXMASXMMMMMMMXMMXASAAMMMXXSMMSMMSSMXSASASAMMMMMSMMSAMXAMAMMASXMS
MASMSSSMXMMSSXMMXMAMAMMAAAAASASMSAMSSXXSSMMMSAXSAMXSXMMSASAMAAAMASMMMAMASASMSMSMXMASASAMAMSASMMMXMSMSASMAXMMMXSXMAMMMMMAMAMXAMMMMMMSMMSMMASX
MAMXAAXMAXAXMMMXXMAMMMMMMMMMMMXXMXMSXMAMAXASAMSMAMMMXXASAMASMSXSASAAMMSXMAXAAAAXAAXXAXASAAMASXAXSMAAMAMMAMAAMMASMXMAMASASASXSMAAXAMAMMAXSXMX
ASAMMSMMMSMSAAAAXXXXXXMASAXXXXAMAAXMAXSSSMMSAMXMAMAAMMAMMSMMMAXMASXMSXMMMAMSMSMMMXSXMSAMXMMAMMAMAMMSMAMMAMSMSSMXMASASASASASAMSSSSMSASXMMSXSX
MMAMXXMAMAASMMSSMMSMSSSXSASMMMMASMMMAMMAMMAMMMXSSSMAXXXAMAXAMXMMMMAXSAMXMAXAAXAMSAAAMXXMMSMAXXXXXXXMXXXMSMXAAMXMAMSMXXMXMXMAMAMAMASXMASMSASM
XXMMXXSASMXMXMAMAAAAAXXXSAXAXAAXMXSMMXMAMMAMAMAMXAMAMSXXSMSXSSSSXSXMXAMSXSMMMMAAXAMSMAAMASMSSMSSXMSSMMSMMAMMMXAMAMXMMMSXMXMSMSMSMMMSMXMAMAMA
AASAMXSASXMSXMASMMMMMXMAMAMSSMSMSASASXMMXSMSSXAASMMSMMAMAXAASXXSAAXMSSMMAMXMXSMMXSXXMXMMASMAAAASAMXAAAAAMSMSMSXSASXSAAAMSAXMAMXMAMASXAMAMMMS
SMSAMXMAMXXASMAMAXMASXSAMSMXAMAAMASAMAXMMXMAAMSMMXAMASXMAMMXMAAMMMSXSXAMAMAMAXAXAXXSMSSMASMSXMASXSSSMMSAMXMAAAMSAMXSMSSXSASMAMMSAMAXAASASAAM
XXXAMXMAMAMMXXXXXMMAXMXAXMMXMAMMMAMASAMXAXMXMAXSMMMSMMAASMMAMMMMAXSXXSMMMXAMSSMMMSASAASAMXXMAMAMMXAXMMMXMASMXMXMMMMMMMMMSXMMASXSAMXSMXSASMSS
SSSSMAMASMAXASAXSAMASMMXMAXMXXXXSSSMMMSMMSSMXAXAXMAAAXXMXAMAXAASMSSMXXSASMMAXMXSAAAMMMSXSSMSSMAXAMMMMAMAMAMAASASASMSMSAAXMASXMASMMMSXAMMMMAM
AAAXSXSAMXXMAXAASAMXSXAXSXMXAMXXXAAAXAAAXAAAMSSMXMSSXMXXXSSMSSMXSAXAMMSXSAMSXXASXMAMXAMAMAXAXXMMSMSAMAMMMSMXMXAXAMAAAXMMSXAAASMMAMAMMXMAAMAS
MMMMXXMASMXSMMXMSAMXXMXMXAAMMASMSSMMMSSSMXSSMMAXXMAMXASXAXAAAMASMSMSAASXSXMXSMMXXXAMAAMAMMMMSAMXAASMSMSMXXAASMSMSMMMMMMAMMMSMMASMMAMASASXMAS
AXAMMXMAMMASASMXSAAXXMSASMSXSASAAXAAXXAAXAMXASXMSMAMMMAMXXMMMSSMAAMAMMSMMMSMAMAMMSMSSXSASXAAAXMMMXMAAAAXAMMMMAXAXAXSASMASAXAASAMXXAMMXMMSMAS
XSMSMAMSXMMSAMAAMSXXXXAXSAAAMAMMMSSMSMSMMSSSMMSAAMSSSMSAASMXAXAMAMXAXMSAMAAAAMASMAMAXXSAXAMXSMSASAMSMSMMSXSAMAMMMMMMAXMMMXSSXMMMXSMMMAMAMMXM
XSAAAMXAAMAMXMMMMXMMMSMSMXMXMXMXAXAAXXXAAXAAMAXXMSXAMAMSMAAMSSMMMXXXSMXAMSSSXSAAXAMMMXMMMSMMXMMAXXXAMXXAAAXMAMAMAAAMXMAAMXMXMASAAAAXSSMSXMAM
SMSMSXMSXSAXMAMMMMMAAMMAMAXMAMXMASMMMXXMAMMMMMSMXMMMMXMAMMXMAAASXXSAMXSMMAMMXXMXSMSXSAMXAXASXSMAMSSSSXMAMSSMSXSXSSSXMXXASXMASXMMMSSMAXSXASMS
AMAMXAMAAXMMMSMMAASMSSSXSASAXAMXAXAAXMAMXSXAXAAMAMXSAAMMMXMMMSMMAAMAMAAAMAXXAXMASAAAMAMMMXXMAASAMXAMMMMSMAAAMAMAAMAASMSMMXSXMMMXXAAMAMMSAMXM
AMAMMAMMSMAXMAASMMSXXAMASASMSSMMSMSMSXXXMAXMMSMSMSMSSSSMMAMXMAMMXMAXMMSSMSMMMSMAMMMMMASAXAAMMMXSAMXMMAAAMMMMMAMMMMSMMAAAXASMSAMAMMMSAMXMMMAS
SSSSSSMAMMMSMSMMASMMSAMXMAMXMAAXMAXAMXSXMAXSAMXSAAAMAMXAXMSMMMSMMSMXSXAMAXMAXXMXSSXSSXSAXSSMXMAXSAMXSMSXSAMXMXMASXMMXSSSMASASMSAAXXAMAAMASAX
AAAAAASXMAAAXXAMMMMAXAMXMXMSSSMMMXMAMAMAMAMSASAMMMSMMMSSMSAXAXXAAAMAXMMMAMSSSMSMXMAMMXMAMXAAXMAXAMMAMXMAMAMAMXMAMAAMMMAXMAMXMAXXMMAAXSMSASXS
MMMMSMMXSMXMSXXXAAMMSXMAMAMXAMMAXSSXMXMAMXMMAMMMAAXXAAMAXSASXSMMXSMSXSXMMMAMAMXMAMAMSXSAAMMMMMSSMSMASAMAMASMSAMMMXMMAMMMMXSXMAMMSMXSAXAMMMMA
XAAMXMMXMASXMMMSMSSMAASASMXMAMXSAXAAMSMMSXXAAMAMMSSSMMSMMMAMAMXSMMAXASXMXMXMXXASMSXMXASXSXSAMXXAAAMXMASXSXMASMSMASMSSSMAAXXMMMSAAAAMASMMMMAM
SSSMAASAMAMAAAAXAAAMAMSAMAASAMAMMAMSMSAXAMXSSSXSXAXXAAAAAMAMXXAXAMAMXMAMSMSMSSXSMAMSMXMAMXSMSAMMXMSXXXMAMXMAMAXMAMAAAMXMSMMAAAMMMMMMAMXAAXSA
AMAMSMSASMSXMMSMASMMMXMAMSMXAMXASMXAASMMASMAMXMAXASMMSSSXSXSXSXSAMXSXMAMAAAAMAMXMSXAAXSAMXXAAXAXAXMMSAMAMXMXSMSMMSMXMAAMAAAMMXSAMAMMMMMXMAAX
MSAMMXSXMXSAXXXAXXMASMSAMASMSMSAMAXMMSXAAMMAMAXMXXXAAMXXMMAMAAAXMMAAMMXMMXMMMMAXSAXXSAMXMMMXMAMSXSAASASXSAMMAXXAXSXSXMASMMSASASXSASAMMSMXMXM
XMXMAXMAMAMAMASMSASMMXSASAXXAASASMXXAXAMXSXMSXSASMSSSSSMSMAMMMMMMMXSXASMMMXXAXXMAMASMMMAAAXMXSAAMMMMSAMMSASAMSMAMXAMXMASXAXAMASMSASMSAAAAMAM
SMSSMMSSMMSMMXAAMAMAAASXMXSSMMMAAXSMMSXMAXAMAMXAAAAAMXAAXMAMAAXAASAXMAXAASMSSSMMMXXXAASXSSMSAXMMMAMXMAAXSMMMAAAAXMXMAMSMMSMXMAMAMAMAMXMXXXAM
AAAAAMAMXMAAXXMAMSMXMASXSSMAASMMMXMAMXAMSXMMAAMXMSMXMXMMMMSXSSMXAMXSXAMXMMAAAMAAXXMSMMSXXXAMXXMXMASXSSMMSAMXSXSMSMMXAXAAXAASMSSXMAMXMSSMSSSS
MMMXSMSSSSMSSSXAAAMXSXMASAMAMMXMSMSXMXSXAASASXSXXXMASMXSXAMXMXMMAXXAMXMMAMMMXMSMSMAMMASMMMMMXASAMMSMMAXAMAMMMXMMXMASXSMAMMSMAAMMSSSMXAAXMAXA
XASAMMXMAAAMXMASMMSAAAMXSAMSXSXMAASMMMXMSMMAMASMXAXAMAAMMMSASAXMMMMMSAAXXMSSMXAAAMAMMASMSAAMMMSASASASMMXMMMAXAAAASMXMAXMXXAMXMAAAAAAMSSXMMMX
MSMASAXMSMMMAMAXSXMASXMMMXMXASMSMSMAAAXAAXMAMMMAXMMSMMAMAXSAMSMMAAXXAAMSAMAAXXXSMSMSMMSASXSSSXSAMXSAMXSXASMMSMMSMSAXSMMASMMMAXMMMSMMMAMXMXMX
SAMXMMMMAMMSMMSMAMSXMMXMASMMAMAXXAMSXSSSMSMXXMASXMAMASAMXMMXMAMXSMSAASMAMMSMMMMAAAMMAMMAMAMAXAMXMXMAXAMSXMAXAAAXMMXMAAAAXAASXSMSAMMXASXMASMS
SXSASAAMASAXXAXAMAXASAXMAMXMAMSMSMAXMAMAXSAXXSAMXMASXXAMXXXAMASXMASMMMMXMXMAAAAMMMMSAMMMMMMAMMMAMXSAMMXMSSXMSMMXSAMMSMMMSSMSAAXMAXAMXMAXAAXA
SASASXSSXSAMMMMSXSMXMASMSSMMAXMAMXAMASXMMMMSMMASMAAXAMASXMSXSASAMMMXAXXMMASXMMSXAAXMSMXMAMSXSAXAMMASMXASAMSAMAMAMASXMAAAMAAMMMMMAMMSAXXMXMAM
MAMAMMMAXMXXAASXXXAAXAMXMAMSSSMXAMXSXXAXMAAAXSAMXAMXMXAMAMAMMMSMMAAMSSMASASAMXXMMSMMXXXMAMXASASXMMAXMXXMAXXMSAMXSAMASMMSSMMMXMAMSSMAMAMSSSMX
MXMXMAMMMMASMXXSAXSMSAMMMAMMMAMSMSASMSXMSMSXXAMXAXSXSMMXAMASAMMMSMSMAAXAMASXXXMASAAMMMMSMSMMMMMMAMSMMXSSSMMMSXMXMAMXMAAAAASXMAMAMAXMAXMAAAXM
MSSSXXXXAXAXXXMMSMAXSAASMSSSMAMAAMAMXSAAXXAMSSMMSXMASXSSXSXSMSAMMAMMMMSXSMMXSAMXMSSMAAAAAXAAASMMSMAASXMAXAMAMXMAXAXSMMMMSMMMSSMSSSMXMXSMSMMA
MMAAASMSXSMSMSMAMSMMMAMXAAXMXMMMMMAMMMMSSMXXAAAAXAMAMAAMAMAMMSASMAMXXAMXXAXMMMSXMAMXSMSMSMSMMMAAMSSSMAMAMXMAXAAMXMXMAAAXMMAAAXAAAMAAMAMXAMXS
MMMMMMAAASXAAAMAMAMAMAMMMMXSASXSAMASAAAAMAMMSSMMSXMSMSMXAMAMXMXMXXSXMASMSSMSAAXXMAXXMMXAMAMMSSMMMXMAXSMMSASAMSXSASXSAMSSSSSSMMSMXMSAMMSXMSAM
SSSSSMXMMMAMSMSMMASASMSXMAMSAXASAXAXMMMXMAXXAXAXAAXXAAASXSMSXMASMXMASXAAAXASMSSMSMSMSMMXMAMXAAMAMMSSMXMASAMAXMASMXAASXMAAAAMXAXMAXMAMASAMXAM
AAAAXSSMMAXMXMAXMASMSMSAMAXMXMXMMMSSMXSASXSSMSMMSSMMMMXMXAXAXSASMAAAXMASMMXMAXMAAXAAAMSMSSSSMSMAMMAMXXMASAMMMMAMXMMMMMMMMMMMMASXXSSXMASAMMSS
MMMMMMSAASMMXMAMXAMXSXSASMSSMMSASXAAMASASXAAMXMAMMMSAMAMSSMSMMXSXXSAMAMXXMMMMXMSMSMSMSAAXMAXAXXXXMASXMMAMXMXSMMMSMXAXAMMSXMMMSSMXXXAMAXAMXAX
XSXSASMSMXAXMMASMAMXSASMMAAXAXSAMMXSMASMMMSMMXMMXAASMSMXAXAXSMAMAXMXASXMXXAAMMMAASAMXMMSMMSMMMAMSMMSAMXMSAMAMAAAMAMXMASAMAMXMAMXMXSSMASMMMMS
XAASMSAXXMXMMMASXSMMMXMAMMMMMMMMMMXMMXXAMXMAMSSSSMMSMAMMMMMMAMXSXSASXXASMSSXSAXMSMAMXSAMAAAASMSMXAASAMAMSXMAXSMSMSSSMAMMSMMAMMSASMAAAAXAAAAX
XMMMMMAMMSMMXMAXAMMXXASMSAAXAAXAAMXMASXSMASAAMAAXSAXMAMAXAMSMXMAMMAMMXAXAAXMXXMXXXXMMMASMXSMMXMASMMSMMSMMMSXMXMXAMAXMAMXAASASXSASMSMMMMXMMMX
MXAAAMAMAAASXSSMAMMSSMMXSXSSSSXSSSMXMAAXSXSMXMMMMMSSSSSSXMXMXSXXXMAMASMMSMXXXASMASMAXMMMMAMAMXMMMAAMMAXAXAAMSMSMAMMMMASMSXSASXMXMXXXXMAMSSSM
ASMSMSSMXMMMAAASXMSAXAAMXAMMAAAXAMMASMMMSMXMSAAMMAXMMXXAASMMASAMMXMMXXXAAAMSMMAMAMXAMXMAMAXMMXSSSXMSMMSSMMXMAAASAMXAMMAMXAMXMASASMAMSMMSAAMA
MSAMAXMASXXMMMMSMMMASMMSMSMAMMMMAMSASXMAXMASMSSSMSSMSMMSMMAMASAMAASMSXMMMXMAASXMASXXAMSAMXSXMAMXMMXXAMXAMXASMSMSMMMXSMAAMXMASAMMAMAAMAMMMMMX
MMAMMMMMMMAAAMXXAMMMMXAXAMAAMXXMXMMASAMMSSXSXAXXXMAAXXAAMSAMMMMMSASAMXMASASMXMMMXSAMAXMXMXAXMXSAMSMSXMXXMSXSAMXSAMXAMMMMMSSMMASMSSMSMMMAXXXX
XSAMXSXSASXSMSXSAMXSSMMMMMMMSXAMMXMASAMAMMMMMMMSMSMMMMSMXAASMMXAMXXAAXAXSASMSAMSAMXSMSMMMSMXXAMXSAAMMSAMXSXMASASASMXSAMAXAAXSAMMMAMMAMMSSMAS
XSAXAXMMASMAAXASXXMASMXAXAAXXXAMXXSXSMMMSAAAAAAAAXAMXXAMAMXAAXMXSAMXSSMMMMMMSAMAAXAXAAAAAAXMMXMMSMSMAAXAXSAXAMASAMXAMASXXMSMMMSMXAMSAMMXAMXA
ASAMSSMMMMMMMMMXMXMAMXSXSSSSMSSMMASAMXSASMSMXMXMMMMSMSMSMXMSXMMASAMAAAAMSXMXSAMSSMSSSSSMMSASXMSAXAMMMMXSXSXMASAMXMAMSMMXSXXMXXMAXSMSMSXMAMXX
MMAMMAXSSXMXSXMAMAMASMSAAAAAXAAASAMAMAMASMMMSSMSMMMAMXMAMAXXAMMASAMSSSMMSAMXMAMXXMMAMXAXXMAMAAMAMXMSAAMXMXMAXMASXSXMAAXAAAMAMMMAMXAMAAXSSMMS
XSAMSMMMAASAMAMSSMSXSAMMMMMMMSSMMMSAMASXMASAMXAAASXSMMSASXMSAMAMMXMAAAXASAMXMXMSXSMAMSMMXMAMMMMASXASMMAMMSXMASXMMMASMSMXMAMAAAMSSMAMMMMAAMAM
MSAXAXAMSMMASAMMAXXMMXXMASXXAXXXXMSMMXSMMXMAMMMMSMAMMASXSAAXMMSSMMMMSMMXMAMSMSAMAASAMAAAASXSMMAAAMAMAMSAAMMSAMMMMSAMAMMMMXSXSSXMAMXMMMMMSMMS
XSXSSSXMMMSMMXMSAMXXAAXMSMSMXSAMXMMMSMMASAXAMXXSXMAMMASXSMMMSAAAMXSMAMSMSMMAAMXMAMSMSSSSMSMSAAMASMASXMXMXXAAMAAAAMASAMSAMXAAXMASMMMXSXSAAASX
AMAMAXMASAXAAAXAAMMMMXMXAAXMASAMMXAAAMXMSXMMXAXMAXSXMASXSASAMMSMMAXSAXXAAXMMMMMXMMXMAMXMASASMMMXXXASXMSASMSMSSSSXMAMAXSSSXMAXAXASAAASAMXSXMX
MMAMMMXXMXSMMMSSMMAAXXSMMSMMXSXMMXMSSSSXSMASMXMASXMAMXSAMAMSSMXAMXXMMSMSMSMSSXXXMASMMSSMAMXMASXXMMMSAXMAMMXXXMAMXMSSMMXAXXXMASMMSMMSMAMAMMMM
AXASXXMMMASXAXMAASXMSMSAAXXMMSMSSMMXAAAAXAXMASAXMASAMSMXMSMMSAXAMXXAASXMASAAMSMXMAXMAAXMAXMSMMMMMAMMMMMMMASMSXSASMAAASMMSMMMAXAAMMMXMAMXXAAA
MSMSMSAAXAMMMMMSMMAAXAMXMXAMAMAXMASXMMMSMMSAMMSMXMMAMXAMMMAMXMSSMASMMSAMAMMMMAMAXMXMMSSSMXMXXAAAXSMMXSAAXMMAAAXASMMSMMAAAAAMMSMMMAXMSSSMSSMS
XAAMAMMXMMSASMXMXSMMMSMSSSSMSSSMSAMAASAMXAXAXMAMASMMMMXMASAMXAAAMMXMASAMAXAAXAMMMMASXMMAAASMSMSXXAASASMMMAMSMMMMMAAXXSMMSMXMMXMASMSMAAAAAXAM
SMSMSMSXXXMAMAAMAXAXXMAMAAXAXAMAMMMSMMMSMSSMMSASXSAMASASASAXXMSMMXAAMMXXMXSXSMSMASASAMXMSMSAAAAXMMMMASAMSMMMAMAAMXMXAXXMXXSMSAMXAMMMASMMMMMM
AAAXAXAXXMASMSMMMSMMMMAMMMMXMAMSMMAXAMASXMAXASASMSAMMSASASMMSXMASMMSMMAASAXASAAXAMASMMAXAAMMMSASMSMMMMXMAXASASXSMAXXXMMXMAXXXXMAMMMMAXXMSSSM
MSMSSSMMXAMXAAAXXAMAXSXSXMAXSAAXAMXXAMXSASAMMSXMASMMMMAMAMAASASAMAXMAMXSMASAMSMMSXMMAMXMMMMXMMAAAAXSMSMSMSMSASAMXXSXMAXMMSSMMSMXSAMSMSSXAAAM
XMAXAAXAMSMSSSMMSMMSMSXXMAXXMMSSSMSSXMSSMMMSAMAMAMAAMMMMXMMXSMMMSMMSAMXXMXMXMXXAAAXSXMAXAASAXMAMXMMMAAMAAMXMMMAMXMAXAMXXAAAAXSAAMMXAAAAMMSMM
SMMMXXMMXAAAXAMXAAXMXSXMASXSXXAAXAAAAMAMAAAMAMAMXXSMSSXSMSXMXXAAAAXSAXMSMSAMXXMASMMAASXSSSSXMMSXMSAMSMSMXMAXASAMAAXXMXSMMSSMMMMMSXSMSMMXMAMS
AAAMSSMMSMSMSMMSSMMMASAMAXMMMMMSMMSSMMASMMSSSMSMSMASXMAMSAXMASMSSSMSAMSAMAMMSMMMAASMMSAMXAMAXSXMASAXAAAMMSMSXSASXSMMSMMAXAAAXSAXSMSMXXXXSASM
SSMSAAAAXAMXXMXAMASMAMAMAXAAAAAAAMMAMXASAAAAAAAAAXMASMAMAMXMAMMAAAMMAMSASXSAAAXXMMMAAXAXMAMSMMAMAXMSMSMSAAMSASAMAAXAAASXMASXMASMSAMXSMSAMXAM
AAMMXSMASAMXMXMASXMASMXMMSSSSMSSSMSXMMASMMMSMMMSMSAMXMASMXSASMMMSMMSMMSXMAMMSSMAXXSMMMMXSASAASXMXSASAMXMMSSMAMAMSXMSSMMMSAMXMAMXMXMASAMXMSMX''';
