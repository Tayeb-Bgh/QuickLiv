import 'package:flutter/material.dart';

class NoticeInputWidget extends StatefulWidget {
  const NoticeInputWidget({super.key});

  @override
  _NoticeInputWidgetState createState() => _NoticeInputWidgetState();
}

class _NoticeInputWidgetState extends State<NoticeInputWidget> {
  final TextEditingController _controller = TextEditingController();
  final int _maxLength = 150;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final dialogHeight = screenHeight * 0.28;

    return Dialog(
      backgroundColor: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: dialogHeight,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Saisir une notice",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFCCCCCC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        maxLength: _maxLength,
                        maxLines: null,
                        expands: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                          hintText:
                              "Exemple : Je veux pas de salade sur mon burger s'il vous plaît",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF686868),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "${_controller.text.length}/$_maxLength",
                        style: const TextStyle(
                          color: Color(0xFF686868),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircleButton(
                  icon: Icons.close,
                  color: const Color(0xFF504E4E),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 50),
                _buildCircleButton(
                  icon: Icons.check,
                  color: const Color(0xFFE13838),
                  onPressed: () {
                    print("Notice validé: ${_controller.text}");
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
