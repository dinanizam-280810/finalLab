import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homestay_raya/models/config.dart';
import 'package:homestay_raya/views/user.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';

class newHomestayPage extends StatefulWidget {
  final User user;
  final Position position;
  const newHomestayPage({
    super.key,
    required this.user,
    required this.position,
  });

  @override
  State<newHomestayPage> createState() => _newHomestayPageState();
}

class _newHomestayPageState extends State<newHomestayPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _hsnameEditingController =
      TextEditingController();
  final TextEditingController _hsdescEditingController =
      TextEditingController();
  final TextEditingController _hspriceEditingController =
      TextEditingController();
  final TextEditingController _hsqtyEditingController = TextEditingController();
  final TextEditingController _hsstateEditingController =
      TextEditingController();
  final TextEditingController _hslocalEditingController =
      TextEditingController();
  var lat, long;

  @override
  void initState() {
    super.initState();
    //_checkandGetLocPermission();
    lat = widget.position.latitude.toString();
    long = widget.position.latitude.toString();
    _getAddress();
  }

  File? _image;
  var pathAsset = "assets/images/icon1.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add homestay"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: _selectImageDialog,
              child: Card(
                elevation: 8,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _image == null
                          ? AssetImage(pathAsset)
                          : FileImage(_image!) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              "Add New Homestay",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (val) => val!.isEmpty || (val.length < 3)
                            ? "Product name must be longer than 3"
                            : null,
                        controller: _hsnameEditingController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: 'Product Name',
                            labelStyle: TextStyle(),
                            icon: Icon(Icons.person),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ))),
                    TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (val) => val!.isEmpty || (val.length < 10)
                            ? "Product description must be longer than 10"
                            : null,
                        maxLines: 4,
                        controller: _hsdescEditingController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: 'Product Description',
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(),
                            icon: Icon(
                              Icons.description_rounded,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ))),
                    Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) => val!.isEmpty
                                  ? "Product price must contain value"
                                  : null,
                              controller: _hspriceEditingController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'Product Price',
                                  labelStyle: TextStyle(),
                                  icon: Icon(Icons.money),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ))),
                        ),
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? "Quantity should be more than 0"
                                      : null,
                              controller: _hsqtyEditingController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'Product Quantity',
                                  labelStyle: TextStyle(),
                                  icon: Icon(Icons.ad_units),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ))),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? "Current State"
                                      : null,
                              enabled: false,
                              controller: _hsstateEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Current States',
                                  labelStyle: TextStyle(),
                                  icon: Icon(Icons.flag),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ))),
                        ),
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              enabled: false,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? "Current Locality"
                                      : null,
                              controller: _hslocalEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Current Locality',
                                  labelStyle: TextStyle(),
                                  icon: Icon(Icons.map),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ))),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        child: const Text('Add Homestay'),
                        onPressed: () => {
                          _newhomestayDialog(),
                        },
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
  }

  _newhomestayDialog() {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in all the required fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    if (_image == null) {
      Fluttertoast.showToast(
          msg: "Please take the product picture",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Insert this Homestay?",
              style: TextStyle(),
            ),
            content: const Text("Are you sure?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Sure",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  insertProduct();
                },
              ),
              TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _selectImageDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
              title: const Text(
                "Select image from",
                style: TextStyle(),
              ),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        iconSize: 32,
                        onPressed: _onCamera,
                        icon: const Icon(Icons.camera)),
                    IconButton(
                        iconSize: 32,
                        onPressed: _onGallery,
                        icon: const Icon(Icons.browse_gallery)),
                  ]));
        });
  }

  Future<void> _onCamera() async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    } else {
      print('No image selected.');
    }
  }

  Future<void> _onGallery() async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    } else {
      print('No image selected.');
    }
  }

  Future<void> _cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      File imageFile = File(croppedFile.path);
      _image = imageFile;
      setState(() {});
    }
  }

/*Future<bool> _checkandGetLocPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
            msg: "Please allow the app to access the location",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        Geolocator.openLocationSettings();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg: "Please allow the app to access the location",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      Geolocator.openLocationSettings();
      return false;
    }
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return true;
  }*/

  _getAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.position.latitude, widget.position.longitude);
    setState(() {
      _hsstateEditingController.text =
          placemarks[0].administrativeArea.toString();
      _hslocalEditingController.text = placemarks[0].locality.toString();
    });
  }

  void insertProduct() {
    String hsname = _hsnameEditingController.text;
    String hsdesc = _hsdescEditingController.text;
    String hsprice = _hspriceEditingController.text;
    String hsqty = _hsqtyEditingController.text;
    String hsstate = _hsstateEditingController.text;
    String hslocality = _hslocalEditingController.text;
    String base64Image = base64Encode(_image!.readAsBytesSync());

    http.post(Uri.parse("${Config.SERVER}/php/insert_product.php"), body: {
      "userid": widget.user.id,
      "hsname": hsname,
      "hsdesc": hsdesc,
      "hsprice": hsprice,
      "hsqty": hsqty,
      "hsstate": hsstate,
      "hslocality": hslocality,
      "hslat": lat,
      "hslong": long,
      "image": base64Image
    }).then((response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        Navigator.of(context).pop();
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        Navigator.of(context).pop();
        return;
      }
    });
  }
}
