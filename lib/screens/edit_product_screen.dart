import 'package:flutter/material.dart';

import '../providers/product.dart';

class EditproductScreen extends StatefulWidget {
  const EditproductScreen({Key? key}) : super(key: key);

  static const String routeName = '/edit-product';

  @override
  State<EditproductScreen> createState() => _EditproductScreenState();
}

class _EditproductScreenState extends State<EditproductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController(
    text:
        'https://cdn.pixabay.com/photo/2022/04/21/22/50/animal-7148487_960_720.jpg',
  );

  final _form = GlobalKey<FormState>();

  var _editProduct = Product(
    id: '',
    description: '',
    title: '',
    imageUrl: '',
    price: 0,
  );

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);

    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  void _saveForm() {
    _form.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) {
                    if (value != null) {
                      _editProduct = Product(
                          id: _editProduct.id,
                          title: value,
                          description: _editProduct.description,
                          price: _editProduct.price,
                          imageUrl: _editProduct.imageUrl);
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onSaved: (value) {
                    if (value != null) {
                      _editProduct = Product(
                        id: _editProduct.id,
                        title: _editProduct.title,
                        description: _editProduct.description,
                        price: double.parse(value),
                        imageUrl: _editProduct.imageUrl,
                      );
                    }
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    if (value != null) {
                      _editProduct = Product(
                        id: _editProduct.id,
                        title: _editProduct.title,
                        description: value,
                        price: _editProduct.price,
                        imageUrl: _editProduct.imageUrl,
                      );
                    }
                  },
                  keyboardType: TextInputType.multiline,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Enter a url')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _imageUrlController,
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        focusNode: _imageUrlFocusNode,
                        onSaved: (value) {
                          if (value != null) {
                            _editProduct = Product(
                              id: _editProduct.id,
                              title: _editProduct.title,
                              description: _editProduct.description,
                              price: _editProduct.price,
                              imageUrl: value,
                            );
                          }
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
