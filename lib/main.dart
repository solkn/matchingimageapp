
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_compare/image_compare.dart';
void main() => runApp(
  MaterialApp(
    title: 'Image Matching',
    home: MyApp(),
  )
  );


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  XFile? _image1;
  XFile? _image2;
  // double uploadProgress = 0.0;
  double? _similarityScore;


  Future<XFile?> pickImageFromAlbum() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  Future<XFile?> pickImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    return pickedFile;
  }
   
  Future<double?> compareImageSimilarity(XFile? image1, XFile? image2) async {
    if (image1 == null || image2 == null){

print("image folder sol,${image1!.path}");
      return null;
    } 

    final image1Path = image1.path;
    final image2Path = image2.path;

    // print(image1Path);
    print("image folder sol,${image1.path}");
    print("camera image folder sol,${image1.path}");



  var bytes1 = XFile(image1Path).readAsBytes();
  var bytes2 = XFile(image2Path).readAsBytes();

final image1File = File(image1.path);
final image2File = File(image2.path);

  //  final a = await listCompare(target: "target", list: [],);

    final algorithm = IMED(blurRatio: 0.001);
    
    final similarityScore = await compareImages(
      src1: image1File,
      src2: image2File,
      algorithm: algorithm,
    );

  print('Difference: ${similarityScore * 100}%');

    return similarityScore;
  }




  @override
  Widget build(BuildContext context) {
    // return MaterialApp(

    //   title: 'Image Uploader',
    //   home: Scaffold(

        return Scaffold(
    

        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Matching Image App'),
          centerTitle: true,
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 17, 57, 238),
                  Color.fromARGB(255, 4, 4, 141),
                ],
              ),
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image previews
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_image1 != null)
                      Image.file(
                        File(_image1!.path),
                        width: ScreenUtil().setWidth(150),
                        height: ScreenUtil().setHeight(150),
                      ),
                    SizedBox(width: 20.0),
                    if (_image2 != null)
                      Image.file(
                        File(_image2!.path),
                        width: ScreenUtil().setWidth(150),
                        height: ScreenUtil().setHeight(150),
                      ),
                  ],
                ),
                SizedBox(height: 100.0),
                // Upload buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async => _image1 = await pickImageFromAlbum(),
                      child: Text('Pick from Album'),
                    ),
                    SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () async => _image2 = await pickImageFromCamera(),
                      child: Text('Take from Camera'),
                    ), 
                  ],
                ),
                SizedBox(height: 20.0),



              ElevatedButton(
                onPressed: () async {
                  final score = await compareImageSimilarity(_image1, _image2);
                 

                  if(score! > 0.5){
                        imageMatchingDialog(context, "Succeeded");

                    
                  
                  }else{
                        imageMatchingDialog(context, "Failed");
                        

                  }


                },
                child: const Text('Match Images'),
              ),



              ],
            ),
          ),
        ),
      );
    // );
  }

void imageMatchingDialog(BuildContext context, dynamic data) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Success'),
      content: Text('Image Matching: $data'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    ),
  );
}

  
}

