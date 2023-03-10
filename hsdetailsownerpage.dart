import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homestay_raya/models/config.dart';
import 'package:homestay_raya/views/product.dart';
import 'package:http/http.dart' as http;

class HsDetailsOwnerPage extends StatefulWidget {
  final Product product;
  const HsDetailsOwnerPage({Key? key, required this.product}) : super(key: key);

  @override
  State<HsDetailsOwnerPage> createState() => _HsDetailsOwnerPageState();
}

class _HsDetailsOwnerPageState extends State<HsDetailsOwnerPage> {
  late double screenHeight, screenWidth, resWidth;
  File? _image;
  var pathAsset = "assets/images/icon1.jpg";
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  bool editForm = false;
  bool _isChecked = false;
  final TextEditingController _hsnameEditingController = TextEditingController();
  final TextEditingController _hsdescEditingController = TextEditingController();
    final TextEditingController _hspriceEditingController = TextEditingController();
  final TextEditingController _hsdelEditingController = TextEditingController();
  final TextEditingController _hsqtyEditingController = TextEditingController();
  final TextEditingController _hsstateEditingController = TextEditingController();
  final TextEditingController _hslocalEditingController = TextEditingController();
 
 @override
  void initState() {
    super.initState();
    _hsnameEditingController.text = widget.product.hsname.toString();
    _hsdescEditingController.text = widget.product.hsdesc.toString();
    _hspriceEditingController.text = widget.product.hsprice.toString();
    _hsqtyEditingController.text = widget.product.hsqty.toString();
    _hsstateEditingController.text = widget.product.hsstate.toString();
    _hslocalEditingController.text = widget.product.hsloc.toString();
  }

  @override
  Widget build(BuildContext context) {
      screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
         appBar: AppBar(
        title: const Text('Your Product Details'),
        actions: [
           IconButton(onPressed: _onDeleteHs, icon: const Icon(Icons.delete)),
          IconButton(onPressed: _onEditForm, icon: const Icon(Icons.edit))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: resWidth,
            child: Column(
              children: [
     SizedBox(
      height: screenHeight / 2.5,
       child: GestureDetector(
       onTap: _selectImage,
         child: Padding(
               padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                   child: Container(
                    decoration: BoxDecoration(
                         image: DecorationImage(
                         image: _image == null
                          ? NetworkImage(Config.SERVER +
                                   "/homestay_raya/images/products/" +
                                 widget.product.hsid.toString() +
                                   ".png")
                               : FileImage(_image!) as ImageProvider,
                         fit: BoxFit.fill,
                          ),
                        )),
               ),
)),
      //For image widget
         Card(
            elevation: 10,
     child: Padding(
     padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
     child: Form(
       key: _formKey,
child: Column(
         children: [
               const SizedBox(height: 5,),
                    TextFormField(
                       textInputAction: TextInputAction.next,
                       enabled: editForm,
                       validator: (val) =>
                       val!.isEmpty || (val.length < 3)
                         ? "Product name must be longer than 3"
                          : null,
                       onFieldSubmitted: (v) {
                       FocusScope.of(context).requestFocus(focus);
                       },
                       controller: _hsnameEditingController,
                       keyboardType: TextInputType.text,
                       decoration: const InputDecoration(
                       labelText: 'Product Name',
                       labelStyle: TextStyle(),
                       icon: Icon(Icons.person,),
                       focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(width: 2.0),))),
                    TextFormField(
                       textInputAction: TextInputAction.next,
                       enabled: editForm,
                       validator: (val) => val!.isEmpty || (val.length < 3)
                           ? "Product description must be longer than 3"
                          : null,
                       focusNode: focus,
                       onFieldSubmitted: (v) {
                       FocusScope.of(context).requestFocus(focus1);
                       },
                      maxLines: 4,
                       controller: _hsdescEditingController,
                       keyboardType: TextInputType.text,
                       decoration: const InputDecoration(
                       labelText: 'Product Description',
                       alignLabelWithHint: true,
                       labelStyle: TextStyle(),
                       icon: Icon(Icons.person,),
                         focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),))),
                   Row(children: [
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                          textInputAction: TextInputAction.next,
                          enabled: editForm,
                          validator: (val) => val!.isEmpty
                            ? "Product price must contain value":null,
                             focusNode: focus1,
                          onFieldSubmitted: (v) {
                          FocusScope.of(context)
                         .requestFocus(focus2);
                         },
                         controller: _hspriceEditingController,
                         keyboardType: TextInputType.number,
                         decoration: const InputDecoration(
                          labelText: 'Product Price',
                          labelStyle: TextStyle(),
                          icon: Icon(Icons.money,),
                          focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),))),),
                       Flexible(
                          flex: 5,
                          child: TextFormField(
                          textInputAction: TextInputAction.next,
                          enabled: editForm,
                          validator: (val) => val!.isEmpty
                            ? "Quantity should be more than 0"
                                 : null,
                          focusNode: focus2,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focus3);
             },
                          controller: _hsqtyEditingController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                          labelText: 'Product Quantity',
                          labelStyle: TextStyle(),
                          icon: Icon(Icons.ad_units,),
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
                                        icon: Icon(
                                          Icons.flag,
                                        ),
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
                                          icon: Icon(
                                            Icons.map,
                                          ),
                                            focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2.0),
                                          )))),
                            ],
                          ),
                            Row(children: [
                            Flexible(
                              flex: 5,
                              child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  enabled: editForm,
                                  validator: (val) => val!.isEmpty
                                      ? "Must be more than zero"
                                      : null,
                                  focusNode: focus3,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(focus4);
                                  },
                                  controller: _hsdelEditingController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      labelText: 'Delivery charge/km',
                                      labelStyle: TextStyle(),
                                      icon: Icon(Icons.delivery_dining),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2.0),
                                      ))),
                            ),

         ],), 
          const SizedBox(
          height: 15,),
          Visibility(
                            visible: editForm,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize:
                                      Size(resWidth / 2, resWidth * 0.1)),
                              child: const Text('Update Product'),
                              onPressed: _updateProductDialog,
                            ),
                          ),
const SizedBox(
                            height: 15,
                          ),//for form widget
       ],
   ))))






    ],)))));
  }

  void _onDeleteHs() {
      showDialog(
          context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Delete this product",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteProduct();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onEditForm() {
      if (!editForm) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Edit this product",
              style: TextStyle(),
            ),
            content: const Text("Are you sure?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    editForm = true;
                  });
                },
              ),
              TextButton(
                child: const Text(
                  "No", style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _selectImage() {
  }

  void _updateProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Update this product",
            style: TextStyle(),
              ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _updateProduct();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }
  
  void _updateProduct() {
    String _hsname = _hsnameEditingController.text;
    String _hsdesc = _hsdescEditingController.text;
    String _hsprice = _hspriceEditingController.text;
    String _hsqty = _hsqtyEditingController.text;
    String _hsdel = _hsdelEditingController.text;
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
   
    if (_image == null) {
      http.post(Uri.parse("${Config.SERVER}/php/update_product.php"),
          body: {
            "hsid": widget.product.hsid,
            "hsname": _hsname,
            "hsdesc": _hsdesc,
            "hsprice": _hsprice,
            "hsqty": _hsqty,
            "hsdel": _hsdel,
          }).then((response) {
        print(response.body);
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
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
     
          return;
        }
      });
    } else {
      String base64Image = base64Encode(_image!.readAsBytesSync());
      http.post(Uri.parse("${Config.SERVER}/php/update_product.php"),
          body: {
            "hsid": widget.product.hsid,
            "hsname": _hsname,
            "hsdesc": _hsdesc,
            "hsprice": _hsprice,
            "hsqty": _hsqty,
            "hsdel": _hsdel,
            "image": base64Image,
          }).then((response) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
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
          
          return;
        }
      });
    }
   
  }
  
  void _deleteProduct() {
   
    http.post(Uri.parse(Config.SERVER + "/homestayraya/php/delete_product.php"),
        body: {
          "hsid": widget.product.hsid,
        }).then((response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
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
        return;
      }
    });

  }


  }
  