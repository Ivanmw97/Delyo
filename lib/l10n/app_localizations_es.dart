// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'DelYo';

  @override
  String get homeTitle => 'Inicio';

  @override
  String get myMatchesTitle => 'Mis Partidos';

  @override
  String get statsTitle => 'Estadísticas';

  @override
  String get addMatchTitle => 'Añadir Partido';

  @override
  String get cancel => 'Cancelar';

  @override
  String get saveMatch => 'Guardar Partido';

  @override
  String get newMatch => '+ Nuevo Partido';

  @override
  String get matchDetails => 'Detalles del Partido';

  @override
  String get matchType => 'Tipo de Partido';

  @override
  String get playingSide => 'Lado de Juego';

  @override
  String get players => 'Jugadores';

  @override
  String get partnerName => 'Nombre de la Pareja';

  @override
  String get opponent1Name => 'Nombre del Rival 1';

  @override
  String get opponent2Name => 'Nombre del Rival 2';

  @override
  String get additionalDetails => 'Detalles Adicionales';

  @override
  String get location => 'Ubicación';

  @override
  String get locationHint => 'ej. Club de Pádel';

  @override
  String get hours => 'Horas';

  @override
  String get minutes => 'Minutos';

  @override
  String get sets => 'Sets';

  @override
  String get performanceRating => 'Valoración del Rendimiento';

  @override
  String get matchTypeFriendly => 'AMISTOSO';

  @override
  String get matchTypeLeague => 'LIGA';

  @override
  String get matchTypeTournament => 'TORNEO';

  @override
  String get playingSideRight => 'DERECHA';

  @override
  String get playingSideLeft => 'IZQUIERDA';

  @override
  String get matchTypeFriendlyDisplay => 'Amistoso';

  @override
  String get matchTypeLeagueDisplay => 'Liga';

  @override
  String get matchTypeTournamentDisplay => 'Torneo';

  @override
  String get win => 'Victoria';

  @override
  String get loss => 'Derrota';

  @override
  String get draw => 'Empate';

  @override
  String get noMatchesYet => 'Aún no hay partidos';

  @override
  String get startTrackingJourney =>
      'Comienza a seguir tu trayectoria en el pádel';

  @override
  String get noMatchesInPeriod => 'No hay partidos en este período';

  @override
  String get tryDifferentTimeRange =>
      'Prueba seleccionando un rango de tiempo diferente';

  @override
  String get tapToAddFirstMatch => 'Toca + para añadir tu primer partido';

  @override
  String get tryDifferentTimeRangeStats =>
      'Prueba seleccionando un rango de tiempo diferente para ver tus estadísticas';

  @override
  String get addMatchesToSeeStats =>
      'Añade algunos partidos para ver tus estadísticas';

  @override
  String matchesCount(int count) {
    return '$count partidos';
  }

  @override
  String get matchDeleted => 'Partido eliminado';

  @override
  String get undo => 'Deshacer';

  @override
  String get retry => 'Reintentar';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String get atLeastOneSetRequired => 'Se requiere al menos un set';

  @override
  String get officialMatchesMustHaveWinner =>
      'Los partidos oficiales deben tener un ganador (mejor de 3 sets)';

  @override
  String get yourMatchResultsSoFar => 'Tus resultados de partidos hasta ahora';

  @override
  String get seeHowPerformingOverall =>
      'Ve cómo has estado rindiendo en general';

  @override
  String get typesOfMatchesPlayMost =>
      'Los tipos de partidos que juegas más a menudo';

  @override
  String get howPerformingRecently => 'Cómo has estado rindiendo recientemente';

  @override
  String get consistencyCurrentForm => 'Tu consistencia y forma actual';

  @override
  String get youMostlyPlayFriendly =>
      'Principalmente juegas partidos amistosos';

  @override
  String get youFocusOnLeague => 'Te enfocas en partidos de liga';

  @override
  String get youCompeteInTournaments => 'Compites en torneos frecuentemente';

  @override
  String get yourMatchTypes => 'Tus tipos de partidos';

  @override
  String get resultsDistribution => 'Distribución de Resultados';

  @override
  String get matchTypesBreakdown => 'Tipos de Partidos';

  @override
  String get wins => 'Victorias';

  @override
  String get losses => 'Derrotas';

  @override
  String get draws => 'Empates';

  @override
  String get noScore => 'Sin puntuación';

  @override
  String get navigationHome => 'Inicio';

  @override
  String get navigationMatches => 'Partidos';

  @override
  String get navigationStats => 'Estadísticas';

  @override
  String get lastMonth => 'Último Mes';

  @override
  String get lastThreeMonths => 'Últimos 3 Meses';

  @override
  String get lastYear => 'Último Año';

  @override
  String get allTime => 'Todo el Tiempo';

  @override
  String get duration => 'Duración';

  @override
  String get notSet => 'No establecido';

  @override
  String get yourPadelJourneyBeginsHere => 'Tu viaje en el pádel comienza aquí';

  @override
  String get oneMatchPlayed => '1 partido jugado';

  @override
  String get victory => 'victoria';

  @override
  String get victories => 'victorias';

  @override
  String get defeat => 'derrota';

  @override
  String get defeats => 'derrotas';

  @override
  String get recentPerformance => 'RENDIMIENTO RECIENTE';

  @override
  String winRateExcludingDraws(int percentage) {
    return 'Porcentaje de victorias (excluyendo empates): $percentage%';
  }

  @override
  String lastMatchesWithResults(int count, String results) {
    return 'Últimos $count partidos · $results';
  }

  @override
  String drawResult(int setsWon, int setsLost) {
    return 'Empate ($setsWon–$setsLost)';
  }

  @override
  String winResult(int setsWon, int setsLost) {
    return 'Victoria ($setsWon–$setsLost)';
  }

  @override
  String lossResult(int setsWon, int setsLost) {
    return 'Derrota ($setsWon–$setsLost)';
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
  String get readyToStart => 'Listo para empezar';

  @override
  String get perfectStart => 'Inicio perfecto';

  @override
  String get undefeatedSoFar => 'Invicto hasta ahora';

  @override
  String get firstMatchDone => 'Primer partido completado';

  @override
  String get stillFindingRhythm => 'Aún encontrando tu ritmo';

  @override
  String get strongPerformance => 'Rendimiento sólido';

  @override
  String get buildingExperience => 'Construyendo experiencia';

  @override
  String get balancedPerformance => 'Rendimiento equilibrado';

  @override
  String get goodMomentum => 'Buen impulso';

  @override
  String get learningAndImproving => 'Aprendiendo y mejorando';

  @override
  String get steadyProgress => 'Progreso constante';

  @override
  String get matchUpdatedSuccessfully => 'Partido actualizado exitosamente';

  @override
  String errorUpdatingMatch(String error) {
    return 'Error al actualizar partido: $error';
  }

  @override
  String errorGeneric(String error) {
    return 'Error: $error';
  }

  @override
  String get performanceInsights => 'Información de Rendimiento';

  @override
  String get avgRating => 'Calificación Promedio';

  @override
  String get recentForm => 'Forma Reciente';

  @override
  String get howYouRatePerformance => 'Cómo calificas tu propio rendimiento';

  @override
  String winsInLastMatches(int count) {
    return 'Victorias en tus últimos $count partidos';
  }

  @override
  String get yourTeam => 'Tu Equipo';

  @override
  String get opponentTeam => 'Equipo Rival';

  @override
  String get you => 'Tú';

  @override
  String get player1 => 'Jugador 1';

  @override
  String get player2 => 'Jugador 2';

  @override
  String get edit => 'Editar';

  @override
  String get performance => 'Rendimiento';

  @override
  String get matchDate => 'Fecha del Partido';

  @override
  String get selectMatchDate => 'Seleccionar Fecha del Partido';

  @override
  String get select => 'Seleccionar';

  @override
  String get matchDateRequired => 'La fecha del partido es obligatoria';

  @override
  String get futureDateNotAllowed => 'No se permiten fechas futuras';

  @override
  String get noMatchesThisMonth => 'No tienes partidos este mes';

  @override
  String get noMatchesThisMonthSubtitle =>
      'Aún no has añadido ningún partido en este periodo';

  @override
  String get addMatch => 'Añadir Partido';

  @override
  String get noDataToShow => 'No hay datos para mostrar';

  @override
  String get addMatchesOrChangeRange =>
      'Añade partidos o cambia el rango de tiempo para ver tus estadísticas';

  @override
  String get startTrackingMatches => 'Empieza a registrar tus partidos';

  @override
  String get addFirstMatchSubtitle =>
      'Añade tu primer partido de pádel y empieza a seguir tu progreso';

  @override
  String get tryChangingTimeRange =>
      'Prueba cambiando el rango de tiempo para ver otros partidos';

  @override
  String get noMatchesAddedYet => 'Aún no has añadido ningún partido';

  @override
  String get startByAddingFirstMatch =>
      'Empieza registrando tu primer partido de pádel';

  @override
  String get noStatsYet => 'Aún no hay estadísticas';

  @override
  String get noDataForThisPeriod => 'No hay datos para este periodo';

  @override
  String get changeRangeToSeeOtherStats =>
      'Cambia el rango de tiempo para ver estadísticas de otros partidos';

  @override
  String get lastMatch => 'Último partido';

  @override
  String get friendly => 'Amistoso';

  @override
  String get league => 'Liga';

  @override
  String get tournament => 'Torneo';

  @override
  String get straightSets => 'Marcador';

  @override
  String get onboardingTitle1 => 'Registra tus partidos de pádel';

  @override
  String get onboardingSubtitle1 =>
      'Guarda tus partidos, resultados y tipo de juego de forma sencilla';

  @override
  String get onboardingTitle2 => 'Analiza tu progreso';

  @override
  String get onboardingSubtitle2 =>
      'Consulta estadísticas por meses, tipos de partido y rendimiento';

  @override
  String get onboardingTitle3 => 'Empieza cuando quieras';

  @override
  String get onboardingSubtitle3 =>
      'Añade partidos manualmente y revisa tu historial cuando lo necesites';

  @override
  String get getStarted => 'Empezar';

  @override
  String get next => 'Siguiente';

  @override
  String get welcomeTo => 'Bienvenido a';

  @override
  String get addFirstMatch => 'Añadir Primer Partido';

  @override
  String get optional => 'opcional';

  @override
  String get performanceRatingHelper =>
      '¿Cómo sentiste tu nivel en este partido?';

  @override
  String matchesPlural(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count partidos',
      one: '1 partido',
    );
    return '$_temp0';
  }
}
