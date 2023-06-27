import 'package:flutter/material.dart';
import 'package:hw15/data/model.dart';
import 'package:hw15/data/repo.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FantasticBeastList extends StatefulWidget {
  final FantasticBeastsRepository beastsRepository;

  const FantasticBeastList({Key? key, required this.beastsRepository}) : super(key: key);

  @override
  FantasticBeastListState createState() => FantasticBeastListState();
}

class FantasticBeastListState extends State<FantasticBeastList> {
  String searchTerm = '';
  String message = '';
  int _selectedIndex = 0;

  final ImagePicker picker = ImagePicker();
  String imageError = '';
  List<FantasticBeastEntity> _beastsList = [];

  Future<void> _getBeasts() async {
    _beastsList = await widget.beastsRepository.getBeasts();
    setState(() {});
  }

  Future<void> _addBeast({
    required String name,
    required String description,
    required String photo,
  }) async {
    await widget.beastsRepository.addBeast(name: name, description: description, photo: photo);
    _getBeasts();
  }

  Future<void> _removeBeast(int id) async {
    await widget.beastsRepository.removeBeast(id);
    _selectedIndex = 0;
    _getBeasts();
  }

  Future<void> _updateBeast({
    required int id,
    required String name,
    required String description,
    required String photo,
  }) async {
    await widget.beastsRepository.updateBeast(id: id, name: name, description: description, photo: photo);
    _getBeasts();
  }

  @override
  void initState() {
    _getBeasts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Волшебные твари"),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _buildPortraitList(context);
          } else {
            return _buildLandscapeList(context);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future _showDialog() {
    XFile? image;
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (_, __, ___) {
        final nameController = TextEditingController();
        final descController = TextEditingController();
        //final photoController = TextEditingController();
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Добавить'),
              scrollable: true,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 150,
                    child: image == null ? const Text("") : Image.file(File(image!.path)),
                  ),
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () async {
                      //Navigator.pop(context);
                      // getImage(ImageSource.gallery);
                      // setState((){});
                      var img = await picker.pickImage(source: ImageSource.gallery);

                      setState(() {
                        image = img;
                        //user!.photo = img != null ? img.path : user!.photo;
                      });
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text(' Выберите фото'),
                      ],
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: 'Название'),
                  ),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(hintText: 'Описание'),
                  ),
                  Text(
                    imageError,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      imageError = '';
                    });
                  },
                  child: const Text('Отменить'),
                ),
                TextButton(
                  onPressed: () {
                    if (image == null || nameController.text.isEmpty || descController.text.isEmpty) {
                      imageError = 'Необходимо заполнить поля';
                      setState(() {});
                    } else {
                      if (image != null) {
                        _addBeast(name: nameController.text, description: descController.text, photo: image!.path);
                        Navigator.pop(context);
                      } else
                        imageError = 'Необходимо заполнить поля';
                    }
                  },
                  child: const Text('Добавить'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future _showUpdateDialog(int index) {
    XFile? image;
    image = _beastsList[index].photo.isNotEmpty ? XFile(_beastsList[index].photo) : null;
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (_, __, ___) {
        final nameController = TextEditingController();
        nameController.text = _beastsList[index].name;
        final descController = TextEditingController();
        descController.text = _beastsList[index].description;
        //final photoController = TextEditingController();
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Редактировать'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  image == null
                      ? const Text("")
                      : Image.file(
                        File(image!.path),

                      ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () async {
                      var img = await picker.pickImage(source: ImageSource.gallery);

                      setState(() {
                        image = img;
                      });
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text(' Изменить фото'),
                      ],
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: 'Название'),
                  ),
                  TextField(
                    controller: descController,
                    maxLines: 3,
                    decoration: const InputDecoration(hintText: 'Описание'),
                  ),
                  Text(
                    imageError,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      imageError = '';
                    });
                  },
                  child: const Text('Отменить'),
                ),
                TextButton(
                  onPressed: () {
                    if (image == null || nameController.text.isEmpty || descController.text.isEmpty) {
                      imageError = 'Необходимо заполнить поля';
                      setState(() {});
                    } else {
                      if (image != null) {
                        _updateBeast(id: _beastsList[index].id, name: nameController.text, description: descController.text, photo: image!.path);
                        Navigator.pop(context);
                      } else
                        imageError = 'Необходимо заполнить поля';
                    }
                  },
                  child: const Text('Сохранить'),
                ),
              ],
            );
          },
        );
      },
    );
  }


  Widget _buildPortraitList(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: _beastsList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) => _buildPortraitMenu(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLandscapeList(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: _beastsList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) => _buildLandscapeMenu(index),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 15),
                        child: _beastsList.isEmpty?const CircularProgressIndicator():_buildDescription(_selectedIndex),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortraitMenu(int index) {
    return Card(
      //margin: EdgeInsets.all(0),
      //elevation: ,
      child: ExpansionTile(
        title: Row(
          children: [
            Container(
              height: 40,
              child: _buildPhotoCircular(index),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                _beastsList[index].name,
                style: const TextStyle(fontSize: 18),
                maxLines: 2,
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8),

              child: _buildDescription(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLandscapeMenu(index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            // устанавливаем индекс выделенного элемента
            _selectedIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: index == _selectedIndex ? const Color(0xffdbf0fd) : Colors.white,
            // border: index == _selectedIndex ? Border.all(color: const Color(0xFF71DEFF), width: 3) : Border.all(color: const Color(0xFFEEEEEE), width: 3),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
            child: Row(
              children: [
                Container(
                  height: 40,
                  child: _buildPhotoCircular(index),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    _beastsList[index].name,
                    style: const TextStyle(fontSize: 18),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(int index) => Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(
            //   height: 10,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPhoto(index),
                _buildButtons(index),
              ],
            ),
            _buildText(index),
          ],
        ),
      );

  Widget _buildButtons(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  _showUpdateDialog(index);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 20,
                ),
                constraints: const BoxConstraints(),
              ),
              IconButton(
                onPressed: () {
                  _removeBeast(_beastsList[index].id);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.blue,
                  size: 20,
                ),
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 5,
        )
      ],
    );
  }

  Widget _buildText(int index) {
    if (_selectedIndex >= 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          _beastsList[index].description,
          style: const TextStyle(fontSize: 18),
        ),
      );
    }
    return const Text('');
  }

  Widget _buildPhoto(int index) {
    return Container(
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(File(_beastsList[index].photo), fit: BoxFit.cover),
      ),

    );
  }

  Widget _buildPhotoCircular(int index) {
    return Container(
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: AspectRatio(
          aspectRatio: 1,
          // child: photo == 'lib/assets/default.jpg' ? Image.asset('lib/assets/default.jpg') : Image.file(
          //   File(photo),
          //   fit: BoxFit.cover,
          // ),
          // child: Image.network(_beastsList[index].url, fit: BoxFit.cover),
          child: Image.file(File(_beastsList[index].photo), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
