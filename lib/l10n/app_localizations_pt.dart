// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Padel Tracker';

  @override
  String get homeTitle => 'Início';

  @override
  String get myMatchesTitle => 'Meus Jogos';

  @override
  String get statsTitle => 'Estatísticas';

  @override
  String get addMatchTitle => 'Adicionar Jogo';

  @override
  String get cancel => 'Cancelar';

  @override
  String get saveMatch => 'Salvar Jogo';

  @override
  String get newMatch => '+ Novo Jogo';

  @override
  String get matchDetails => 'Detalhes do Jogo';

  @override
  String get matchType => 'Tipo de Jogo';

  @override
  String get playingSide => 'Lado de Jogo';

  @override
  String get players => 'Jogadores';

  @override
  String get partnerName => 'Nome do Parceiro';

  @override
  String get opponent1Name => 'Nome Adversário 1';

  @override
  String get opponent2Name => 'Nome Adversário 2';

  @override
  String get additionalDetails => 'Detalhes Adicionais';

  @override
  String get location => 'Local';

  @override
  String get locationHint => 'ex. Clube de Padel';

  @override
  String get hours => 'Horas';

  @override
  String get minutes => 'Minutos';

  @override
  String get sets => 'Sets';

  @override
  String get performanceRating => 'Avaliação de Desempenho';

  @override
  String get matchTypeFriendly => 'AMISTOSO';

  @override
  String get matchTypeLeague => 'LIGA';

  @override
  String get matchTypeTournament => 'TORNEIO';

  @override
  String get playingSideRight => 'DIREITA';

  @override
  String get playingSideLeft => 'ESQUERDA';

  @override
  String get matchTypeFriendlyDisplay => 'Amistoso';

  @override
  String get matchTypeLeagueDisplay => 'Liga';

  @override
  String get matchTypeTournamentDisplay => 'Torneio';

  @override
  String get win => 'Vitória';

  @override
  String get loss => 'Derrota';

  @override
  String get draw => 'Empate';

  @override
  String get noMatchesYet => 'Nenhum jogo ainda';

  @override
  String get startTrackingJourney => 'Comece a acompanhar sua jornada no padel';

  @override
  String get noMatchesInPeriod => 'Nenhum jogo neste período';

  @override
  String get tryDifferentTimeRange =>
      'Tente selecionar um período de tempo diferente';

  @override
  String get tapToAddFirstMatch => 'Toque + para adicionar seu primeiro jogo';

  @override
  String get tryDifferentTimeRangeStats =>
      'Tente selecionar um período diferente para ver suas estatísticas';

  @override
  String get addMatchesToSeeStats =>
      'Adicione jogos para começar a ver suas estatísticas de desempenho';

  @override
  String matchesCount(int count) {
    return '$count jogos';
  }

  @override
  String get matchDeleted => 'Jogo excluído';

  @override
  String get undo => 'Desfazer';

  @override
  String get retry => 'Tentar novamente';

  @override
  String error(String message) {
    return 'Erro: $message';
  }

  @override
  String get atLeastOneSetRequired => 'Pelo menos um set é obrigatório';

  @override
  String get officialMatchesMustHaveWinner =>
      'Jogos oficiais devem ter um vencedor (melhor de 3 sets)';

  @override
  String get yourMatchResultsSoFar => 'Seus resultados até agora';

  @override
  String get seeHowPerformingOverall =>
      'Veja como você está se saindo no geral';

  @override
  String get typesOfMatchesPlayMost =>
      'Os tipos de jogos que você joga mais frequentemente';

  @override
  String get howPerformingRecently => 'Como você tem se saído recentemente';

  @override
  String get consistencyCurrentForm => 'Sua consistência e forma atual';

  @override
  String get youMostlyPlayFriendly =>
      'Você joga principalmente jogos amistosos';

  @override
  String get youFocusOnLeague => 'Você se concentra em jogos de liga';

  @override
  String get youCompeteInTournaments =>
      'Você compete frequentemente em torneios';

  @override
  String get yourMatchTypes => 'Seus tipos de jogos';

  @override
  String get resultsDistribution => 'Distribuição de Resultados';

  @override
  String get wins => 'Vitórias';

  @override
  String get losses => 'Derrotas';

  @override
  String get draws => 'Empates';

  @override
  String get noScore => 'Sem pontuação';

  @override
  String get navigationHome => 'Início';

  @override
  String get navigationMatches => 'Jogos';

  @override
  String get navigationStats => 'Estatísticas';

  @override
  String get lastMonth => 'Último Mês';

  @override
  String get lastThreeMonths => 'Últimos 3 Meses';

  @override
  String get lastYear => 'Último Ano';

  @override
  String get allTime => 'Todo o Tempo';

  @override
  String get duration => 'Duração';

  @override
  String get notSet => 'Não definido';

  @override
  String get yourPadelJourneyBeginsHere => 'Sua jornada no padel começa aqui';

  @override
  String get oneMatchPlayed => '1 jogo jogado';

  @override
  String get victory => 'Vitória';

  @override
  String get victories => 'vitórias';

  @override
  String get defeat => 'Derrota';

  @override
  String get defeats => 'derrotas';

  @override
  String get recentPerformance => 'DESEMPENHO RECENTE';

  @override
  String winRateExcludingDraws(int percentage) {
    return 'Taxa de vitória (excluindo empates): $percentage%';
  }

  @override
  String lastMatchesWithResults(int count, String results) {
    return 'Últimos $count jogos · $results';
  }

  @override
  String drawResult(int setsWon, int setsLost) {
    return 'Empate ($setsWon–$setsLost)';
  }

  @override
  String winResult(int setsWon, int setsLost) {
    return 'Vitória ($setsWon–$setsLost)';
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
  String get readyToStart => 'Pronto para começar';

  @override
  String get perfectStart => 'Início perfeito';

  @override
  String get undefeatedSoFar => 'Invicto até agora';

  @override
  String get firstMatchDone => 'Primeiro jogo concluído';

  @override
  String get stillFindingRhythm => 'Ainda encontrando seu ritmo';

  @override
  String get strongPerformance => 'Desempenho forte';

  @override
  String get buildingExperience => 'Construindo experiência';

  @override
  String get balancedPerformance => 'Desempenho equilibrado';

  @override
  String get goodMomentum => 'Bom momento';

  @override
  String get learningAndImproving => 'Aprendendo e melhorando';

  @override
  String get steadyProgress => 'Progresso constante';

  @override
  String get matchUpdatedSuccessfully => 'Jogo atualizado com sucesso';

  @override
  String errorUpdatingMatch(String error) {
    return 'Erro ao atualizar jogo: $error';
  }

  @override
  String errorGeneric(String error) {
    return 'Erro: $error';
  }

  @override
  String get performanceInsights => 'Insights de Desempenho';

  @override
  String get avgRating => 'Avaliação Média';

  @override
  String get recentForm => 'Forma Recente';

  @override
  String get howYouRatePerformance => 'Como você avalia seu próprio desempenho';

  @override
  String winsInLastMatches(int count) {
    return 'Vitórias em seus últimos $count jogos';
  }

  @override
  String get yourTeam => 'Seu Time';

  @override
  String get opponentTeam => 'Time Adversário';

  @override
  String get you => 'Você';

  @override
  String get player1 => 'Jogador 1';

  @override
  String get player2 => 'Jogador 2';

  @override
  String get edit => 'Editar';

  @override
  String get performance => 'Desempenho';

  @override
  String get matchDate => 'Data do Jogo';

  @override
  String get selectMatchDate => 'Selecionar Data do Jogo';

  @override
  String get select => 'Selecionar';

  @override
  String get matchDateRequired => 'A data do jogo é obrigatória';

  @override
  String get futureDateNotAllowed => 'Datas futuras não são permitidas';

  @override
  String get noMatchesThisMonth => 'Nenhum jogo este mês';

  @override
  String get noMatchesThisMonthSubtitle =>
      'Você ainda não adicionou nenhum jogo neste período';

  @override
  String get addMatch => 'Adicionar Jogo';

  @override
  String get noDataToShow => 'Nenhum dado para mostrar';

  @override
  String get addMatchesOrChangeRange =>
      'Adicione jogos ou altere o período de tempo para ver suas estatísticas';

  @override
  String get startTrackingMatches => 'Comece a rastrear seus jogos';

  @override
  String get addFirstMatchSubtitle =>
      'Adicione seu primeiro jogo de padel e comece a acompanhar seu progresso';

  @override
  String get tryChangingTimeRange =>
      'Tente alterar o período de tempo para ver outros jogos';

  @override
  String get noMatchesAddedYet => 'Você ainda não adicionou nenhum jogo';

  @override
  String get startByAddingFirstMatch =>
      'Comece registrando seu primeiro jogo de padel';

  @override
  String get noStatsYet => 'Nenhuma estatística ainda';

  @override
  String get noDataForThisPeriod => 'Nenhum dado para este período';

  @override
  String get changeRangeToSeeOtherStats =>
      'Altere o período de tempo para ver estatísticas de outros jogos';

  @override
  String get lastMatch => 'Último jogo';

  @override
  String get friendly => 'Amistoso';

  @override
  String get league => 'Liga';

  @override
  String get tournament => 'Torneio';

  @override
  String get straightSets => 'Sets diretos';

  @override
  String get onboardingTitle1 => 'Acompanhe seus jogos de padel';

  @override
  String get onboardingSubtitle1 =>
      'Salve seus jogos, resultados e tipos de partida facilmente';

  @override
  String get onboardingTitle2 => 'Analise seu progresso';

  @override
  String get onboardingSubtitle2 =>
      'Consulte estatísticas por meses, tipos de jogo e desempenho';

  @override
  String get onboardingTitle3 => 'Comece quando quiser';

  @override
  String get onboardingSubtitle3 =>
      'Adicione jogos manualmente e revise seu histórico quando precisar';

  @override
  String get getStarted => 'Começar';

  @override
  String get next => 'Próximo';

  @override
  String get welcomeTo => 'Bem-vindo ao';

  @override
  String get addFirstMatch => 'Adicionar primeiro jogo';

  @override
  String get optional => 'opcional';

  @override
  String get performanceRatingHelper =>
      'Como você se sentiu sobre seu desempenho nesta partida?';

  @override
  String matchesPlural(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count partidas',
      one: '1 partida',
    );
    return '$_temp0';
  }
}
