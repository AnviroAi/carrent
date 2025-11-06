import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_palette.dart';
import 'models.dart';
import 'shared_widgets.dart';

class ViewCarsPage extends StatelessWidget {
  const ViewCarsPage({
    super.key,
    required this.cars,
  });

  final List<Car> cars;

  @override
  Widget build(BuildContext context) {
    if (cars.isEmpty) {
      return const EmptyState(message: 'No cars available right now.');
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 140),
      physics: const BouncingScrollPhysics(),
      itemCount: cars.length,
      itemBuilder: (context, index) => CarCard(car: cars[index]),
    );
  }
}

class CarCard extends StatelessWidget {
  const CarCard({super.key, required this.car});

  final Car car;

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
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Image.asset(
                      car.imagePath,
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
                      label: car.status.label,
                      backgroundColor: car.status.backgroundColor,
                      textColor: car.status.foregroundColor,
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
                        car.title,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF161625),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      car.plateNumber,
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
                  car.specs,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mutedText,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: IconTextRow(
                        icon: Icons.speed,
                        label: car.odometer,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: IconTextRow(
                        icon: Icons.location_on_outlined,
                        label: car.location,
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
