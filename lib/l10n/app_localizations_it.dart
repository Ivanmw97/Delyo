// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'DelYo';

  @override
  String get homeTitle => 'Home';

  @override
  String get myMatchesTitle => 'Le mie partite';

  @override
  String get statsTitle => 'Statistiche';

  @override
  String get addMatchTitle => 'Aggiungi partita';

  @override
  String get cancel => 'Annulla';

  @override
  String get saveMatch => 'Salva partita';

  @override
  String get newMatch => '+ Nuova partita';

  @override
  String get matchDetails => 'Dettagli della partita';

  @override
  String get matchType => 'Tipo di partita';

  @override
  String get playingSide => 'Lato di gioco';

  @override
  String get players => 'Giocatori';

  @override
  String get partnerName => 'Nome del partner';

  @override
  String get opponent1Name => 'Nome avversario 1';

  @override
  String get opponent2Name => 'Nome avversario 2';

  @override
  String get additionalDetails => 'Dettagli aggiuntivi';

  @override
  String get location => 'Luogo';

  @override
  String get locationHint => 'es. Club Padel';

  @override
  String get hours => 'Ore';

  @override
  String get minutes => 'Minuti';

  @override
  String get sets => 'Set';

  @override
  String get performanceRating => 'Valutazione della prestazione';

  @override
  String get matchTypeFriendly => 'AMICHEVOLE';

  @override
  String get matchTypeLeague => 'LEGA';

  @override
  String get matchTypeTournament => 'TORNEO';

  @override
  String get playingSideRight => 'DESTRA';

  @override
  String get playingSideLeft => 'SINISTRA';

  @override
  String get matchTypeFriendlyDisplay => 'Amichevole';

  @override
  String get matchTypeLeagueDisplay => 'Lega';

  @override
  String get matchTypeTournamentDisplay => 'Torneo';

  @override
  String get win => 'Vittoria';

  @override
  String get loss => 'Sconfitta';

  @override
  String get draw => 'Pareggio';

  @override
  String get winLetter => 'V';

  @override
  String get lossLetter => 'S';

  @override
  String get drawLetter => 'P';

  @override
  String get noMatchesYet => 'Nessuna partita ancora';

  @override
  String get startTrackingJourney =>
      'Inizia a tracciare il tuo percorso nel padel';

  @override
  String get noMatchesInPeriod => 'Nessuna partita in questo periodo';

  @override
  String get tryDifferentTimeRange =>
      'Prova a selezionare un periodo di tempo diverso';

  @override
  String get tapToAddFirstMatch =>
      'Tocca + per aggiungere la tua prima partita';

  @override
  String get tryDifferentTimeRangeStats =>
      'Prova a selezionare un intervallo di tempo diverso per vedere le statistiche';

  @override
  String get addMatchesToSeeStats =>
      'Aggiungi partite per iniziare a vedere le tue statistiche di performance';

  @override
  String matchesCount(int count) {
    return '$count partite';
  }

  @override
  String get matchDeleted => 'Partita eliminata';

  @override
  String get undo => 'Annulla';

  @override
  String get retry => 'Riprova';

  @override
  String error(String message) {
    return 'Errore: $message';
  }

  @override
  String get atLeastOneSetRequired => 'È richiesto almeno un set';

  @override
  String get officialMatchesMustHaveWinner =>
      'Le partite ufficiali devono avere un vincitore (al meglio dei 3 set)';

  @override
  String get yourMatchResultsSoFar => 'I tuoi risultati finora';

  @override
  String get seeHowPerformingOverall =>
      'Scopri come stai andando complessivamente';

  @override
  String get typesOfMatchesPlayMost =>
      'I tipi di partite che giochi più spesso';

  @override
  String get howPerformingRecently => 'Come stai andando di recente';

  @override
  String get consistencyCurrentForm => 'La tua costanza e la forma attuale';

  @override
  String get youMostlyPlayFriendly =>
      'Giochi principalmente partite amichevoli';

  @override
  String get youFocusOnLeague => 'Ti concentri sulle partite di lega';

  @override
  String get youCompeteInTournaments => 'Partecipi spesso ai tornei';

  @override
  String get yourMatchTypes => 'I tuoi tipi di partita';

  @override
  String get resultsDistribution => 'Distribuzione dei risultati';

  @override
  String get matchTypesBreakdown => 'Tipi di Partite';

  @override
  String get wins => 'Vittorie';

  @override
  String get losses => 'Sconfitte';

  @override
  String get draws => 'Pareggi';

  @override
  String get noScore => 'Nessun punteggio';

  @override
  String get navigationHome => 'Home';

  @override
  String get navigationMatches => 'Partite';

  @override
  String get navigationStats => 'Statistiche';

  @override
  String get lastMonth => 'Ultimo mese';

  @override
  String get lastThreeMonths => 'Ultimi 3 mesi';

  @override
  String get lastYear => 'Ultimo anno';

  @override
  String get allTime => 'Tutto il periodo';

  @override
  String get duration => 'Durata';

  @override
  String get notSet => 'Non impostato';

  @override
  String get yourPadelJourneyBeginsHere =>
      'Il tuo percorso nel padel inizia qui';

  @override
  String get oneMatchPlayed => '1 partita giocata';

  @override
  String get victory => 'Vittoria';

  @override
  String get victories => 'vittorie';

  @override
  String get defeat => 'Sconfitta';

  @override
  String get defeats => 'sconfitte';

  @override
  String get recentPerformance => 'PRESTAZIONI RECENTI';

  @override
  String winRateExcludingDraws(int percentage) {
    return 'Percentuale di vittorie (escludendo i pareggi): $percentage%';
  }

  @override
  String lastMatchesWithResults(int count, String results) {
    return 'Ultime $count partite · $results';
  }

  @override
  String drawResult(int setsWon, int setsLost) {
    return 'Pareggio ($setsWon–$setsLost)';
  }

  @override
  String winResult(int setsWon, int setsLost) {
    return 'Vittoria ($setsWon–$setsLost)';
  }

  @override
  String lossResult(int setsWon, int setsLost) {
    return 'Sconfitta ($setsWon–$setsLost)';
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
  String get readyToStart => 'Pronto per iniziare';

  @override
  String get perfectStart => 'Inizio perfetto';

  @override
  String get undefeatedSoFar => 'Imbattuto finora';

  @override
  String get firstMatchDone => 'Prima partita completata';

  @override
  String get stillFindingRhythm => 'Ancora alla ricerca del ritmo';

  @override
  String get strongPerformance => 'Prestazione forte';

  @override
  String get buildingExperience => 'Costruendo esperienza';

  @override
  String get balancedPerformance => 'Prestazione equilibrata';

  @override
  String get goodMomentum => 'Buon slancio';

  @override
  String get learningAndImproving => 'Imparando e migliorando';

  @override
  String get steadyProgress => 'Progresso costante';

  @override
  String get matchUpdatedSuccessfully => 'Partita aggiornata con successo';

  @override
  String errorUpdatingMatch(String error) {
    return 'Errore nell\'aggiornamento della partita: $error';
  }

  @override
  String errorGeneric(String error) {
    return 'Errore: $error';
  }

  @override
  String get performanceInsights => 'Informazioni sulle Prestazioni';

  @override
  String get avgRating => 'Valutazione Media';

  @override
  String get recentForm => 'Forma Recente';

  @override
  String get howYouRatePerformance => 'Come valuti le tue prestazioni';

  @override
  String winsInLastMatches(int count) {
    return 'Vittorie nelle tue ultime $count partite';
  }

  @override
  String get yourTeam => 'La Tua Squadra';

  @override
  String get opponentTeam => 'Squadra Avversaria';

  @override
  String get you => 'Tu';

  @override
  String get player1 => 'Giocatore 1';

  @override
  String get player2 => 'Giocatore 2';

  @override
  String get edit => 'Modifica';

  @override
  String get performance => 'Prestazione';

  @override
  String get matchDate => 'Data della Partita';

  @override
  String get selectMatchDate => 'Seleziona Data della Partita';

  @override
  String get select => 'Seleziona';

  @override
  String get matchDateRequired => 'La data della partita è obbligatoria';

  @override
  String get futureDateNotAllowed => 'Le date future non sono consentite';

  @override
  String get noMatchesThisMonth => 'Nessuna partita questo mese';

  @override
  String get noMatchesThisMonthSubtitle =>
      'Non hai ancora aggiunto nessuna partita in questo periodo';

  @override
  String get addMatch => 'Aggiungi Partita';

  @override
  String get noDataToShow => 'Nessun dato da mostrare';

  @override
  String get addMatchesOrChangeRange =>
      'Aggiungi partite o cambia il periodo di tempo per vedere le tue statistiche';

  @override
  String get startTrackingMatches => 'Inizia a registrare le tue partite';

  @override
  String get addFirstMatchSubtitle =>
      'Aggiungi la tua prima partita di padel e inizia a seguire i tuoi progressi';

  @override
  String get tryChangingTimeRange =>
      'Prova a cambiare il periodo di tempo per vedere altre partite';

  @override
  String get noMatchesAddedYet => 'Non hai ancora aggiunto nessuna partita';

  @override
  String get startByAddingFirstMatch =>
      'Inizia registrando la tua prima partita di padel';

  @override
  String get noStatsYet => 'Nessuna statistica ancora';

  @override
  String get noDataForThisPeriod => 'Nessun dato per questo periodo';

  @override
  String get changeRangeToSeeOtherStats =>
      'Cambia il periodo di tempo per vedere statistiche di altre partite';

  @override
  String get lastMatch => 'Ultima partita';

  @override
  String get friendly => 'Amichevole';

  @override
  String get league => 'Campionato';

  @override
  String get tournament => 'Torneo';

  @override
  String get straightSets => 'Set consecutivi';

  @override
  String get onboardingTitle1 => 'Traccia le tue partite di padel';

  @override
  String get onboardingSubtitle1 =>
      'Salva le tue partite, risultati e tipi di gioco facilmente';

  @override
  String get onboardingTitle2 => 'Analizza i tuoi progressi';

  @override
  String get onboardingSubtitle2 =>
      'Consulta statistiche per mesi, tipi di partita e prestazioni';

  @override
  String get onboardingTitle3 => 'Inizia quando vuoi';

  @override
  String get onboardingSubtitle3 =>
      'Aggiungi partite manualmente e rivedi la tua cronologia quando ne hai bisogno';

  @override
  String get getStarted => 'Inizia';

  @override
  String get next => 'Avanti';

  @override
  String get welcomeTo => 'Benvenuto a';

  @override
  String get addFirstMatch => 'Aggiungi prima partita';

  @override
  String get optional => 'opzionale';

  @override
  String get performanceRatingHelper =>
      'Come ti sei sentito riguardo alla tua performance in questa partita?';

  @override
  String matchesPlural(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count partite',
      one: '1 partita',
    );
    return '$_temp0';
  }
}
