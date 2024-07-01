import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';

void main() {
  runApp(const MaterialApp(
    home: PremiumBookingPage(),
  ));
}

class PremiumBookingPage extends StatefulWidget {
  const PremiumBookingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PremiumBookingPageState createState() => _PremiumBookingPageState();
}

class _PremiumBookingPageState extends State<PremiumBookingPage> {
  bool _isExpanded = false;
  final List<int> _selectedIcons = [0, 0, 0];
  final List<TextEditingController> _controllers =
      List.generate(3, (index) => TextEditingController(text: '0'));
  final List<bool> _selectedPhotographers = List.generate(16, (index) => false);

  void _incrementIcon(int index) {
    if (_selectedIcons[index] < 100) {
      setState(() {
        _selectedIcons[index]++;
        _controllers[index].text = _selectedIcons[index].toString();
      });
    }
  }

  void _decrementIcon(int index) {
    if (_selectedIcons[index] > 1) {
      setState(() {
        _selectedIcons[index]--;
        _controllers[index].text = _selectedIcons[index].toString();
      });
    }
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _toggleSelectPhotographer(int index) {
    setState(() {
      _selectedPhotographers[index] = !_selectedPhotographers[index];
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/grad2.png',
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 10),
              const GradientText(
                'Premium',
                gradient: LinearGradient(
                  colors: [Colors.yellow, Colors.orange],
                ),
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(width: 10),
              const Text(
                '(\$500 /-)',
                style: TextStyle(
                    fontSize: 24, color: Color.fromARGB(255, 238, 237, 237)),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ListTile(
                    title: Text(
                      'Total Amount: \$500',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Placeholder for first section space
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _isExpanded
                        ? MediaQuery.of(context).size.height * 0.4
                        : 150,
                  ),
                  const SizedBox(height: 20),
                  const ListTile(
                    title: Text(
                      'Memow Partners',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildPartnerTile(0),
                  _buildPartnerTile(1),
                  _buildPartnerTile(2),
                  const Divider(),
                  const ListTile(
                    title: Text(
                      'Package Details',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const ListTile(
                    title: Text('• Detail 1'),
                  ),
                  const ListTile(
                    title: Text('• Detail 2'),
                  ),
                  const ListTile(
                    title: Text('• Detail 3'),
                  ),
                  const SizedBox(height: 80), // Space for the slider
                ],
              ),
            ),
            // Floating box for first section
            Positioned(
              top: 80,
              left: 16,
              right: 16,
              child: GestureDetector(
                onTap: _toggleExpand,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _isExpanded
                      ? MediaQuery.of(context).size.height * 0.42
                      : 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: _toggleExpand,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _isExpanded
                              ? MediaQuery.of(context).size.height * 0.5 - 50
                              : 100,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4,
                                  ),
                                  itemCount: 16,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onLongPress: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PhotographerProfilePage(),
                                          ),
                                        );
                                      },
                                      onTap: () =>
                                          _toggleSelectPhotographer(index),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            child: const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                  'assets/photographer.png'),
                                            ),
                                          ),
                                          if (_selectedPhotographers[index])
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 1,
                                child: CalendarCarousel<Event>(
                                  onDayPressed: (date, events) {},
                                  weekendTextStyle: const TextStyle(
                                    color: Colors.red,
                                  ),
                                  thisMonthDayBorderColor: Colors.grey,
                                  customDayBuilder: (
                                    bool isSelectable,
                                    int index,
                                    bool isSelectedDay,
                                    bool isToday,
                                    bool isPrevMonthDay,
                                    TextStyle textStyle,
                                    bool isNextMonthDay,
                                    bool isThisMonthDay,
                                    DateTime day,
                                  ) {
                                    return Center(
                                      child: Text(
                                        day.day.toString(),
                                        style: TextStyle(
                                          color: isToday
                                              ? Colors.green
                                              : Colors
                                                  .red, // Customize as per availability
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Fixed slider at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookingConfirmationPage(),
                      ),
                    );
                  }
                },
                child: Container(
                  color: const Color.fromARGB(255, 237, 252, 32),
                  padding: const EdgeInsets.all(16.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        size: 40,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Slide to Confirm Booking',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerTile(int index) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/partner.png'),
      ),
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => _decrementIcon(index),
          ),
          Text(_selectedIcons[index].toString()),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _incrementIcon(index),
          ),
          Expanded(
            child: TextField(
              controller: _controllers[index],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                final newValue = int.tryParse(value) ?? 1;
                if (newValue >= 1 && newValue <= 100) {
                  setState(() {
                    _selectedIcons[index] = newValue;
                  });
                } else {
                  _controllers[index].text = _selectedIcons[index].toString();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    required this.style,
    super.key,
  });

  final String text;
  final TextStyle style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}

class PhotographerProfilePage extends StatelessWidget {
  const PhotographerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photographer Profile'),
      ),
      body: const Center(
        child: Text('Photographer Profile Details'),
      ),
    );
  }
}

class BookingConfirmationPage extends StatelessWidget {
  const BookingConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
      ),
      body: const Center(
        child: Text('Your booking is confirmed!'),
      ),
    );
  }
}
