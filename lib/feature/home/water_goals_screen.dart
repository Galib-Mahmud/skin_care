import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaterGoalsScreen extends StatefulWidget {
  const WaterGoalsScreen({super.key});

  @override
  State<WaterGoalsScreen> createState() => _WaterGoalsScreenState();
}

class _WaterGoalsScreenState extends State<WaterGoalsScreen> {
  double _water = 8;
  int _prayer = 1;

  // —— single-select (only one at a time)
  String _selectedGoal = 'Hydration';

  final List<String> _skinGoals = const [
    'Hydration',
    'Dry',
    'Firm',
    'Smooth',
    'Oily',
    'Breakout',
    'Bright',
    'Soft',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 70, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                 SizedBox(height: 8.h),

                  // ——— Water card
                  _GoalCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _SectionTitle('Water Goals'),
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 8,
                                  activeTrackColor: Colors.black87,
                                  inactiveTrackColor: const Color(0x22000000),
                                  thumbColor: Colors.black,
                                  overlayShape: SliderComponentShape.noOverlay,
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14),

                                  // HIDE THE DOTS (tick marks)
                                  tickMarkShape: SliderTickMarkShape.noTickMark,
                                  activeTickMarkColor: Colors.transparent,
                                  inactiveTickMarkColor: Colors.transparent,
                                ),
                                child: Slider(
                                  value: _water,
                                  min: 0,
                                  max: 32,
                                  divisions: 32, // keep discrete steps without showing dots
                                  onChanged: (v) => setState(() => _water = v),
                                ),
                              ),
                            ),

                            SizedBox(width: 10.w),
                            Text(
                              '${_water.toInt()} oz/32 oz',
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 12.h),

                  // ——— Skin Goals card (single select)
                  _GoalCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _SectionTitle('Skin Goals'),
                         SizedBox(height: 10.h),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 2.9,
                          ),
                          itemCount: _skinGoals.length,
                          itemBuilder: (_, i) {
                            final label = _skinGoals[i];
                            final selected = _selectedGoal == label;
                            return _SelectPill(
                              label: label,
                              selected: selected,
                              onTap: () => setState(() => _selectedGoal = label),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // ——— Prayer card
                  _GoalCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _SectionTitle('PRAYER Goals'),
                           SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _CircleIconButton(
                              icon: Icons.remove,
                              onTap: () => setState(() {
                                if (_prayer > 0) _prayer--;
                              }),
                            ),
                            const SizedBox(width: 14),
                            _CounterPill(text: '$_prayer Time'),
                            const SizedBox(width: 14),
                            _CircleIconButton(
                              icon: Icons.add,
                              onTap: () => setState(() => _prayer++),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),
                  // ——— Save button
                  Center(
                    child: _SaveButton(
                      label: 'Save',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),

            // top-right close
            Positioned(
              top: 20,
              right: 3,
              child: IconButton(
                splashRadius: 18,
                icon: const Icon(Icons.close, size: 30),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* =============================== UI pieces =============================== */

/// Matches the picture: white card, rounded 14, thin grey border + soft drop shadow.
class _GoalCard extends StatelessWidget {
  final Widget child;
  const _GoalCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3E3E3), width: 1), // subtle edge like the image
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }
}

/// Single-select pill. Selected: solid black with white label.
/// Unselected: white with grey border and slight shadow just like the mock.
class _SelectPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SelectPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? Colors.black : Colors.white;
    final fg = selected ? Colors.white : Colors.black87;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(12),
      elevation: selected ? 3 : 2,
      shadowColor: const Color(0x22000000),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          alignment: Alignment.center,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: selected
                ? null
                : Border.all(
              color: const Color(0xFFEAEAEA),
              width: 1.2,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    );
  }
}

class _CounterPill extends StatelessWidget {
  final String text;
  const _CounterPill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      elevation: 2,
      shadowColor: const Color(0x22000000),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFE5E5E5), width: 1.2),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: const Color(0x22000000),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE5E5E5), width: 1.2),
          ),
          child: Icon(icon, size: 18, color: Colors.black87),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SaveButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
      elevation: 4,
      shadowColor: const Color(0x33000000),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
