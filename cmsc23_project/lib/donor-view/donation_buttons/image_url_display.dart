import 'package:flutter/material.dart';

class ImageUrlDisplay extends StatelessWidget {
  final List<String> imageUrls;

  ImageUrlDisplay({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Text(
              'Uploaded Image URLs:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins-Reg',
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
                    // Navigate to the image when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDetailPage(imageUrl: imageUrls[index]),
                      ),
                    );
                  },
                  child: Text(
                    imageUrls[index],
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
