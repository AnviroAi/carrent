import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_palette.dart';
import 'models.dart';
import 'view_cars_page.dart';
import 'view_trips_page.dart';

enum TripTab { cars, trips }

class TripsScreen extends StatefulWidget {
  const TripsScreen({
    super.key,
    this.initialTab = TripTab.trips,
    this.cars,
    this.trips,
  });

  final TripTab initialTab;
  final List<Car>? cars;
  final List<Trip>? trips;

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  PageController? _pageController;
  TripTab _selectedTab = TripTab.trips;
  List<Car> _cars = const <Car>[];
  List<Trip> _trips = const <Trip>[];

  static const List<Car> _fallbackCars = [
    Car(
      title: '2024 JAC T9',
      plateNumber: 'AB3507',
      specs: 'Petrol | 2000cc | Automatic',
      odometer: '198,997 Kms',
      location: 'Islamabad',
      imagePath: 'assets/images/jac_t9.png',
      status: CarStatus.onTrip,
    ),
    Car(
      title: '2022 COROLLA',
      plateNumber: 'KS2134',
      specs: 'Petrol | 1500cc | Manual',
      odometer: '200,997 Kms',
      location: 'Rawalpindi',
      imagePath: 'assets/images/corolla_white.png',
      status: CarStatus.inGarage,
    ),
  ];

  static const List<Trip> _fallbackTrips = [
    Trip(
      title: '2022 COROLLA',
      plateNumber: 'KS2134',
      specs: 'Petrol | 1500cc | Manual',
      route: 'ISB -> LHR',
      driverName: 'Sheeda Ustaad',
      inspected: false,
      odometer: '200,997 Kms',
      dateLabel: '10/30/2025',
      imagePath: 'assets/images/corolla.png',
      status: TripStatus.onTrip,
    ),
    Trip(
      title: 'MG HS PHEV',
      plateNumber: 'LEO888',
      specs: 'Petrol | 1500cc | Automatic',
      route: 'ISB -> LHR',
      driverName: 'Majeed Ustaad',
      inspected: true,
      odometer: '89,430 Kms',
      dateLabel: '11/12/2025',
      imagePath: 'assets/images/mg_hs_phev.png',
      status: TripStatus.inWorkshop,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _configureState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TripsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialTab != widget.initialTab ||
        oldWidget.cars != widget.cars ||
        oldWidget.trips != widget.trips) {
      setState(_configureState);
    }
  }

  void _configureState() {
    _selectedTab = widget.initialTab;
    _pageController?.dispose();
    _pageController = PageController(
      initialPage: _selectedTab == TripTab.cars ? 0 : 1,
    );
    _cars = List<Car>.unmodifiable(widget.cars ?? _fallbackCars);
    _trips = List<Trip>.unmodifiable(widget.trips ?? _fallbackTrips);
  }

  void _onTabSelected(TripTab tab) {
    setState(() => _selectedTab = tab);
    _pageController?.animateToPage(
      tab == TripTab.cars ? 0 : 1,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    final tab = index == 0 ? TripTab.cars : TripTab.trips;
    if (tab != _selectedTab) {
      setState(() => _selectedTab = tab);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _TripsHeader(
              selectedTab: _selectedTab,
              onSelect: _onTabSelected,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                physics: const BouncingScrollPhysics(),
                children: [
                  ViewCarsPage(cars: _cars),
                  ViewTripsPage(trips: _trips),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _TripsFooter(),
    );
  }
}

class _TripsHeader extends StatelessWidget {
  const _TripsHeader({
    required this.selectedTab,
    required this.onSelect,
  });

  final TripTab selectedTab;
  final ValueChanged<TripTab> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppGradients.tabsHeader,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      child: Row(
        children: [
          Expanded(
            child: _TripsToggleButton(
              label: 'View Cars',
              isSelected: selectedTab == TripTab.cars,
              onTap: () => onSelect(TripTab.cars),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _TripsToggleButton(
              label: 'View Trips',
              isSelected: selectedTab == TripTab.trips,
              onTap: () => onSelect(TripTab.trips),
            ),
          ),
        ],
      ),
    );
  }
}

class _TripsToggleButton extends StatelessWidget {
  const _TripsToggleButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: isSelected ? AppGradients.primary : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 12,
                    offset: Offset(0, 8),
                  ),
                ]
              : const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class _TripsFooter extends StatelessWidget {
  const _TripsFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Row(
            children: [
              Expanded(
                child: _BottomActionButton(
                  icon: Icons.add,
                  label: 'Add Trip',
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BottomActionButton(
                  icon: Icons.check,
                  label: 'Complete Trip',
                  backgroundColor: AppColors.accentSuccess,
                  foregroundColor: Colors.white,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomActionButton extends StatelessWidget {
  const _BottomActionButton({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 16,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: foregroundColor, size: 22),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: foregroundColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
