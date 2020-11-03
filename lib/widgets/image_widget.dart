import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pasal_manager/models/product.dart';

class ImageWidget extends StatefulWidget {
  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  // PickedFile _imageFile;
  Datas _datas = Datas();
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context, builder: ((builder) => bottomSheet(context)));
      },
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(8.0)),
          height: MediaQuery.of(context).size.height / 6.5,
          width: MediaQuery.of(context).size.width / 2.0,
          child: _datas.image != null
              ? Image.file(_datas.image)
              : Icon(Icons.add_a_photo)),
    );
  }

  Widget bottomSheet(context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            'Choose a Photo',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  _getImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              FlatButton.icon(
                  onPressed: () {
                    _getImage(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Gallery')),
            ],
          )
        ],
      ),
    );
  }

  Future _getImage(ImageSource source) async {
    var image = await picker.getImage(source: source);
    setState(() {
      _datas.image = File(image.path);
    });
  }
}
