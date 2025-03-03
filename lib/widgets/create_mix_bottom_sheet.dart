import 'package:flutter/material.dart';

class CreateMixBottomSheet extends StatefulWidget {
  const CreateMixBottomSheet({Key? key}) : super(key: key);

  @override
  State<CreateMixBottomSheet> createState() => _CreateMixBottomSheetState();
}

class _CreateMixBottomSheetState extends State<CreateMixBottomSheet> {
  // কয়েকটি স্লাইডার ভ্যালু রাখার জন্য
  double _sliderValue1 = 0.5;
  double _sliderValue2 = 0.3;
  double _sliderValue3 = 0.7;

  @override
  Widget build(BuildContext context) {
    return Container(
      // অ্যানিমেটেড Bottom Sheet এর জন্য শীর্ষে গোলাকার কার্নার
      decoration: const BoxDecoration(
        color: Color(0xFF1E0036), // গাঢ় ব্যাকগ্রাউন্ড, আপনি ইচ্ছামতো পাল্টাতে পারেন
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min, // কন্টেন্ট অনুযায়ী উচ্চতা নেবে
        children: [
          // শীর্ষে একটা ছোট ড্র্যাগ হ্যান্ডেল (ঐচ্ছিক)
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),

          // "Your Mix" শিরোনাম
          const Text(
            "Your Mix",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // স্লাইডার ১
          Row(
            children: [
              Expanded(
                child: Text(
                  "Typhoon",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                flex: 2,
                child: Slider(
                  value: _sliderValue1,
                  min: 0.0,
                  max: 1.0,
                  activeColor: Colors.purpleAccent,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue1 = value;
                    });
                  },
                ),
              ),
              // আইকন বা অন্য কিছু রাখতে পারেন
              Icon(Icons.cloud, color: Colors.white),
            ],
          ),
          const SizedBox(height: 10),

          // স্লাইডার ২
          Row(
            children: [
              Expanded(
                child: Text(
                  "Sleet",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                flex: 2,
                child: Slider(
                  value: _sliderValue2,
                  min: 0.0,
                  max: 1.0,
                  activeColor: Colors.purpleAccent,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue2 = value;
                    });
                  },
                ),
              ),
              Icon(Icons.water_drop, color: Colors.white),
            ],
          ),
          const SizedBox(height: 10),

          // স্লাইডার ৩
          Row(
            children: [
              Expanded(
                child: Text(
                  "Desert Wind",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                flex: 2,
                child: Slider(
                  value: _sliderValue3,
                  min: 0.0,
                  max: 1.0,
                  activeColor: Colors.purpleAccent,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue3 = value;
                    });
                  },
                ),
              ),
              Icon(Icons.air, color: Colors.white),
            ],
          ),
          const SizedBox(height: 20),

          // নিচে কয়েকটি অ্যাকশন বাটন
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Save action
                },
                icon: const Icon(Icons.save),
                label: const Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Pause action
                },
                icon: const Icon(Icons.pause),
                label: const Text("Pause"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Clear action
                  setState(() {
                    _sliderValue1 = 0.0;
                    _sliderValue2 = 0.0;
                    _sliderValue3 = 0.0;
                  });
                },
                icon: const Icon(Icons.clear_all),
                label: const Text("Clear All"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(), // Bottom Sheet বন্ধ
                icon: const Icon(Icons.close),
                label: const Text("Close"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
