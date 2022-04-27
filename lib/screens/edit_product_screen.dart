import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

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

  var _isLoading = false;

  Map<String, dynamic> _initMapValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      const urlPattern =
          r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
      final result = RegExp(urlPattern, caseSensitive: false).firstMatch(
        _imageUrlController.text,
      );
      if (_imageUrlController.text.isEmpty || result == null) {
        return;
      }

      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);

    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final productId = ModalRoute.of(context)?.settings.arguments as String?;
    if (productId != null) {
      _editProduct =
          Provider.of<Products>(context, listen: false).getItem(productId);
      _initMapValues = _editProduct.toMap();
      _imageUrlController.text = _editProduct.imageUrl;
    }
  }

  Future<void> _saveForm(BuildContext context) async {
    final isValid = _form.currentState?.validate();
    if (isValid != null && isValid) {
      _form.currentState?.save();
      setState(
        () {
          _isLoading = true;
        },
      );

      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('An error occured'),
            content: const Text('Something went wrong'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Ok'))
            ],
          ),
        );
      } finally {
        setState(
          () {
            _isLoading = false;
          },
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: () => _saveForm(context),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        initialValue: _initMapValues['title'],
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            _editProduct = Product(
                              id: _editProduct.id,
                              title: value,
                              description: _editProduct.description,
                              price: _editProduct.price,
                              imageUrl: _editProduct.imageUrl,
                              isFavorite: _editProduct.isFavorite,
                            );
                          }
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        initialValue: _initMapValues['price'].toString(),
                        focusNode: _priceFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide a value.';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please provide a valid number.';
                          }

                          if (double.parse(value) <= 0) {
                            return 'Please enter a number greater than zero.';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            _editProduct = Product(
                              id: _editProduct.id,
                              title: _editProduct.title,
                              description: _editProduct.description,
                              price: double.parse(value),
                              imageUrl: _editProduct.imageUrl,
                              isFavorite: _editProduct.isFavorite,
                            );
                          }
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        focusNode: _descriptionFocusNode,
                        initialValue: _initMapValues['description'],
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide a value.';
                          }

                          if (value.length < 5) {
                            return 'Should be at least 5 characteres long';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            _editProduct = Product(
                              id: _editProduct.id,
                              title: _editProduct.title,
                              description: value,
                              price: _editProduct.price,
                              imageUrl: _editProduct.imageUrl,
                              isFavorite: _editProduct.isFavorite,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please provide a value.';
                                }

                                const urlPattern =
                                    r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
                                final result =
                                    RegExp(urlPattern, caseSensitive: false)
                                        .firstMatch(value);

                                if (result == null) {
                                  return 'Please enter a valid url.';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                if (value != null) {
                                  _editProduct = Product(
                                    id: _editProduct.id,
                                    title: _editProduct.title,
                                    description: _editProduct.description,
                                    price: _editProduct.price,
                                    imageUrl: value,
                                    isFavorite: _editProduct.isFavorite,
                                  );
                                }
                              },
                              onFieldSubmitted: (_) {
                                _saveForm(context);
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
