import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _ageFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _aboutFocusNode = FocusNode();
  final _contactFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _initValue = true;
  var _initProduct = {
    'name': '',
    'age': '',
    'address': '',
    'imageUrl': '',
    'about': '',
    'contact': '',
  };
  //var _isLoading = false;

  var _editedUser = User(
    id: '',
    name: '',
    age: '',
    about: '',
    contact: '',
    imageUrl: '',
    membership: '',
    address: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_initValue) {
      _editedUser = Provider.of<Users>(context, listen: false).items[0];
      _initProduct = {
        'name': _editedUser.name,
        'age': _editedUser.age,
        'address': _editedUser.address,
        'imageUrl': '',
        'about': _editedUser.about,
        'contact': _editedUser.contact,
      };
      _imageUrlController.text = _editedUser.imageUrl;
    }
    _initValue = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _aboutFocusNode.dispose();
    _addressFocusNode.dispose();
    _ageFocusNode.dispose();
    _contactFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((_imageUrlController.text.isEmpty) ||
          (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg') &&
              !_imageUrlController.text.endsWith('.png'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState.save();

    Provider.of<Users>(context, listen: false)
        .updateProduct(_editedUser.id, _editedUser);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initProduct['name'],
                decoration: InputDecoration(labelText: 'Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_ageFocusNode);
                },
                onSaved: (value) {
                  _editedUser = User(
                    id: _editedUser.id,
                    name: value,
                    age: _editedUser.age,
                    about: _editedUser.about,
                    contact: _editedUser.contact,
                    imageUrl: _editedUser.imageUrl,
                    membership: _editedUser.membership,
                    address: _editedUser.address,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a Name.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initProduct['age'],
                decoration: InputDecoration(labelText: 'Age'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _ageFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_addressFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide an age.';
                  }
//                  if (double.tryParse(value) == null) {
//                    return 'Please enter a valid age.';
//                  }
//                  if (double.parse(value) <= 0) {
//                    return 'Please enter a price > 0';
//                  }
                  return null;
                },
                onSaved: (value) {
                  _editedUser = User(
                    id: _editedUser.id,
                    name: _editedUser.name,
                    age: value,
                    about: _editedUser.about,
                    contact: _editedUser.contact,
                    imageUrl: _editedUser.imageUrl,
                    membership: _editedUser.membership,
                    address: _editedUser.address,
                  );
                },
              ),
              TextFormField(
                initialValue: _initProduct['address'],
                decoration: InputDecoration(labelText: 'Address'),
                textInputAction: TextInputAction.next,
                focusNode: _addressFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_aboutFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a description.';
                  }

                  return null;
                },
                onSaved: (value) {
                  _editedUser = User(
                    id: _editedUser.id,
                    name: _editedUser.name,
                    age: _editedUser.age,
                    about: _editedUser.about,
                    contact: _editedUser.contact,
                    imageUrl: _editedUser.imageUrl,
                    membership: _editedUser.membership,
                    address: value,
                  );
                },
              ),
              TextFormField(
                initialValue: _initProduct['about'],
                decoration: InputDecoration(labelText: 'About'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _aboutFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_contactFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field cannot be empty.';
                  }
                  if (value.length < 10) {
                    return 'Minimum 10 characters required.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedUser = User(
                    id: _editedUser.id,
                    name: _editedUser.name,
                    age: _editedUser.age,
                    about: value,
                    contact: _editedUser.contact,
                    imageUrl: _editedUser.imageUrl,
                    membership: _editedUser.membership,
                    address: _editedUser.address,
                  );
                },
              ),
              TextFormField(
                initialValue: _initProduct['contact'],
                decoration: InputDecoration(labelText: 'Contact'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _contactFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide contact.';
                  }
                  if (value.length != 10) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedUser = User(
                    id: _editedUser.id,
                    name: _editedUser.name,
                    age: _editedUser.age,
                    about: _editedUser.about,
                    contact: value,
                    imageUrl: _editedUser.imageUrl,
                    membership: _editedUser.membership,
                    address: _editedUser.address,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
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
                        ? Center(
                            child: Text('Enter a URL'),
                          )
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
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a url.';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid url';
                        }
                        if (!value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg') &&
                            !value.endsWith('.png')) {
                          return 'Please enter an image URL';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedUser = User(
                          id: _editedUser.id,
                          name: _editedUser.name,
                          age: _editedUser.age,
                          about: _editedUser.about,
                          contact: _editedUser.contact,
                          imageUrl: value,
                          membership: _editedUser.membership,
                          address: _editedUser.address,
                        );
                      },
                    ),
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
