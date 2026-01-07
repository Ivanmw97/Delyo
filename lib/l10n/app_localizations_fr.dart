// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'DelYo';

  @override
  String get homeTitle => 'Accueil';

  @override
  String get myMatchesTitle => 'Mes Matchs';

  @override
  String get statsTitle => 'Statistiques';

  @override
  String get addMatchTitle => 'Ajouter un Match';

  @override
  String get cancel => 'Annuler';

  @override
  String get saveMatch => 'Sauvegarder le Match';

  @override
  String get newMatch => '+ Nouveau Match';

  @override
  String get matchDetails => 'Détails du Match';

  @override
  String get matchType => 'Type de Match';

  @override
  String get playingSide => 'Côté de Jeu';

  @override
  String get players => 'Joueurs';

  @override
  String get partnerName => 'Nom du Partenaire';

  @override
  String get opponent1Name => 'Nom Adversaire 1';

  @override
  String get opponent2Name => 'Nom Adversaire 2';

  @override
  String get additionalDetails => 'Détails Supplémentaires';

  @override
  String get location => 'Lieu';

  @override
  String get locationHint => 'ex. Club de Padel';

  @override
  String get hours => 'Heures';

  @override
  String get minutes => 'Minutes';

  @override
  String get sets => 'Sets';

  @override
  String get performanceRating => 'Évaluation de Performance';

  @override
  String get matchTypeFriendly => 'AMICAL';

  @override
  String get matchTypeLeague => 'CHAMPIONNAT';

  @override
  String get matchTypeTournament => 'TOURNOI';

  @override
  String get playingSideRight => 'DROITE';

  @override
  String get playingSideLeft => 'GAUCHE';

  @override
  String get matchTypeFriendlyDisplay => 'Amical';

  @override
  String get matchTypeLeagueDisplay => 'Championnat';

  @override
  String get matchTypeTournamentDisplay => 'Tournoi';

  @override
  String get win => 'Victoire';

  @override
  String get loss => 'Défaite';

  @override
  String get draw => 'Match nul';

  @override
  String get noMatchesYet => 'Aucun match pour le moment';

  @override
  String get startTrackingJourney =>
      'Commencez à suivre votre parcours de padel';

  @override
  String get noMatchesInPeriod => 'Aucun match dans cette période';

  @override
  String get tryDifferentTimeRange =>
      'Essayez de sélectionner une période différente';

  @override
  String get tapToAddFirstMatch =>
      'Appuyez sur + pour ajouter votre premier match';

  @override
  String get tryDifferentTimeRangeStats =>
      'Essayez de sélectionner une période différente pour voir vos statistiques';

  @override
  String get addMatchesToSeeStats =>
      'Ajoutez des matchs pour commencer à voir vos statistiques de performance';

  @override
  String matchesCount(int count) {
    return '$count matchs';
  }

  @override
  String get matchDeleted => 'Match supprimé';

  @override
  String get undo => 'Annuler';

  @override
  String get retry => 'Réessayer';

  @override
  String error(String message) {
    return 'Erreur : $message';
  }

  @override
  String get atLeastOneSetRequired => 'Au moins un set est requis';

  @override
  String get officialMatchesMustHaveWinner =>
      'Les matchs officiels doivent avoir un vainqueur (au meilleur des 3 sets)';

  @override
  String get yourMatchResultsSoFar =>
      'Vos résultats de matchs jusqu\'à présent';

  @override
  String get seeHowPerformingOverall =>
      'Voyez comment vous performez globalement';

  @override
  String get typesOfMatchesPlayMost =>
      'Les types de matchs que vous jouez le plus souvent';

  @override
  String get howPerformingRecently => 'Comment vous avez performé récemment';

  @override
  String get consistencyCurrentForm => 'Votre régularité et forme actuelle';

  @override
  String get youMostlyPlayFriendly =>
      'Vous jouez principalement des matchs amicaux';

  @override
  String get youFocusOnLeague =>
      'Vous vous concentrez sur les matchs de championnat';

  @override
  String get youCompeteInTournaments => 'Vous participez souvent aux tournois';

  @override
  String get yourMatchTypes => 'Vos types de matchs';

  @override
  String get resultsDistribution => 'Distribution des Résultats';

  @override
  String get matchTypesBreakdown => 'Types de Matchs';

  @override
  String get wins => 'Victoires';

  @override
  String get losses => 'Défaites';

  @override
  String get draws => 'Matchs Nuls';

  @override
  String get noScore => 'Aucun score';

  @override
  String get navigationHome => 'Accueil';

  @override
  String get navigationMatches => 'Matchs';

  @override
  String get navigationStats => 'Statistiques';

  @override
  String get lastMonth => 'Dernier Mois';

  @override
  String get lastThreeMonths => '3 Derniers Mois';

  @override
  String get lastYear => 'Dernière Année';

  @override
  String get allTime => 'Tout le Temps';

  @override
  String get duration => 'Durée';

  @override
  String get notSet => 'Non défini';

  @override
  String get yourPadelJourneyBeginsHere =>
      'Votre parcours de padel commence ici';

  @override
  String get oneMatchPlayed => '1 match joué';

  @override
  String get victory => 'Victoire';

  @override
  String get victories => 'victoires';

  @override
  String get defeat => 'Défaite';

  @override
  String get defeats => 'défaites';

  @override
  String get recentPerformance => 'PERFORMANCES RÉCENTES';

  @override
  String winRateExcludingDraws(int percentage) {
    return 'Taux de victoire (hors matchs nuls) : $percentage%';
  }

  @override
  String lastMatchesWithResults(int count, String results) {
    return 'Derniers $count matchs · $results';
  }

  @override
  String drawResult(int setsWon, int setsLost) {
    return 'Match Nul ($setsWon–$setsLost)';
  }

  @override
  String winResult(int setsWon, int setsLost) {
    return 'Victoire ($setsWon–$setsLost)';
  }

  @override
  String lossResult(int setsWon, int setsLost) {
    return 'Défaite ($setsWon–$setsLost)';
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
  String get readyToStart => 'Prêt à commencer';

  @override
  String get perfectStart => 'Début parfait';

  @override
  String get undefeatedSoFar => 'Invaincu jusqu\'à présent';

  @override
  String get firstMatchDone => 'Premier match terminé';

  @override
  String get stillFindingRhythm => 'Encore à la recherche de votre rythme';

  @override
  String get strongPerformance => 'Performance solide';

  @override
  String get buildingExperience => 'Construction d\'expérience';

  @override
  String get balancedPerformance => 'Performance équilibrée';

  @override
  String get goodMomentum => 'Bon élan';

  @override
  String get learningAndImproving => 'Apprentissage et amélioration';

  @override
  String get steadyProgress => 'Progrès régulier';

  @override
  String get matchUpdatedSuccessfully => 'Match mis à jour avec succès';

  @override
  String errorUpdatingMatch(String error) {
    return 'Erreur lors de la mise à jour du match : $error';
  }

  @override
  String errorGeneric(String error) {
    return 'Erreur : $error';
  }

  @override
  String get performanceInsights => 'Aperçus de Performance';

  @override
  String get avgRating => 'Note Moyenne';

  @override
  String get recentForm => 'Forme Récente';

  @override
  String get howYouRatePerformance =>
      'Comment vous évaluez votre propre performance';

  @override
  String winsInLastMatches(int count) {
    return 'Victoires dans vos $count derniers matchs';
  }

  @override
  String get yourTeam => 'Votre Équipe';

  @override
  String get opponentTeam => 'Équipe Adverse';

  @override
  String get you => 'Vous';

  @override
  String get player1 => 'Joueur 1';

  @override
  String get player2 => 'Joueur 2';

  @override
  String get edit => 'Modifier';

  @override
  String get performance => 'Performance';

  @override
  String get matchDate => 'Date du Match';

  @override
  String get selectMatchDate => 'Sélectionner la Date du Match';

  @override
  String get select => 'Sélectionner';

  @override
  String get matchDateRequired => 'La date du match est obligatoire';

  @override
  String get futureDateNotAllowed => 'Les dates futures ne sont pas autorisées';

  @override
  String get noMatchesThisMonth => 'Aucun match ce mois-ci';

  @override
  String get noMatchesThisMonthSubtitle =>
      'Vous n\'avez pas encore ajouté de match dans cette période';

  @override
  String get addMatch => 'Ajouter un Match';

  @override
  String get noDataToShow => 'Aucune donnée à afficher';

  @override
  String get addMatchesOrChangeRange =>
      'Ajoutez des matchs ou changez la période pour voir vos statistiques';

  @override
  String get startTrackingMatches => 'Commencez à suivre vos matchs';

  @override
  String get addFirstMatchSubtitle =>
      'Ajoutez votre premier match de padel et commencez à suivre vos progrès';

  @override
  String get tryChangingTimeRange =>
      'Essayez de changer la période pour voir d\'autres matchs';

  @override
  String get noMatchesAddedYet => 'Vous n\'avez pas encore ajouté de matchs';

  @override
  String get startByAddingFirstMatch =>
      'Commencez par enregistrer votre premier match de padel';

  @override
  String get noStatsYet => 'Aucune statistique pour le moment';

  @override
  String get noDataForThisPeriod => 'Aucune donnée pour cette période';

  @override
  String get changeRangeToSeeOtherStats =>
      'Changez la période pour voir les statistiques d\'autres matchs';

  @override
  String get lastMatch => 'Dernier match';

  @override
  String get friendly => 'Amical';

  @override
  String get league => 'Championnat';

  @override
  String get tournament => 'Tournoi';

  @override
  String get straightSets => 'Sets consécutifs';

  @override
  String get onboardingTitle1 => 'Suivez vos matchs de padel';

  @override
  String get onboardingSubtitle1 =>
      'Enregistrez vos matchs, résultats et types de jeu facilement';

  @override
  String get onboardingTitle2 => 'Analysez vos progrès';

  @override
  String get onboardingSubtitle2 =>
      'Consultez les statistiques par mois, types de match et performance';

  @override
  String get onboardingTitle3 => 'Commencez quand vous voulez';

  @override
  String get onboardingSubtitle3 =>
      'Ajoutez des matchs manuellement et consultez votre historique quand vous en avez besoin';

  @override
  String get getStarted => 'Commencer';

  @override
  String get next => 'Suivant';

  @override
  String get welcomeTo => 'Bienvenue à';

  @override
  String get addFirstMatch => 'Ajouter premier match';

  @override
  String get optional => 'optionnel';

  @override
  String get performanceRatingHelper =>
      'Comment avez-vous ressenti votre performance dans ce match?';

  @override
  String matchesPlural(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count matchs',
      one: '1 match',
    );
    return '$_temp0';
  }
}
