import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/equipment.dart';

class EquipmentStatusCard extends StatelessWidget {
  final PaddleSetup? paddleSetup;
  final VoidCallback onAddEquipment;
  final VoidCallback onEditEquipment;
  final Function(double hours)? onLogHours;

  const EquipmentStatusCard({
    super.key,
    this.paddleSetup,
    required this.onAddEquipment,
    required this.onEditEquipment,
    this.onLogHours,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.border.withOpacity(0.5), width: 1),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 1))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.muted.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      LucideIcons.target,
                      size: isMobile ? 20 : 22,
                      color: theme.colorScheme.mutedForeground,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Моя ракетка',
                    style: theme.textTheme.h3.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 18 : 20,
                    ),
                  ),
                ],
              ),
              if (paddleSetup != null)
                ShadButton.ghost(
                  size: ShadButtonSize.sm,
                  onPressed: onEditEquipment,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(LucideIcons.pencil, size: 14),
                      const SizedBox(width: 6),
                      Text('Изменить', style: TextStyle(fontSize: isMobile ? 12 : 14)),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Content
          if (paddleSetup == null)
            _buildEmptyState(context, theme, isMobile)
          else
            _buildEquipmentInfo(context, theme, isMobile, paddleSetup!),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ShadThemeData theme, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 20 : 24),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.muted.withOpacity(0.3),
                    theme.colorScheme.muted.withOpacity(0.15),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.muted.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                LucideIcons.packageOpen,
                size: isMobile ? 36 : 40,
                color: theme.colorScheme.mutedForeground.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Оборудование не добавлено',
              style: theme.textTheme.large.copyWith(
                fontSize: isMobile ? 15 : 16,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.mutedForeground,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Добавьте информацию о вашей ракетке',
              style: theme.textTheme.muted.copyWith(
                fontSize: isMobile ? 13 : 14,
                color: theme.colorScheme.mutedForeground.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 20),
            ShadButton(
              size: isMobile ? ShadButtonSize.sm : ShadButtonSize.regular,
              onPressed: onAddEquipment,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(LucideIcons.plus, size: 16),
                  SizedBox(width: 8),
                  Text('Добавить ракетку'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEquipmentInfo(
    BuildContext context,
    ShadThemeData theme,
    bool isMobile,
    PaddleSetup setup,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Название ракетки с основанием
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withOpacity(0.08),
                theme.colorScheme.muted.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.primary.withOpacity(0.2), width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary.withOpacity(0.8),
                      theme.colorScheme.primary.withOpacity(0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  LucideIcons.zap,
                  size: isMobile ? 18 : 20,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      setup.name,
                      style: theme.textTheme.h4.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 16 : 18,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.muted.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            LucideIcons.box,
                            size: 10,
                            color: theme.colorScheme.mutedForeground.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            setup.blade.name,
                            style: theme.textTheme.small.copyWith(
                              fontSize: 12,
                              color: theme.colorScheme.mutedForeground.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildStatusIndicator(theme, setup),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Накладки в строку
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCompactRubberCard(theme, isMobile, setup.forehandRubber)),
            const SizedBox(width: 12),
            Expanded(child: _buildCompactRubberCard(theme, isMobile, setup.backhandRubber)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(ShadThemeData theme, PaddleSetup setup) {
    final needsReplacement = setup.needsRubberReplacement;
    final statusColor = needsReplacement ? AppColors.error : AppColors.success;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [statusColor.withOpacity(0.15), statusColor.withOpacity(0.08)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: statusColor.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(color: statusColor.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(color: statusColor.withOpacity(0.2), shape: BoxShape.circle),
            child: Icon(
              needsReplacement ? LucideIcons.info : LucideIcons.check,
              size: 12,
              color: statusColor,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            needsReplacement ? 'Замена' : 'OK',
            style: theme.textTheme.small.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: statusColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactRubberCard(ShadThemeData theme, bool isMobile, Rubber rubber) {
    final wearColor = _getWearColor(rubber.wearPercentage, theme);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [wearColor.withOpacity(0.08), theme.colorScheme.muted.withOpacity(0.03)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: wearColor.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(color: wearColor.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [wearColor.withOpacity(0.15), wearColor.withOpacity(0.08)],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: wearColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    rubber.side == RubberSide.forehand
                        ? LucideIcons.arrowRight
                        : LucideIcons.arrowLeft,
                    size: 12,
                    color: wearColor,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    rubber.side.displayName,
                    style: theme.textTheme.small.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: theme.colorScheme.foreground,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: wearColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: wearColor.withOpacity(0.4), width: 1),
                  ),
                  child: Text(
                    '${rubber.wearPercentage.toStringAsFixed(0)}%',
                    style: theme.textTheme.small.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: wearColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rubber.name,
                  style: theme.textTheme.p.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    letterSpacing: -0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Progress bar
                Stack(
                  children: [
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.muted.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: rubber.wearPercentage / 100,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [wearColor, wearColor.withOpacity(0.7)]),
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(
                              color: wearColor.withOpacity(0.4),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Hours info
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.muted.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.colorScheme.border.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.clock,
                          size: 12,
                          color: theme.colorScheme.mutedForeground.withOpacity(0.7),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${rubber.remainingHours.toStringAsFixed(0)}ч',
                          style: theme.textTheme.small.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getWearColor(double wearPercentage, ShadThemeData theme) {
    if (wearPercentage < 20) {
      return AppColors.success;
    } else if (wearPercentage < 40) {
      return AppColors.successDark; // Темнее зеленого для "хорошее"
    } else if (wearPercentage < 60) {
      return AppColors.warning;
    } else if (wearPercentage < 80) {
      return AppColors.warningDark;
    } else {
      return AppColors.error;
    }
  }
}
