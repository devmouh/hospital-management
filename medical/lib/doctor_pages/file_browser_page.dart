// lib/doctor_pages/file_browser_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/doctor_models.dart';
import '../providers/doctor_provider.dart';
import '../services/api_service.dart';
import 'package:flutter/services.dart';

import 'dart:io';

const Color kTeal = Color(0xFF4DB6AC);
const Color kBg = Color(0xFFF5F5F5);
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrey = Color(0xFF9E9E9E);
const Color kDark = Color(0xFF1A1A2E);

class FileBrowserPage extends StatefulWidget {
  final PatientModel patient;
  const FileBrowserPage({super.key, required this.patient});

  @override
  State<FileBrowserPage> createState() => _FileBrowserPageState();
}

class _FileBrowserPageState extends State<FileBrowserPage> {
  late Future<List<DocumentModel>> _docsFuture;

  @override
  void initState() {
    super.initState();
    _docsFuture = context.read<DoctorProvider>().fetchPatientDocuments(widget.patient.id);
  }

  static const _channel = MethodChannel('com.zamil.zamil/download');

  Future<void> _downloadFile(DocumentModel doc) async {
    // Show download animation/dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const _DownloadProgressDialog(),
    );

    try {
      // Build absolute URL for the document
      String rawUrl = doc.fichier;
      if (!rawUrl.startsWith('http')) {
        rawUrl = '${ApiService.baseUrl}$rawUrl';
      }

      debugPrint('Downloading from: $rawUrl');
      final bool success = await _channel.invokeMethod('downloadFile', {
        'url': rawUrl,
        'filename': doc.nomFichier,
        'authToken': ApiService.accessToken,
      });

      // Dismiss progress dialog
      if (mounted) Navigator.pop(context);

      if (success) {
        if (mounted) {
          _showDownloadSuccess(doc.nomFichier, 'Downloads/${doc.nomFichier}');
        }
      } else {
        if (mounted) {
          _showErrorSnackbar('Failed to start download');
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Dismiss if still showing
        _showErrorSnackbar('Download error: $e');
      }
    }
  }

  void _showDownloadSuccess(String filename, String savedPath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Download Started!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: kDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                filename,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Saved to public Downloads:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: kDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      savedPath,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.teal[700],
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kTeal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 44),
                ),
                child: const Text(
                  'Great!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(msg)),
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Medical Documents',
          style: TextStyle(
            color: kDark,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Patient Info card
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [kTeal, Color(0xFF26A69A)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: kTeal.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(widget.patient.photoUrl),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.patient.name,
                        style: const TextStyle(
                          color: kWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Total patient medical files and records',
                        style: TextStyle(
                          color: kWhite.withOpacity(0.8),
                          fontSize: 11,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Text(
              'Files List',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: kDark,
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<DocumentModel>>(
              future: _docsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: kTeal),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading documents: ${snapshot.error}'),
                  );
                } else {
                  final docs = snapshot.data ?? [];
                  if (docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder_open,
                            size: 64,
                            color: kGrey.withOpacity(0.5),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'No documents found for this patient.',
                            style: TextStyle(
                              color: kGrey,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: docs.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      return _buildDocumentCard(doc);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(DocumentModel doc) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => _downloadFile(doc),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Premium File Type Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),

                // File Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doc.nomFichier,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kDark,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0F2F1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              doc.typeDocDisplay,
                              style: const TextStyle(
                                color: kTeal,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.calendar_today,
                            size: 10,
                            color: kGrey.withOpacity(0.8),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            formatDateString(doc.dateConsultation),
                            style: const TextStyle(
                              color: kGrey,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Download Action Icon
                const Icon(
                  Icons.file_download_outlined,
                  color: kTeal,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DownloadProgressDialog extends StatelessWidget {
  const _DownloadProgressDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: kTeal),
            SizedBox(height: 20),
            Text(
              'Downloading PDF Document...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: kDark,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Fetching files securely from hospital backend',
              style: TextStyle(color: kGrey, fontSize: 11),
            )
          ],
        ),
      ),
    );
  }
}
