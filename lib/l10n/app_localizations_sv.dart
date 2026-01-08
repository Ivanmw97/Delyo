// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'DelYo';

  @override
  String get homeTitle => 'Hem';

  @override
  String get myMatchesTitle => 'Mina Matcher';

  @override
  String get statsTitle => 'Statistik';

  @override
  String get addMatchTitle => 'Lägg till Match';

  @override
  String get cancel => 'Avbryt';

  @override
  String get saveMatch => 'Spara Match';

  @override
  String get newMatch => '+ Ny Match';

  @override
  String get matchDetails => 'Matchdetaljer';

  @override
  String get matchType => 'Matchtyp';

  @override
  String get playingSide => 'Spelplan';

  @override
  String get players => 'Spelare';

  @override
  String get partnerName => 'Partners Namn';

  @override
  String get opponent1Name => 'Motståndare 1 Namn';

  @override
  String get opponent2Name => 'Motståndare 2 Namn';

  @override
  String get additionalDetails => 'Ytterligare Detaljer';

  @override
  String get location => 'Plats';

  @override
  String get locationHint => 't.ex. Padel Club';

  @override
  String get hours => 'Timmar';

  @override
  String get minutes => 'Minuter';

  @override
  String get sets => 'Set';

  @override
  String get performanceRating => 'Prestationsbedömning';

  @override
  String get matchTypeFriendly => 'VÄNSKAPSMATCH';

  @override
  String get matchTypeLeague => 'LIGA';

  @override
  String get matchTypeTournament => 'TURNERING';

  @override
  String get playingSideRight => 'HÖGER';

  @override
  String get playingSideLeft => 'VÄNSTER';

  @override
  String get matchTypeFriendlyDisplay => 'Vänskapsmatch';

  @override
  String get matchTypeLeagueDisplay => 'Liga';

  @override
  String get matchTypeTournamentDisplay => 'Turnering';

  @override
  String get win => 'Vinst';

  @override
  String get loss => 'Förlust';

  @override
  String get draw => 'Oavgjort';

  @override
  String get winLetter => 'V';

  @override
  String get lossLetter => 'F';

  @override
  String get drawLetter => 'O';

  @override
  String get noMatchesYet => 'Inga matcher än';

  @override
  String get startTrackingJourney => 'Börja spåra din padelresa';

  @override
  String get noMatchesInPeriod => 'Inga matcher under denna period';

  @override
  String get tryDifferentTimeRange => 'Försök välja ett annat tidsintervall';

  @override
  String get tapToAddFirstMatch =>
      'Tryck + för att lägga till din första match';

  @override
  String get tryDifferentTimeRangeStats =>
      'Prova att välja en annan tidsperiod för att se din statistik';

  @override
  String get addMatchesToSeeStats =>
      'Lägg till matcher för att börja se din prestationsstatistik';

  @override
  String matchesCount(int count) {
    return '$count matcher';
  }

  @override
  String get matchDeleted => 'Match raderad';

  @override
  String get undo => 'Ångra';

  @override
  String get retry => 'Försök igen';

  @override
  String error(String message) {
    return 'Fel: $message';
  }

  @override
  String get atLeastOneSetRequired => 'Minst ett set krävs';

  @override
  String get officialMatchesMustHaveWinner =>
      'Officiella matcher måste ha en vinnare (bäst av 3 set)';

  @override
  String get yourMatchResultsSoFar => 'Dina matchresultat hittills';

  @override
  String get seeHowPerformingOverall => 'Se hur du presterar överlag';

  @override
  String get typesOfMatchesPlayMost => 'De typer av matcher du spelar oftast';

  @override
  String get howPerformingRecently => 'Hur du har presterat på senare tid';

  @override
  String get consistencyCurrentForm => 'Din konsistens och nuvarande form';

  @override
  String get youMostlyPlayFriendly => 'Du spelar mest vänskapsmatches';

  @override
  String get youFocusOnLeague => 'Du fokuserar på ligamatcher';

  @override
  String get youCompeteInTournaments => 'Du tävlar ofta i turneringar';

  @override
  String get yourMatchTypes => 'Dina matchtyper';

  @override
  String get resultsDistribution => 'Resultatfördelning';

  @override
  String get matchTypesBreakdown => 'Matchtyper';

  @override
  String get wins => 'Vinster';

  @override
  String get losses => 'Förluster';

  @override
  String get draws => 'Oavgjorda';

  @override
  String get noScore => 'Ingen poäng';

  @override
  String get navigationHome => 'Hem';

  @override
  String get navigationMatches => 'Matcher';

  @override
  String get navigationStats => 'Statistik';

  @override
  String get lastMonth => 'Senaste Månaden';

  @override
  String get lastThreeMonths => 'Senaste 3 Månaderna';

  @override
  String get lastYear => 'Senaste Året';

  @override
  String get allTime => 'Hela Tiden';

  @override
  String get duration => 'Varaktighet';

  @override
  String get notSet => 'Ej inställd';

  @override
  String get yourPadelJourneyBeginsHere => 'Din padelresa börjar här';

  @override
  String get oneMatchPlayed => '1 match spelad';

  @override
  String get victory => 'Vinst';

  @override
  String get victories => 'vinster';

  @override
  String get defeat => 'Förlust';

  @override
  String get defeats => 'förluster';

  @override
  String get recentPerformance => 'SENASTE PRESTATIONER';

  @override
  String winRateExcludingDraws(int percentage) {
    return 'Vinstprocent (exklusive oavgjorda): $percentage%';
  }

  @override
  String lastMatchesWithResults(int count, String results) {
    return 'Senaste $count matcherna · $results';
  }

  @override
  String drawResult(int setsWon, int setsLost) {
    return 'Oavgjort ($setsWon–$setsLost)';
  }

  @override
  String winResult(int setsWon, int setsLost) {
    return 'Vinst ($setsWon–$setsLost)';
  }

  @override
  String lossResult(int setsWon, int setsLost) {
    return 'Förlust ($setsWon–$setsLost)';
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
  String get readyToStart => 'Redo att börja';

  @override
  String get perfectStart => 'Perfekt start';

  @override
  String get undefeatedSoFar => 'Obesegrad hittills';

  @override
  String get firstMatchDone => 'Första matchen klar';

  @override
  String get stillFindingRhythm => 'Hittar fortfarande din rytm';

  @override
  String get strongPerformance => 'Stark prestation';

  @override
  String get buildingExperience => 'Bygger erfarenhet';

  @override
  String get balancedPerformance => 'Balanserad prestation';

  @override
  String get goodMomentum => 'Bra fart';

  @override
  String get learningAndImproving => 'Lär och förbättras';

  @override
  String get steadyProgress => 'Stadig framsteg';

  @override
  String get matchUpdatedSuccessfully => 'Match uppdaterad framgångsrikt';

  @override
  String errorUpdatingMatch(String error) {
    return 'Fel vid uppdatering av match: $error';
  }

  @override
  String errorGeneric(String error) {
    return 'Fel: $error';
  }

  @override
  String get performanceInsights => 'Prestationsinsikter';

  @override
  String get avgRating => 'Genomsnittlig Bedömning';

  @override
  String get recentForm => 'Senaste Form';

  @override
  String get howYouRatePerformance => 'Hur du bedömer din egen prestation';

  @override
  String winsInLastMatches(int count) {
    return 'Vinster i dina senaste $count matcher';
  }

  @override
  String get yourTeam => 'Ditt Lag';

  @override
  String get opponentTeam => 'Motståndarlaget';

  @override
  String get you => 'Du';

  @override
  String get player1 => 'Spelare 1';

  @override
  String get player2 => 'Spelare 2';

  @override
  String get edit => 'Redigera';

  @override
  String get performance => 'Prestation';

  @override
  String get matchDate => 'Matchdatum';

  @override
  String get selectMatchDate => 'Välj Matchdatum';

  @override
  String get select => 'Välj';

  @override
  String get matchDateRequired => 'Matchdatum krävs';

  @override
  String get futureDateNotAllowed => 'Framtida datum är inte tillåtna';

  @override
  String get noMatchesThisMonth => 'Inga matcher denna månad';

  @override
  String get noMatchesThisMonthSubtitle =>
      'Du har inte lagt till några matcher under denna period än';

  @override
  String get addMatch => 'Lägg till Match';

  @override
  String get noDataToShow => 'Ingen data att visa';

  @override
  String get addMatchesOrChangeRange =>
      'Lägg till matcher eller ändra tidsintervallet för att se din statistik';

  @override
  String get startTrackingMatches => 'Börja spåra dina matcher';

  @override
  String get addFirstMatchSubtitle =>
      'Lägg till din första padelmatch och börja följa dina framsteg';

  @override
  String get tryChangingTimeRange =>
      'Försök ändra tidsintervallet för att se andra matcher';

  @override
  String get noMatchesAddedYet => 'Du har inte lagt till några matcher än';

  @override
  String get startByAddingFirstMatch =>
      'Börja med att registrera din första padelmatch';

  @override
  String get noStatsYet => 'Ingen statistik än';

  @override
  String get noDataForThisPeriod => 'Ingen data för denna period';

  @override
  String get changeRangeToSeeOtherStats =>
      'Ändra tidsintervallet för att se statistik från andra matcher';

  @override
  String get lastMatch => 'Senaste match';

  @override
  String get friendly => 'Vänskapsmatch';

  @override
  String get league => 'Liga';

  @override
  String get tournament => 'Turnering';

  @override
  String get straightSets => 'Raka set';

  @override
  String get onboardingTitle1 => 'Spåra dina padelmatches';

  @override
  String get onboardingSubtitle1 =>
      'Spara dina matcher, resultat och speltyper enkelt';

  @override
  String get onboardingTitle2 => 'Analysera dina framsteg';

  @override
  String get onboardingSubtitle2 =>
      'Se statistik per månad, matchtyper och prestation';

  @override
  String get onboardingTitle3 => 'Börja när du vill';

  @override
  String get onboardingSubtitle3 =>
      'Lägg till matcher manuellt och granska din historik när du behöver';

  @override
  String get getStarted => 'Kom igång';

  @override
  String get next => 'Nästa';

  @override
  String get welcomeTo => 'Välkommen till';

  @override
  String get addFirstMatch => 'Lägg till första match';

  @override
  String get optional => 'valfritt';

  @override
  String get performanceRatingHelper =>
      'Hur kände du dig om din prestation i denna match?';

  @override
  String matchesPlural(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count matcher',
      one: '1 match',
    );
    return '$_temp0';
  }
}
