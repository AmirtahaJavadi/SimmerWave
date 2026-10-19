import 'package:flutter/material.dart';

class CoolSearchBar extends StatelessWidget {
  const CoolSearchBar({
    super.key,
    required this.onTap,
    this.hintText = 'Search stations, songs, artists...',
  });

  final VoidCallback onTap;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        // Only the shadow lives here now — color moves to Material
        // so the ripple paints above it.
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
          clipBehavior: Clip.antiAlias, // keeps the ripple inside the pill
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16, // same as contentPadding before
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[600]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      hintText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}