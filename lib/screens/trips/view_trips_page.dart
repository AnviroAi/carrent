import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_palette.dart';
import 'models.dart';
import 'shared_widgets.dart';

class ViewTripsPage extends StatelessWidget {
  const ViewTripsPage({
    super.key,
    required this.trips,
  });

  final List<Trip> trips;

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return const EmptyState(message: 'No trips scheduled yet.');
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 140),
      physics: const BouncingScrollPhysics(),
      itemCount: trips.length,
      itemBuilder: (context, index) => TripCard(trip: trips[index]),
    );
  }
}

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
            ),
            child: SizedBox(
              height: 160,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: const Color(0xFFF3F3F8)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Image.asset(
                      trip.imagePath,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      errorBuilder: (context, error, stackTrace) =>
                          const ImagePlaceholder(),
                    ),
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: StatusChip(
                      label: trip.status.label,
                      backgroundColor: trip.status.backgroundColor,
                      textColor: trip.status.foregroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        trip.title,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF161625),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      trip.plateNumber,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  trip.specs,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mutedText,
                  ),
                ),
                const SizedBox(height: 16),
                RoutePill(route: trip.route),
                const SizedBox(height: 18),
                Row(
                  children: [
                    IconTextRow(
                      icon: Icons.person_outline,
                      label: trip.driverName,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconTextRow(
                          icon: trip.inspected
                              ? Icons.verified_outlined
                              : Icons.cancel_outlined,
                          label:
                              trip.inspected ? 'Inspected' : 'Not Inspected',
                          color: trip.inspected
                              ? AppColors.accentSuccessPill
                              : AppColors.accentDanger,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: IconTextRow(
                        icon: Icons.speed,
                        label: trip.odometer,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: IconTextRow(
                        icon: Icons.calendar_today_outlined,
                        label: trip.dateLabel,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    CircleActionButton(
                      icon: Icons.arrow_forward,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoutePill extends StatelessWidget {
  const RoutePill({super.key, required this.route});

  final String route;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.pillBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              route,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: const Color(0xFF161625),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(6),
            child: const Icon(
              Icons.arrow_forward,
              size: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
