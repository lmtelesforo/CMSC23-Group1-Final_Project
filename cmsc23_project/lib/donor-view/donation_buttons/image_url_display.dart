import 'package:flutter/material.dart';

class ImageUrlDisplay extends StatelessWidget {
  final List<String> imageUrls;

  ImageUrlDisplay({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    List<String> formattedUrls = imageUrls.map((url) {
      int endIndex = url.indexOf('.jpg');
      int startIndex = endIndex - 13; 
      if (startIndex < 0) {
        startIndex = 0;
      }
      return url.substring(startIndex, endIndex + 4); 
    }).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Text(
              'Uploaded Image URLs:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Color(0xFF373D66),
              ),
            ),
          ),
          SizedBox(height: 5),
          ListView.builder(
            shrinkWrap: true,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDetailPage(imageUrl: imageUrls[index]),
                      ),
                    );
                  },
                  child: Text(
                    formattedUrls[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins-Reg',
                      color: Color(0xFF373D66),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ImageDetailPage extends StatelessWidget {
  final String imageUrl;

  ImageDetailPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              );
            }
          },
        ),
      ),
    );
  }
  
}
