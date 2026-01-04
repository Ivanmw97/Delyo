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
import 'package:padel_tracker/features/matches/presentation/widgets/match_detail/hero_section_widget.dart';
import 'package:padel_tracker/features/matches/presentation/widgets/match_detail/players_card_widget.dart';
import 'package:padel_tracker/features/matches/presentation/widgets/match_detail/match_info_card_widget.dart';
import 'package:padel_tracker/features/matches/presentation/widgets/match_detail/performance_card_widget.dart';
import 'package:padel_tracker/features/matches/presentation/widgets/add_match/date_picker_field.dart';
import 'package:padel_tracker/utils/date_formatter.dart';

class MatchDetailPage extends ConsumerStatefulWidget {
  final Match match;

  const MatchDetailPage({super.key, required this.match});

  @override
  ConsumerState<MatchDetailPage> createState() => _MatchDetailPageState();
}

class _MatchDetailPageState extends ConsumerState<MatchDetailPage> {
  bool _isEditMode = false;
  bool _isSubmitting = false;

  // Controllers for edit mode
  late TextEditingController _partnerNameController;
  late TextEditingController _opponent1NameController;
  late TextEditingController _opponent2NameController;
  late TextEditingController _locationController;
  late TextEditingController _durationHoursController;
  late TextEditingController _durationMinutesController;

  late MatchType _selectedMatchType;
  late PlayingSide _selectedPlayingSide;
  late int _performanceRating;
  late List<_PadelSetDraft> _sets;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _partnerNameController = TextEditingController(
      text: widget.match.partner.name,
    );
    _opponent1NameController = TextEditingController(
      text: widget.match.opponent1.name,
    );
    _opponent2NameController = TextEditingController(
      text: widget.match.opponent2.name,
    );
    _locationController = TextEditingController(
      text: widget.match.location ?? '',
    );

    final duration = widget.match.duration;
    _durationHoursController = TextEditingController(
      text: duration != null ? duration.inHours.toString() : '',
    );
    _durationMinutesController = TextEditingController(
      text: duration != null ? (duration.inMinutes % 60).toString() : '',
    );

    _selectedMatchType = widget.match.matchType;
    _selectedPlayingSide = widget.match.playingSide;
    _performanceRating = widget.match.performanceRating ?? 3;
    _selectedDate = DateFormatter.dateOnly(widget.match.dateTime);

    _sets = widget.match.result.sets
        .map(
          (set) => _PadelSetDraft(
            userGames: set.userTeamGames.toString(),
            opponentGames: set.opponentTeamGames.toString(),
          ),
        )
        .toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.matchDetails,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1D1D1F),
          ),
        ),
        backgroundColor: const Color(0xFFF8F8F8),
        elevation: 0,
        centerTitle: false,
        leading: _isEditMode
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _cancelEdit,
              )
            : null,
        actions: _isEditMode
            ? []
            : [
                TextButton(
                  onPressed: _toggleEditMode,
                  child: Text(
                    AppLocalizations.of(context)!.edit,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF007AFF),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
      ),
      body: _isEditMode ? _buildEditMode() : _buildViewMode(),
    );
  }

  Widget _buildViewMode() {
    // Get the current match from provider
    final matchesState = ref.watch(matchesProvider);
    final currentMatch = matchesState.matches.firstWhere(
      (m) => m.id == widget.match.id,
      orElse: () => widget.match, // Fallback to original if not found
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero Section - No card, direct content
          HeroSectionWidget(match: currentMatch),
          const SizedBox(height: 32),

          // Content with padding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PlayersCardWidget(match: currentMatch),
                const SizedBox(height: 20),
                MatchInfoCardWidget(match: currentMatch),
                const SizedBox(height: 20),
                PerformanceCardWidget(match: currentMatch),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditMode() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildEditModeContent(),
            ),
          ),
        ),
        // Fixed bottom button with proper safe area handling
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
    );
  }

  // Edit mode functionality and helper methods
  List<Widget> _buildEditModeContent() {
    return [
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
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedMatchType = value);
              }
            },
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
        actionWidget: AddSetButton(onTap: _addSet),
        children: [
          ..._sets.asMap().entries.map((entry) {
            final index = entry.key;
            final set = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < _sets.length - 1 ? 16 : 0,
              ),
              child: SetCard(
                index: index,
                userGamesController: set.userGamesController,
                opponentGamesController: set.opponentGamesController,
                canRemove: _sets.length > 1,
                onRemove: () => _removeSet(index),
              ),
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
                  rating <= _performanceRating ? Icons.star : Icons.star_border,
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
    ];
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  void _cancelEdit() {
    setState(() {
      _isEditMode = false;
      // Reset all controllers to original values
      _initializeControllers();
    });
  }

  String? _getDateValidationError() {
    if (DateFormatter.isFutureDate(_selectedDate)) {
      return AppLocalizations.of(context)!.futureDateNotAllowed;
    }
    return null;
  }

  Future<void> _saveMatch() async {
    // Validate date first
    final dateError = _getDateValidationError();
    if (dateError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(dateError),
          backgroundColor: const Color(0xFFFF3B30),
        ),
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

      final updatedMatch = Match(
        id: widget.match.id, // Keep same ID
        matchType: _selectedMatchType,
        dateTime: _selectedDate, // Use selected date
        playingSide: _selectedPlayingSide,
        partner: Player(
          id: widget.match.partner.id,
          name: _partnerNameController.text.trim(),
        ),
        opponent1: Player(
          id: widget.match.opponent1.id,
          name: _opponent1NameController.text.trim(),
        ),
        opponent2: Player(
          id: widget.match.opponent2.id,
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

      // Update the match in the repository
      await ref.read(matchesProvider.notifier).updateMatch(updatedMatch);

      setState(() {
        _isEditMode = false;
        _isSubmitting = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.matchUpdatedSuccessfully,
            ),
            backgroundColor: const Color(0xFF34C759),
          ),
        );
      }
    } catch (e) {
      setState(() => _isSubmitting = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.errorUpdatingMatch(e.toString()),
            ),
            backgroundColor: const Color(0xFFFF3B30),
          ),
        );
      }
    }
  }

  void _addSet() {
    setState(() {
      _sets.add(_PadelSetDraft());
    });
  }

  void _removeSet(int index) {
    if (_sets.length > 1 && index < _sets.length) {
      setState(() {
        _sets[index].dispose();
        _sets.removeAt(index);
      });
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
          onTap: _isSubmitting ? null : _saveMatch,
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

// Helper class for managing set drafts in edit mode
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
}
