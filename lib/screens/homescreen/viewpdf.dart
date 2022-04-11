import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Viewpdf extends StatefulWidget {
  const Viewpdf({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<Viewpdf> createState() => _ViewpdfState();
}

class _ViewpdfState extends State<Viewpdf> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
          future: _loadImages(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.data==null) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.green,),
                  );
                  
                }
            final Map<String, dynamic> image = snapshot.data![widget.index];

          
            return SfPdfViewer.network(
              image['url'],
            );

            // return ListView.builder(
            //   itemCount: snapshot.data!.length,
            //   itemBuilder: (context, index) {
            //     final Map<String, dynamic> image = snapshot.data![index];
            //     return SfPdfViewer.network(image['url'],);

            //   },
            // );
          }),
    ));
  }

  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];
    final ref = FirebaseStorage.instance;

    final ListResult result = await ref.ref().list();
    final List<Reference> allFiles = result.items;

   
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
  }
}
