// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DelYo';

  @override
  String get homeTitle => 'Home';

  @override
  String get myMatchesTitle => 'My Matches';

  @override
  String get statsTitle => 'Stats';

  @override
  String get addMatchTitle => 'Add Match';

  @override
  String get cancel => 'Cancel';

  @override
  String get saveMatch => 'Save Match';

  @override
  String get newMatch => '+ New Match';

  @override
  String get matchDetails => 'Match Details';

  @override
  String get matchType => 'Match Type';

  @override
  String get playingSide => 'Playing Side';

  @override
  String get players => 'Players';

  @override
  String get partnerName => 'Partner Name';

  @override
  String get opponent1Name => 'Opponent 1 Name';

  @override
  String get opponent2Name => 'Opponent 2 Name';

  @override
  String get additionalDetails => 'Additional Details';

  @override
  String get location => 'Location';

  @override
  String get locationHint => 'e.g. Club Padel';

  @override
  String get hours => 'Hours';

  @override
  String get minutes => 'Minutes';

  @override
  String get sets => 'Sets';

  @override
  String get performanceRating => 'Performance Rating';

  @override
  String get matchTypeFriendly => 'FRIENDLY';

  @override
  String get matchTypeLeague => 'LEAGUE';

  @override
  String get matchTypeTournament => 'TOURNAMENT';

  @override
  String get playingSideRight => 'RIGHT';

  @override
  String get playingSideLeft => 'LEFT';

  @override
  String get matchTypeFriendlyDisplay => 'Friendly';

  @override
  String get matchTypeLeagueDisplay => 'League';

  @override
  String get matchTypeTournamentDisplay => 'Tournament';

  @override
  String get win => 'Win';

  @override
  String get loss => 'Loss';

  @override
  String get draw => 'Draw';

  @override
  String get winLetter => 'W';

  @override
  String get lossLetter => 'L';

  @override
  String get drawLetter => 'D';

  @override
  String get noMatchesYet => 'No matches yet';

  @override
  String get startTrackingJourney => 'Start tracking your padel journey';

  @override
  String get noMatchesInPeriod => 'No matches in this period';

  @override
  String get tryDifferentTimeRange => 'Try selecting a different time range';

  @override
  String get tapToAddFirstMatch => 'Tap + to add your first match';

  @override
  String get tryDifferentTimeRangeStats =>
      'Try selecting a different time range to see your stats';

  @override
  String get addMatchesToSeeStats => 'Add some matches to see your stats';

  @override
  String matchesCount(int count) {
    return '$count matches';
  }

  @override
  String get matchDeleted => 'Match deleted';

  @override
  String get undo => 'Undo';

  @override
  String get retry => 'Retry';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String get atLeastOneSetRequired => 'At least one set is required';

  @override
  String get officialMatchesMustHaveWinner =>
      'Official matches must have a winner (best of 3 sets)';

  @override
  String get yourMatchResultsSoFar => 'Your match results so far';

  @override
  String get seeHowPerformingOverall =>
      'See how you\'ve been performing overall';

  @override
  String get typesOfMatchesPlayMost =>
      'The types of matches you play most often';

  @override
  String get howPerformingRecently => 'How you\'ve been performing recently';

  @override
  String get consistencyCurrentForm => 'Your consistency and current form';

  @override
  String get youMostlyPlayFriendly => 'You mostly play friendly matches';

  @override
  String get youFocusOnLeague => 'You focus on league matches';

  @override
  String get youCompeteInTournaments => 'You compete in tournaments often';

  @override
  String get yourMatchTypes => 'Your match types';

  @override
  String get resultsDistribution => 'Results Distribution';

  @override
  String get matchTypesBreakdown => 'Match Types';

  @override
  String get wins => 'Wins';

  @override
  String get losses => 'Losses';

  @override
  String get draws => 'Draws';

  @override
  String get noScore => 'No score';

  @override
  String get navigationHome => 'Home';

  @override
  String get navigationMatches => 'Matches';

  @override
  String get navigationStats => 'Stats';

  @override
  String get lastMonth => 'Last Month';

  @override
  String get lastThreeMonths => 'Last 3 Months';

  @override
  String get lastYear => 'Last Year';

  @override
  String get allTime => 'All Time';

  @override
  String get duration => 'Duration';

  @override
  String get notSet => 'Not set';

  @override
  String get yourPadelJourneyBeginsHere => 'Your padel journey begins here';

  @override
  String get oneMatchPlayed => '1 match played';

  @override
  String get victory => 'victory';

  @override
  String get victories => 'victories';

  @override
  String get defeat => 'defeat';

  @override
  String get defeats => 'defeats';

  @override
  String get recentPerformance => 'RECENT PERFORMANCE';

  @override
  String winRateExcludingDraws(int percentage) {
    return 'Win rate (excluding draws): $percentage%';
  }

  @override
  String lastMatchesWithResults(int count, String results) {
    return 'Last $count matches · $results';
  }

  @override
  String drawResult(int setsWon, int setsLost) {
    return 'Draw ($setsWon–$setsLost)';
  }

  @override
  String winResult(int setsWon, int setsLost) {
    return 'Win ($setsWon–$setsLost)';
  }

  @override
  String lossResult(int setsWon, int setsLost) {
    return 'Loss ($setsWon–$setsLost)';
  }

  @override
  String hoursShort(int hours) {
    return '${hours}h';
  }

  @override
  String minutesShort(int minutes) {
    return '${minutes}m';
  }

  @override
  String hoursAndMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get zeroMinutes => '0m';

  @override
  String get readyToStart => 'Ready to start';

  @override
  String get perfectStart => 'Perfect start';

  @override
  String get undefeatedSoFar => 'Undefeated so far';

  @override
  String get firstMatchDone => 'First match done';

  @override
  String get stillFindingRhythm => 'Still finding your rhythm';

  @override
  String get strongPerformance => 'Strong performance';

  @override
  String get buildingExperience => 'Building experience';

  @override
  String get balancedPerformance => 'Balanced performance';

  @override
  String get goodMomentum => 'Good momentum';

  @override
  String get learningAndImproving => 'Learning and improving';

  @override
  String get steadyProgress => 'Steady progress';

  @override
  String get matchUpdatedSuccessfully => 'Match updated successfully';

  @override
  String errorUpdatingMatch(String error) {
    return 'Error updating match: $error';
  }

  @override
  String errorGeneric(String error) {
    return 'Error: $error';
  }

  @override
  String get performanceInsights => 'Performance Insights';

  @override
  String get avgRating => 'Avg Rating';

  @override
  String get recentForm => 'Recent Form';

  @override
  String get howYouRatePerformance => 'How you rate your own performance';

  @override
  String winsInLastMatches(int count) {
    return 'Wins in your last $count matches';
  }

  @override
  String get yourTeam => 'Your Team';

  @override
  String get opponentTeam => 'Opponent Team';

  @override
  String get you => 'You';

  @override
  String get player1 => 'Player 1';

  @override
  String get player2 => 'Player 2';

  @override
  String get edit => 'Edit';

  @override
  String get performance => 'Performance';

  @override
  String get matchDate => 'Match Date';

  @override
  String get selectMatchDate => 'Select Match Date';

  @override
  String get select => 'Select';

  @override
  String get matchDateRequired => 'Match date is required';

  @override
  String get futureDateNotAllowed => 'Future dates are not allowed';

  @override
  String get noMatchesThisMonth => 'No matches this month';

  @override
  String get noMatchesThisMonthSubtitle =>
      'You haven\'t added any matches in this period yet';

  @override
  String get addMatch => 'Add Match';

  @override
  String get noDataToShow => 'No data to show';

  @override
  String get addMatchesOrChangeRange =>
      'Add matches or change the time range to see your statistics';

  @override
  String get startTrackingMatches => 'Start tracking your matches';

  @override
  String get addFirstMatchSubtitle =>
      'Add your first padel match and start following your progress';

  @override
  String get tryChangingTimeRange =>
      'Try changing the time range to see other matches';

  @override
  String get noMatchesAddedYet => 'You haven\'t added any matches yet';

  @override
  String get startByAddingFirstMatch =>
      'Start by recording your first padel match';

  @override
  String get noStatsYet => 'No statistics yet';

  @override
  String get noDataForThisPeriod => 'No data for this period';

  @override
  String get changeRangeToSeeOtherStats =>
      'Change the time range to see statistics from other matches';

  @override
  String get lastMatch => 'Last match';

  @override
  String get friendly => 'Friendly';

  @override
  String get league => 'League';

  @override
  String get tournament => 'Tournament';

  @override
  String get straightSets => 'Straight Sets';

  @override
  String get onboardingTitle1 => 'Track your padel matches';

  @override
  String get onboardingSubtitle1 =>
      'Save your matches, results and game types easily';

  @override
  String get onboardingTitle2 => 'Analyze your progress';

  @override
  String get onboardingSubtitle2 =>
      'View statistics by months, match types and performance';

  @override
  String get onboardingTitle3 => 'Start whenever you want';

  @override
  String get onboardingSubtitle3 =>
      'Add matches manually and review your history whenever you need';

  @override
  String get getStarted => 'Get Started';

  @override
  String get next => 'Next';

  @override
  String get welcomeTo => 'Welcome to';

  @override
  String get addFirstMatch => 'Add First Match';

  @override
  String get optional => 'optional';

  @override
  String get performanceRatingHelper =>
      'How did you feel about your performance in this match?';

  @override
  String matchesPlural(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count matches',
      one: '1 match',
    );
    return '$_temp0';
  }
}
