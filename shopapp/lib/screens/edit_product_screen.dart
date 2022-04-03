import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shopapp/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editProduct =
      Product(id: "1", title: "", price: 0, description: '', imageUrl: "");
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate() as bool;
    if (!isValid) {
      return;
    }
    _form.currentState?.save();
    print(_editProduct.title);
    print(_editProduct.description);
    print(_editProduct.imageUrl);
    print(_editProduct.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _editProduct = Product(
                    title: value as String,
                    price: _editProduct.price,
                    description: _editProduct.description,
                    imageUrl: _editProduct.imageUrl,
                    id: "1",
                  );
                },
                validator: (value) {
                  if ((value as String).isEmpty) {
                    return "please provide a value";
                  }
                  return null;
                },
              ),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _editProduct = Product(
                      title: _editProduct.title,
                      price: double.parse(value as String),
                      description: _editProduct.description,
                      imageUrl: _editProduct.imageUrl,
                      id: "1",
                    );
                  }),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _editProduct = Product(
                      title: _editProduct.title,
                      price: _editProduct.price,
                      description: value as String,
                      imageUrl: _editProduct.imageUrl,
                      id: "1",
                    );
                  }),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) => {_saveForm()},
                        onSaved: (value) {
                          _editProduct = Product(
                            title: _editProduct.title,
                            price: _editProduct.price,
                            description: _editProduct.description,
                            imageUrl: value as String,
                            id: "1",
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
