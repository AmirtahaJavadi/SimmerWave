import 'package:flutter/material.dart';
import '../models/radio_station.dart';   // adjust path to match your folder

class StationCard extends StatelessWidget {
  final RadioStation station;
  final VoidCallback? onTap;

  const StationCard({super.key, required this.station, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      clipBehavior: Clip.antiAlias,          // rounds the image too
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _buildImage(context),
              const SizedBox(width: 12),
              Expanded(child: _buildText(context)),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final placeholder = Container(
      width: 64,
      height: 64,
      color: Colors.grey.shade300,
      child: const Icon(Icons.radio, color: Colors.grey),
    );

    if (station.imageUrl == null || station.imageUrl!.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: placeholder,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        station.imageUrl!,
        width: 64,
        height: 64,
        fit: BoxFit.cover,
        // shown while downloading
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return SizedBox(
            width: 64,
            height: 64,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: progress.expectedTotalBytes != null
                    ? progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        // shown if the URL 404s or the image is broken
        errorBuilder: (context, error, stack) => placeholder,
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          station.name,
          style: theme.textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (station.description != null && station.description!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            station.description!,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: Colors.grey.shade600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}