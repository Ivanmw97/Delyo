import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_sv.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
    Locale('sv'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'DelYo'**
  String get appTitle;

  /// Title for the home page
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Title for the matches list page
  ///
  /// In en, this message translates to:
  /// **'My Matches'**
  String get myMatchesTitle;

  /// Title for the stats page
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get statsTitle;

  /// Title for the add match page
  ///
  /// In en, this message translates to:
  /// **'Add Match'**
  String get addMatchTitle;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Save match button text
  ///
  /// In en, this message translates to:
  /// **'Save Match'**
  String get saveMatch;

  /// New match button text
  ///
  /// In en, this message translates to:
  /// **'+ New Match'**
  String get newMatch;

  /// Match details section title
  ///
  /// In en, this message translates to:
  /// **'Match Details'**
  String get matchDetails;

  /// Match type field label
  ///
  /// In en, this message translates to:
  /// **'Match Type'**
  String get matchType;

  /// Playing side field label
  ///
  /// In en, this message translates to:
  /// **'Playing Side'**
  String get playingSide;

  /// Players section title
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get players;

  /// Partner name field label
  ///
  /// In en, this message translates to:
  /// **'Partner Name'**
  String get partnerName;

  /// First opponent name field label
  ///
  /// In en, this message translates to:
  /// **'Opponent 1 Name'**
  String get opponent1Name;

  /// Second opponent name field label
  ///
  /// In en, this message translates to:
  /// **'Opponent 2 Name'**
  String get opponent2Name;

  /// Additional details section title
  ///
  /// In en, this message translates to:
  /// **'Additional Details'**
  String get additionalDetails;

  /// Location field label
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Location field hint text
  ///
  /// In en, this message translates to:
  /// **'e.g. Club Padel'**
  String get locationHint;

  /// Hours field label
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// Minutes field label
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// Sets section title
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get sets;

  /// Performance rating section title
  ///
  /// In en, this message translates to:
  /// **'Performance Rating'**
  String get performanceRating;

  /// Friendly match type
  ///
  /// In en, this message translates to:
  /// **'FRIENDLY'**
  String get matchTypeFriendly;

  /// League match type
  ///
  /// In en, this message translates to:
  /// **'LEAGUE'**
  String get matchTypeLeague;

  /// Tournament match type
  ///
  /// In en, this message translates to:
  /// **'TOURNAMENT'**
  String get matchTypeTournament;

  /// Right playing side
  ///
  /// In en, this message translates to:
  /// **'RIGHT'**
  String get playingSideRight;

  /// Left playing side
  ///
  /// In en, this message translates to:
  /// **'LEFT'**
  String get playingSideLeft;

  /// Friendly match type for display
  ///
  /// In en, this message translates to:
  /// **'Friendly'**
  String get matchTypeFriendlyDisplay;

  /// League match type for display
  ///
  /// In en, this message translates to:
  /// **'League'**
  String get matchTypeLeagueDisplay;

  /// Tournament match type for display
  ///
  /// In en, this message translates to:
  /// **'Tournament'**
  String get matchTypeTournamentDisplay;

  /// Win outcome text
  ///
  /// In en, this message translates to:
  /// **'Win'**
  String get win;

  /// Loss outcome text
  ///
  /// In en, this message translates to:
  /// **'Loss'**
  String get loss;

  /// Draw outcome text
  ///
  /// In en, this message translates to:
  /// **'Draw'**
  String get draw;

  /// Single letter abbreviation for Win
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get winLetter;

  /// Single letter abbreviation for Loss
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get lossLetter;

  /// Single letter abbreviation for Draw
  ///
  /// In en, this message translates to:
  /// **'D'**
  String get drawLetter;

  /// Empty state message when no matches exist
  ///
  /// In en, this message translates to:
  /// **'No matches yet'**
  String get noMatchesYet;

  /// Empty state subtitle for home page
  ///
  /// In en, this message translates to:
  /// **'Start tracking your padel journey'**
  String get startTrackingJourney;

  /// Empty state message when no matches in selected time range
  ///
  /// In en, this message translates to:
  /// **'No matches in this period'**
  String get noMatchesInPeriod;

  /// Empty state subtitle for filtered results
  ///
  /// In en, this message translates to:
  /// **'Try selecting a different time range'**
  String get tryDifferentTimeRange;

  /// Empty state subtitle when no matches exist
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first match'**
  String get tapToAddFirstMatch;

  /// Empty state subtitle for stats page
  ///
  /// In en, this message translates to:
  /// **'Try selecting a different time range to see your stats'**
  String get tryDifferentTimeRangeStats;

  /// Empty state subtitle for stats page when no matches
  ///
  /// In en, this message translates to:
  /// **'Add some matches to see your stats'**
  String get addMatchesToSeeStats;

  /// Number of matches text
  ///
  /// In en, this message translates to:
  /// **'{count} matches'**
  String matchesCount(int count);

  /// Snackbar message when match is deleted
  ///
  /// In en, this message translates to:
  /// **'Match deleted'**
  String get matchDeleted;

  /// Undo action text
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Error message format
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String error(String message);

  /// Validation error for empty sets
  ///
  /// In en, this message translates to:
  /// **'At least one set is required'**
  String get atLeastOneSetRequired;

  /// Validation error for official matches without winner
  ///
  /// In en, this message translates to:
  /// **'Official matches must have a winner (best of 3 sets)'**
  String get officialMatchesMustHaveWinner;

  /// Stats section title for results
  ///
  /// In en, this message translates to:
  /// **'Your match results so far'**
  String get yourMatchResultsSoFar;

  /// Stats section subtitle for results
  ///
  /// In en, this message translates to:
  /// **'See how you\'ve been performing overall'**
  String get seeHowPerformingOverall;

  /// Stats section subtitle for match types
  ///
  /// In en, this message translates to:
  /// **'The types of matches you play most often'**
  String get typesOfMatchesPlayMost;

  /// Stats section title for performance
  ///
  /// In en, this message translates to:
  /// **'How you\'ve been performing recently'**
  String get howPerformingRecently;

  /// Stats section subtitle for performance
  ///
  /// In en, this message translates to:
  /// **'Your consistency and current form'**
  String get consistencyCurrentForm;

  /// Stats narrative for friendly matches
  ///
  /// In en, this message translates to:
  /// **'You mostly play friendly matches'**
  String get youMostlyPlayFriendly;

  /// Stats narrative for league matches
  ///
  /// In en, this message translates to:
  /// **'You focus on league matches'**
  String get youFocusOnLeague;

  /// Stats narrative for tournament matches
  ///
  /// In en, this message translates to:
  /// **'You compete in tournaments often'**
  String get youCompeteInTournaments;

  /// Default stats narrative for match types
  ///
  /// In en, this message translates to:
  /// **'Your match types'**
  String get yourMatchTypes;

  /// Results distribution widget title
  ///
  /// In en, this message translates to:
  /// **'Results Distribution'**
  String get resultsDistribution;

  /// Match types breakdown widget title
  ///
  /// In en, this message translates to:
  /// **'Match Types'**
  String get matchTypesBreakdown;

  /// Wins label in stats
  ///
  /// In en, this message translates to:
  /// **'Wins'**
  String get wins;

  /// Losses label in stats
  ///
  /// In en, this message translates to:
  /// **'Losses'**
  String get losses;

  /// Draws label in stats
  ///
  /// In en, this message translates to:
  /// **'Draws'**
  String get draws;

  /// Text when match has no score
  ///
  /// In en, this message translates to:
  /// **'No score'**
  String get noScore;

  /// Bottom navigation label for home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navigationHome;

  /// Bottom navigation label for matches
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get navigationMatches;

  /// Bottom navigation label for stats
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get navigationStats;

  /// Time range filter for last month
  ///
  /// In en, this message translates to:
  /// **'Last Month'**
  String get lastMonth;

  /// Time range filter for last 3 months
  ///
  /// In en, this message translates to:
  /// **'Last 3 Months'**
  String get lastThreeMonths;

  /// Time range filter for last year
  ///
  /// In en, this message translates to:
  /// **'Last Year'**
  String get lastYear;

  /// Time range filter for all time
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get allTime;

  /// Duration label
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// Text when a field is not set
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// Performance message for no matches
  ///
  /// In en, this message translates to:
  /// **'Your padel journey begins here'**
  String get yourPadelJourneyBeginsHere;

  /// Performance message for single match
  ///
  /// In en, this message translates to:
  /// **'1 match played'**
  String get oneMatchPlayed;

  /// Single victory text
  ///
  /// In en, this message translates to:
  /// **'victory'**
  String get victory;

  /// Multiple victories text
  ///
  /// In en, this message translates to:
  /// **'victories'**
  String get victories;

  /// Single defeat text
  ///
  /// In en, this message translates to:
  /// **'defeat'**
  String get defeat;

  /// Multiple defeats text
  ///
  /// In en, this message translates to:
  /// **'defeats'**
  String get defeats;

  /// Recent performance section header
  ///
  /// In en, this message translates to:
  /// **'RECENT PERFORMANCE'**
  String get recentPerformance;

  /// Win rate percentage text
  ///
  /// In en, this message translates to:
  /// **'Win rate (excluding draws): {percentage}%'**
  String winRateExcludingDraws(int percentage);

  /// Last matches summary with results
  ///
  /// In en, this message translates to:
  /// **'Last {count} matches · {results}'**
  String lastMatchesWithResults(int count, String results);

  /// Draw result text with sets
  ///
  /// In en, this message translates to:
  /// **'Draw ({setsWon}–{setsLost})'**
  String drawResult(int setsWon, int setsLost);

  /// Win result text with sets
  ///
  /// In en, this message translates to:
  /// **'Win ({setsWon}–{setsLost})'**
  String winResult(int setsWon, int setsLost);

  /// Loss result text with sets
  ///
  /// In en, this message translates to:
  /// **'Loss ({setsWon}–{setsLost})'**
  String lossResult(int setsWon, int setsLost);

  /// Hours short format
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String hoursShort(int hours);

  /// Minutes short format
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String minutesShort(int minutes);

  /// Hours and minutes format
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String hoursAndMinutes(int hours, int minutes);

  /// Zero minutes format
  ///
  /// In en, this message translates to:
  /// **'0m'**
  String get zeroMinutes;

  /// Performance message for no matches
  ///
  /// In en, this message translates to:
  /// **'Ready to start'**
  String get readyToStart;

  /// Performance message for first win
  ///
  /// In en, this message translates to:
  /// **'Perfect start'**
  String get perfectStart;

  /// Performance message for multiple wins
  ///
  /// In en, this message translates to:
  /// **'Undefeated so far'**
  String get undefeatedSoFar;

  /// Performance message for first loss
  ///
  /// In en, this message translates to:
  /// **'First match done'**
  String get firstMatchDone;

  /// Performance message for multiple losses
  ///
  /// In en, this message translates to:
  /// **'Still finding your rhythm'**
  String get stillFindingRhythm;

  /// Performance message for good win rate
  ///
  /// In en, this message translates to:
  /// **'Strong performance'**
  String get strongPerformance;

  /// Performance message for learning
  ///
  /// In en, this message translates to:
  /// **'Building experience'**
  String get buildingExperience;

  /// Performance message for even record
  ///
  /// In en, this message translates to:
  /// **'Balanced performance'**
  String get balancedPerformance;

  /// Performance message for positive trend
  ///
  /// In en, this message translates to:
  /// **'Good momentum'**
  String get goodMomentum;

  /// Performance message for growth
  ///
  /// In en, this message translates to:
  /// **'Learning and improving'**
  String get learningAndImproving;

  /// Default performance message
  ///
  /// In en, this message translates to:
  /// **'Steady progress'**
  String get steadyProgress;

  /// Success message for match update
  ///
  /// In en, this message translates to:
  /// **'Match updated successfully'**
  String get matchUpdatedSuccessfully;

  /// Error message for match update failure
  ///
  /// In en, this message translates to:
  /// **'Error updating match: {error}'**
  String errorUpdatingMatch(String error);

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorGeneric(String error);

  /// Title for performance insights section
  ///
  /// In en, this message translates to:
  /// **'Performance Insights'**
  String get performanceInsights;

  /// Average rating label
  ///
  /// In en, this message translates to:
  /// **'Avg Rating'**
  String get avgRating;

  /// Recent form label
  ///
  /// In en, this message translates to:
  /// **'Recent Form'**
  String get recentForm;

  /// Subtitle for average rating card
  ///
  /// In en, this message translates to:
  /// **'How you rate your own performance'**
  String get howYouRatePerformance;

  /// Subtitle for recent form card
  ///
  /// In en, this message translates to:
  /// **'Wins in your last {count} matches'**
  String winsInLastMatches(int count);

  /// Label for user's team
  ///
  /// In en, this message translates to:
  /// **'Your Team'**
  String get yourTeam;

  /// Label for opponent team
  ///
  /// In en, this message translates to:
  /// **'Opponent Team'**
  String get opponentTeam;

  /// Label for the user player
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// Default name for first opponent
  ///
  /// In en, this message translates to:
  /// **'Player 1'**
  String get player1;

  /// Default name for second opponent
  ///
  /// In en, this message translates to:
  /// **'Player 2'**
  String get player2;

  /// Edit button text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Performance section label
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get performance;

  /// Label for match date field
  ///
  /// In en, this message translates to:
  /// **'Match Date'**
  String get matchDate;

  /// Title for date picker dialog
  ///
  /// In en, this message translates to:
  /// **'Select Match Date'**
  String get selectMatchDate;

  /// Select button text in date picker
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// Validation error when match date is missing
  ///
  /// In en, this message translates to:
  /// **'Match date is required'**
  String get matchDateRequired;

  /// Validation error when selected date is in the future
  ///
  /// In en, this message translates to:
  /// **'Future dates are not allowed'**
  String get futureDateNotAllowed;

  /// Empty state title when no matches exist for current month filter
  ///
  /// In en, this message translates to:
  /// **'No matches this month'**
  String get noMatchesThisMonth;

  /// Empty state subtitle when no matches exist for current month filter
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any matches in this period yet'**
  String get noMatchesThisMonthSubtitle;

  /// Add match button text
  ///
  /// In en, this message translates to:
  /// **'Add Match'**
  String get addMatch;

  /// Empty state title when no stats data available
  ///
  /// In en, this message translates to:
  /// **'No data to show'**
  String get noDataToShow;

  /// Empty state subtitle for stats with suggestion to add matches or change range
  ///
  /// In en, this message translates to:
  /// **'Add matches or change the time range to see your statistics'**
  String get addMatchesOrChangeRange;

  /// First-time user empty state title encouraging to start tracking
  ///
  /// In en, this message translates to:
  /// **'Start tracking your matches'**
  String get startTrackingMatches;

  /// First-time user empty state subtitle explaining benefits
  ///
  /// In en, this message translates to:
  /// **'Add your first padel match and start following your progress'**
  String get addFirstMatchSubtitle;

  /// Filtered empty state subtitle suggesting time range change
  ///
  /// In en, this message translates to:
  /// **'Try changing the time range to see other matches'**
  String get tryChangingTimeRange;

  /// My Matches first-time user empty state title
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any matches yet'**
  String get noMatchesAddedYet;

  /// My Matches first-time user empty state subtitle
  ///
  /// In en, this message translates to:
  /// **'Start by recording your first padel match'**
  String get startByAddingFirstMatch;

  /// Stats first-time user empty state title
  ///
  /// In en, this message translates to:
  /// **'No statistics yet'**
  String get noStatsYet;

  /// Stats filtered empty state title
  ///
  /// In en, this message translates to:
  /// **'No data for this period'**
  String get noDataForThisPeriod;

  /// Stats filtered empty state subtitle
  ///
  /// In en, this message translates to:
  /// **'Change the time range to see statistics from other matches'**
  String get changeRangeToSeeOtherStats;

  /// Last match header text
  ///
  /// In en, this message translates to:
  /// **'Last match'**
  String get lastMatch;

  /// Friendly match type
  ///
  /// In en, this message translates to:
  /// **'Friendly'**
  String get friendly;

  /// League match type
  ///
  /// In en, this message translates to:
  /// **'League'**
  String get league;

  /// Tournament match type
  ///
  /// In en, this message translates to:
  /// **'Tournament'**
  String get tournament;

  /// Straight sets text
  ///
  /// In en, this message translates to:
  /// **'Straight Sets'**
  String get straightSets;

  /// Onboarding screen 1 title
  ///
  /// In en, this message translates to:
  /// **'Track your padel matches'**
  String get onboardingTitle1;

  /// Onboarding screen 1 subtitle
  ///
  /// In en, this message translates to:
  /// **'Save your matches, results and game types easily'**
  String get onboardingSubtitle1;

  /// Onboarding screen 2 title
  ///
  /// In en, this message translates to:
  /// **'Analyze your progress'**
  String get onboardingTitle2;

  /// Onboarding screen 2 subtitle
  ///
  /// In en, this message translates to:
  /// **'View statistics by months, match types and performance'**
  String get onboardingSubtitle2;

  /// Onboarding screen 3 title
  ///
  /// In en, this message translates to:
  /// **'Start whenever you want'**
  String get onboardingTitle3;

  /// Onboarding screen 3 subtitle
  ///
  /// In en, this message translates to:
  /// **'Add matches manually and review your history whenever you need'**
  String get onboardingSubtitle3;

  /// Get started button text for onboarding
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// Next button text for onboarding
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Welcome screen small text
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// Add first match button text
  ///
  /// In en, this message translates to:
  /// **'Add First Match'**
  String get addFirstMatch;

  /// Optional field indicator text
  ///
  /// In en, this message translates to:
  /// **'optional'**
  String get optional;

  /// Helper text for performance rating section
  ///
  /// In en, this message translates to:
  /// **'How did you feel about your performance in this match?'**
  String get performanceRatingHelper;

  /// Pluralized matches count text
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 match} other{{count} matches}}'**
  String matchesPlural(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'en',
    'es',
    'fr',
    'it',
    'pt',
    'sv',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
    case 'sv':
      return AppLocalizationsSv();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
