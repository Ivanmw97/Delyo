import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padel_tracker/domain/models/match.dart';
import 'package:padel_tracker/domain/models/match_result.dart';
import 'package:padel_tracker/domain/models/padel_set.dart';
import 'package:padel_tracker/domain/models/player.dart';
import 'package:padel_tracker/domain/enums/match_type.dart';
import 'package:padel_tracker/domain/enums/playing_side.dart';
import 'package:padel_tracker/features/matches/state/matches_provider.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';
import 'package:padel_tracker/features/matches/presentation/widgets/add_match/section_card.dart';
import 'package:padel_tracker/features/matches/presentation/widgets/add_match/custom_text_field.dart';
import 'package:padel_tracker/features/matches/presentation/widgets/add_match/custom_dropdown_field.dart';
import 'package:padel_tracker/features/matches/presentation/widgets/add_match/set_card.dart';
import 'package:padel_tracker/features/matches/presentation/widgets/add_match/add_set_button.dart';
import 'package:padel_tracker/features/matches/presentation/widgets/add_match/date_picker_field.dart';
import 'package:padel_tracker/utils/date_formatter.dart';

class AddMatchPage extends ConsumerStatefulWidget {
  const AddMatchPage({super.key});

  @override
  ConsumerState<AddMatchPage> createState() => _AddMatchPageState();
}

class _PadelSetDraft {
  final TextEditingController userGamesController;
  final TextEditingController opponentGamesController;

  _PadelSetDraft({String userGames = '', String opponentGames = ''})
    : userGamesController = TextEditingController(text: userGames),
      opponentGamesController = TextEditingController(text: opponentGames);

  void dispose() {
    userGamesController.dispose();
    opponentGamesController.dispose();
  }

  int get userGames => int.tryParse(userGamesController.text) ?? 0;
  int get opponentGames => int.tryParse(opponentGamesController.text) ?? 0;

  bool get isUserWinner => userGames > opponentGames;
}

class _AddMatchPageState extends ConsumerState<AddMatchPage> {
  final _partnerNameController = TextEditingController(text: 'Paquito Navarro');
  late final TextEditingController _opponent1NameController;
  late final TextEditingController _opponent2NameController;
  final _locationController = TextEditingController();
  final _durationHoursController = TextEditingController();
  final _durationMinutesController = TextEditingController();

  final List<_PadelSetDraft> _sets = [];

  MatchType _selectedMatchType = MatchType.friendly;
  PlayingSide _selectedPlayingSide = PlayingSide.right;
  int _performanceRating = 3;
  bool _isSubmitting = false;

  // Match date - defaults to today
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize with temporary values, will be updated in didChangeDependencies
    _opponent1NameController = TextEditingController(text: 'Player 1');
    _opponent2NameController = TextEditingController(text: 'Player 2');
    // Initialize selected date to today
    _selectedDate = DateFormatter.dateOnly(DateTime.now());
    _initializeSets();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update with localized text once context is available
    if (_opponent1NameController.text == 'Player 1') {
      _opponent1NameController.text = AppLocalizations.of(context)!.player1;
    }
    if (_opponent2NameController.text == 'Player 2') {
      _opponent2NameController.text = AppLocalizations.of(context)!.player2;
    }
  }

  void _initializeSets() {
    _sets.clear();
    if (_isOfficialMatch) {
      // Official matches (league/tournament): start with 2 sets (best of 3)
      _sets.add(_PadelSetDraft(userGames: '6', opponentGames: '4'));
      _sets.add(_PadelSetDraft(userGames: '6', opponentGames: '3'));
    } else {
      // Friendly matches: start with 1 set
      _sets.add(_PadelSetDraft(userGames: '6', opponentGames: '4'));
    }
  }

  bool get _isOfficialMatch {
    return _selectedMatchType == MatchType.league ||
        _selectedMatchType == MatchType.tournament;
  }

  @override
  void dispose() {
    _partnerNameController.dispose();
    _opponent1NameController.dispose();
    _opponent2NameController.dispose();
    _locationController.dispose();
    _durationHoursController.dispose();
    _durationMinutesController.dispose();
    for (var set in _sets) {
      set.dispose();
    }
    super.dispose();
  }

  void _onMatchTypeChanged(MatchType? newType) {
    if (newType == null || newType == _selectedMatchType) return;

    setState(() {
      for (var set in _sets) {
        set.dispose();
      }
      _selectedMatchType = newType;
      _initializeSets();
    });
  }

  void _syncOfficialSets() {
    if (!_isOfficialMatch || _sets.length < 2) return;

    int userSetsWon = _sets.take(2).where((s) => s.isUserWinner).length;
    int opponentSetsWon = 2 - userSetsWon;

    bool isSplit = userSetsWon == 1 && opponentSetsWon == 1;
    bool shouldHaveThirdSet = isSplit;
    bool hasThirdSet = _sets.length == 3;

    if (shouldHaveThirdSet && !hasThirdSet) {
      // Add third set
      _sets.add(_PadelSetDraft());
    } else if (!shouldHaveThirdSet && hasThirdSet) {
      // Remove third set
      _sets[2].dispose();
      _sets.removeAt(2);
    }
  }

  bool get _canAddSet {
    if (_isOfficialMatch) {
      // Official matches: sets are auto-managed, no manual add
      return false;
    } else {
      // Friendly matches: unlimited sets
      return true;
    }
  }

  bool get _canRemoveSet {
    if (_isOfficialMatch) {
      // Official matches: sets are auto-managed, no manual remove
      return false;
    } else {
      // Friendly matches: can remove sets (minimum 1)
      return _sets.length > 1;
    }
  }

  void _addSet() {
    if (_canAddSet) {
      setState(() {
        _sets.add(_PadelSetDraft());
      });
    }
  }

  void _removeSet(int index) {
    if (_canRemoveSet && index < _sets.length) {
      setState(() {
        _sets[index].dispose();
        _sets.removeAt(index);
      });
    }
  }

  String? _getDateValidationError() {
    if (DateFormatter.isFutureDate(_selectedDate)) {
      return AppLocalizations.of(context)!.futureDateNotAllowed;
    }
    return null;
  }

  String? _validateMatch() {
    // Validate date first
    final dateError = _getDateValidationError();
    if (dateError != null) {
      return dateError;
    }

    if (_sets.isEmpty) {
      return AppLocalizations.of(context)!.atLeastOneSetRequired;
    }

    if (_isOfficialMatch) {
      // Official matches must have a clear winner
      int userSetsWon = _sets.where((s) => s.isUserWinner).length;
      int opponentSetsWon = _sets.length - userSetsWon;

      bool hasWinner = userSetsWon >= 2 || opponentSetsWon >= 2;
      if (!hasWinner) {
        return AppLocalizations.of(context)!.officialMatchesMustHaveWinner;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addMatchTitle,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1D1D1F),
          ),
        ),
        backgroundColor: const Color(0xFFF8F8F8),
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SectionCard(
                    title: AppLocalizations.of(context)!.matchDetails,
                    icon: Icons.info_outline,
                    children: [
                      DatePickerField(
                        selectedDate: _selectedDate,
                        onDateSelected: (date) {
                          setState(() {
                            _selectedDate = date;
                          });
                        },
                        label: AppLocalizations.of(context)!.matchDate,
                        errorText: _getDateValidationError(),
                      ),
                      const SizedBox(height: 16),
                      CustomDropdownField<MatchType>(
                        label: AppLocalizations.of(context)!.matchType,
                        value: _selectedMatchType,
                        items: MatchType.values
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(_getMatchTypeName(type, context)),
                              ),
                            )
                            .toList(),
                        onChanged: _onMatchTypeChanged,
                      ),
                      const SizedBox(height: 16),
                      CustomDropdownField<PlayingSide>(
                        label: AppLocalizations.of(context)!.playingSide,
                        value: _selectedPlayingSide,
                        items: PlayingSide.values
                            .map(
                              (side) => DropdownMenuItem(
                                value: side,
                                child: Text(_getPlayingSideName(side, context)),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedPlayingSide = value);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  SectionCard(
                    title: AppLocalizations.of(context)!.players,
                    icon: Icons.people_outline,
                    children: [
                      CustomTextField(
                        controller: _partnerNameController,
                        label: AppLocalizations.of(context)!.partnerName,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _opponent1NameController,
                        label: AppLocalizations.of(context)!.opponent1Name,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _opponent2NameController,
                        label: AppLocalizations.of(context)!.opponent2Name,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  SectionCard(
                    title: AppLocalizations.of(context)!.additionalDetails,
                    icon: Icons.more_horiz,
                    children: [
                      CustomTextField(
                        controller: _locationController,
                        label: AppLocalizations.of(context)!.location,
                        hint: AppLocalizations.of(context)!.locationHint,
                        isOptional: true,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _durationHoursController,
                              label: AppLocalizations.of(context)!.hours,
                              hint: '1',
                              keyboardType: TextInputType.number,
                              isOptional: true,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              controller: _durationMinutesController,
                              label: AppLocalizations.of(context)!.minutes,
                              hint: '30',
                              keyboardType: TextInputType.number,
                              isOptional: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  SectionCard(
                    title: AppLocalizations.of(context)!.sets,
                    icon: Icons.sports_tennis,
                    actionWidget: _canAddSet
                        ? AddSetButton(onTap: _addSet)
                        : null,
                    children: [
                      ..._sets.asMap().entries.map((entry) {
                        final index = entry.key;
                        final set = entry.value;
                        return SetCard(
                          index: index,
                          userGamesController: set.userGamesController,
                          opponentGamesController: set.opponentGamesController,
                          canRemove: _canRemoveSet,
                          onRemove: () => _removeSet(index),
                        );
                      }).toList(),
                    ],
                  ),
                  const SizedBox(height: 20),

                  SectionCard(
                    title: AppLocalizations.of(context)!.performanceRating,
                    icon: Icons.star_outline,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.performanceRatingHelper,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF1D1D1F).withOpacity(0.6),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final rating = index + 1;
                          return IconButton(
                            icon: Icon(
                              rating <= _performanceRating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: const Color(0xFFFF9500),
                              size: 36,
                            ),
                            onPressed: () {
                              setState(() => _performanceRating = rating);
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
                border: Border(
                  top: BorderSide(color: Color(0xFFE5E5EA), width: 0.5),
                ),
              ),
              child: _buildSaveButton(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitMatch() async {
    final validationError = _validateMatch();
    if (validationError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationError), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // Parse duration from input fields
      Duration? matchDuration;
      final hours = int.tryParse(_durationHoursController.text.trim()) ?? 0;
      final minutes = int.tryParse(_durationMinutesController.text.trim()) ?? 0;
      if (hours > 0 || minutes > 0) {
        matchDuration = Duration(hours: hours, minutes: minutes);
      }

      // Get location from input field
      final location = _locationController.text.trim().isEmpty
          ? null
          : _locationController.text.trim();

      final match = Match(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        matchType: _selectedMatchType,
        dateTime: _selectedDate,
        playingSide: _selectedPlayingSide,
        partner: Player(
          id: 'partner_${DateTime.now().millisecondsSinceEpoch}',
          name: _partnerNameController.text.trim(),
        ),
        opponent1: Player(
          id: 'opp1_${DateTime.now().millisecondsSinceEpoch}',
          name: _opponent1NameController.text.trim(),
        ),
        opponent2: Player(
          id: 'opp2_${DateTime.now().millisecondsSinceEpoch}',
          name: _opponent2NameController.text.trim(),
        ),
        result: MatchResult(
          sets: _sets
              .map(
                (set) => PadelSet(
                  userTeamGames: set.userGames,
                  opponentTeamGames: set.opponentGames,
                ),
              )
              .toList(),
        ),
        performanceRating: _performanceRating,
        duration: matchDuration,
        location: location,
      );

      await ref.read(matchesProvider.notifier).addMatch(match);

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.errorGeneric(e.toString()),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  String _getMatchTypeName(MatchType type, BuildContext context) {
    switch (type) {
      case MatchType.friendly:
        return AppLocalizations.of(context)!.matchTypeFriendly;
      case MatchType.league:
        return AppLocalizations.of(context)!.matchTypeLeague;
      case MatchType.tournament:
        return AppLocalizations.of(context)!.matchTypeTournament;
    }
  }

  String _getPlayingSideName(PlayingSide side, BuildContext context) {
    switch (side) {
      case PlayingSide.right:
        return AppLocalizations.of(context)!.playingSideRight;
      case PlayingSide.left:
        return AppLocalizations.of(context)!.playingSideLeft;
    }
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: _isSubmitting
            ? const Color(0xFF007AFF).withOpacity(0.6)
            : const Color(0xFF007AFF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _isSubmitting ? null : _submitMatch,
          child: Center(
            child: _isSubmitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    AppLocalizations.of(context)!.saveMatch,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
