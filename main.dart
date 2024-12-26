import 'core/daily_challenge.dart';
import 'puzzles/day_01.dart';
import 'puzzles/day_02.dart';
import 'puzzles/day_03.dart';
import 'puzzles/day_04.dart';
import 'puzzles/day_05.dart';
import 'puzzles/day_06.dart';

void main() {
  // final day1 = HistorianHysteria();
  // final day2 = RedNosedReports();
  // final day3 = MullItOver();
  // final day4 = CeresSearch();
  // final day5 = PrintQueue();
  final day6 = GuardGallivant();
  solve(day6);
}

void solve(DailyChallenge challenge) {
  final resultOfPartOne = challenge.solvePuzzlePartOne();
  print('Answer of part one: $resultOfPartOne');
  final resultOfPartTwo = challenge.solvePuzzlePartTwo();
  print('Answer of part two: $resultOfPartTwo');
}
