import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/band_provider.dart';
import 'dart:io';

class AlbumListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bandProvider = Provider.of<BandProvider>(context);
    final albums = bandProvider.band.albums;

    return Scaffold(
      appBar: AppBar(
        title: const Text('음반 목록'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: albums.isEmpty
            ? const Center(child: Text('발매된 음반이 없습니다.'))
            : ListView.builder(
          itemCount: albums.length,
          itemBuilder: (context, index) {
            final album = albums[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        bottomLeft: Radius.circular(12.0),
                      ),
                      child: album.albumArt != null
                          ? Image.file(
                        File(album.albumArt!),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey,
                        child: const Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              album.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '월간 수익: ${album.monthlyIncome}만 원',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
