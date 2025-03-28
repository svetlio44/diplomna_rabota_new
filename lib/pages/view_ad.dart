import 'package:flutter/material.dart';
import 'dart:io';

class ViewAd extends StatelessWidget {
  static const String id = 'ViewAd';

  final String title;
  final String description;
  final String price;
  final String phoneNumber;
  final String email;
  final String? imagePath;

  const ViewAd({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.phoneNumber,
    required this.email,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isNetworkImage = imagePath?.startsWith('http') ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: imagePath != null && imagePath!.isNotEmpty
                    ? imagePath!.startsWith('assets/')
                    ? Image.asset(
                  imagePath!,
                  fit: BoxFit.cover,
                )
                    : (isNetworkImage
                    ? Image.network(
                  imagePath!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildDefaultImage(),
                )
                    : Image.file(
                  File(imagePath!),
                  fit: BoxFit.cover,
                ))
                    : _buildDefaultImage(),
              ),
            ),

            const SizedBox(height: 24),

            // Title and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),
                Chip(
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  label: Text(
                    '€$price',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Description
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Contact Info
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildContactInfo(Icons.phone, phoneNumber),
                    const SizedBox(height: 12),
                    _buildContactInfo(Icons.email, email),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Removed the floatingActionButton
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultImage() {
    return Image.asset(
      'assets/images/hamalski_uslugi.png',
      fit: BoxFit.cover,
    );
  }
}