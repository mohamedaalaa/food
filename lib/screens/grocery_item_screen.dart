import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:food/components/grocery_tile.dart';
import 'package:food/models/fooderlich_pages.dart';
import 'package:food/models/grocery_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;
  // 2
  final Function(GroceryItem,int) onUpdate;
  // 3
  final GroceryItem? originalItem;

  final int index;

  // 4
  final bool isUpdating;

  static MaterialPage page({
    GroceryItem? item,
    int index = -1,
    required Function(GroceryItem) onCreate,
    required Function(GroceryItem, int) onUpdate,
  }) {
    return MaterialPage(
      name: FooderlichPages.groceryItemDetails,
      key: ValueKey(FooderlichPages.groceryItemDetails),
      child: GroceryItemScreen(
        originalItem: item,
        index: index,
        onCreate: onCreate,
        onUpdate: onUpdate,
      ),
    );
  }


  const GroceryItemScreen(
      {Key? key,
      required this.onCreate,
      required this.onUpdate,
      this.originalItem,
        this.index=-1
      })
      : isUpdating = (originalItem != null), super(key: key);

  @override
  _GroceryItemScreenState createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {

  final _nameController=TextEditingController();
  String _name='';
  final Importance _importance=Importance.low;
  DateTime _dueDate=DateTime.now();
  TimeOfDay _timeOfDay=TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();
    final originalItem=widget.originalItem;
    if(originalItem!=null){
      _nameController.text=originalItem.name;
      _name=originalItem.name;
      _currentSliderValue=originalItem.quantity;
      _currentColor=originalItem.color;
      final date=originalItem.date;
      _timeOfDay=TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate=date;
    }

    _nameController.addListener(() {
      setState(() {
        _name=_nameController.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            final groceryItem = GroceryItem(
              id: widget.originalItem?.id ?? const Uuid().v1(),
              name: _nameController.text,
              importance: _importance,
              color: _currentColor,
              quantity: _currentSliderValue,
              date: DateTime(
                _dueDate.year,
                _dueDate.month,
                _dueDate.day,
                _timeOfDay.hour,
                _timeOfDay.minute,
              ),
            );

            if (widget.isUpdating) {
              // 2
              widget.onUpdate(groceryItem,widget.index);
            } else {
              // 3
              widget.onCreate(groceryItem);
            }
          }, icon: const Icon(Icons.check))
        ],
        title: Text("Grocery Item",style: GoogleFonts.lato(fontWeight: FontWeight.w600)),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            buildDatePicker(context),
            const SizedBox(height: 10.0),
            buildColorPicker(context),
            const SizedBox(height: 10.0),
            buildQuantityField(),
            GroceryTile(
              item: GroceryItem(
                importance: _importance,
                quantity: _currentSliderValue,
                id: 'previewMode',
                name:_name,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
                color: _currentColor),
            )
          ],
        ),
      ),
    );

  }


  Widget buildNameField() {
    // 1
    return Column(
      // 2
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 3
        Text(
          'Item Name',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        // 4
        TextField(
          // 5
          controller: _nameController,
          // 6
          cursorColor: _currentColor,
          // 7
          decoration: InputDecoration(
            // 8
            hintText: 'E.g. Apples, Banana, 1 Bag of salt',
            // 9
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        ),
      ],
    );
  }



  Widget buildImportanceField(){
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        Wrap(
          spacing: 10.0,
          children: [


            ChoiceChip(
              selectedColor: Colors.black,
                label: const Text(
                  'low',
                  style: TextStyle(color: Colors.white),
                ),
                selected: _importance==Importance.low,
              onSelected: (selected){
                setState(() {
                  _importance==Importance.low;
                });
              },
            ),

            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance==Importance.medium,
              onSelected: (selected){
                setState(() {
                  _importance==Importance.medium;
                });
              },
            ),

            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'high',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance==Importance.high,
              onSelected: (selected){
                setState(() {
                  _importance==Importance.high;
                });
              },
            ),
          ],
        )
      ],
    );
  }

  Widget buildDatePicker(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
                onPressed: ()async{
                  final currentDate=DateTime.now();
                  final selectedDate=await showDatePicker(
                      context: context,
                      lastDate: DateTime(currentDate.year+5),
                      firstDate: currentDate,
                      initialDate: currentDate
                  );

                  setState(() {
                    if(selectedDate!=null){
                      _dueDate=selectedDate;
                    }
                  });
                },
                child: const Text("Select"))
          ],
        ),
        Text(DateFormat('yyyy-MM-dd').format(_dueDate)),
      ],
    );
  }

  Widget buildTimeField(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Time of Day',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        TextButton(
          child: const Text('Select'),
          onPressed: () async {
            // 1
            final timeOfDay = await showTimePicker(
              // 2
              initialTime: TimeOfDay.now(),
              context: context,
            );

            // 3
            setState(() {
              if (timeOfDay != null) {
                _timeOfDay = timeOfDay;
              }
            });
          },
        ),
        Text(_timeOfDay.format(context)),
      ],
    );
  }


  Widget buildColorPicker(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children:[
        Container(
          height: 50.0,
          width: 10.0,
          color: _currentColor,
        ),
        const SizedBox(width: 8.0),
        Text(
          'Color',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),],),
        TextButton(
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: BlockPicker(
                        pickerColor: Colors.white,
                        onColorChanged: (Color value) {
                          setState(() {
                            _currentColor=value;
                          });
                        },
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Save'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }, child: const Text('Select'))
      ],
    );
  }


  Widget buildQuantityField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            const SizedBox(width: 16.0),
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18.0),
            ),
          ],
        ),
        Slider(
            inactiveColor: _currentColor.withOpacity(0.5),
            activeColor: _currentColor,
            min: 0.0,
            max: 100.0,
            divisions: 100,
            label: _currentSliderValue.toInt().toString(),
            value: _currentSliderValue.toDouble(),
            onChanged: (value){
              setState(() {
                _currentSliderValue=value.toInt();
              });
            })
      ],
    );
  }


}
