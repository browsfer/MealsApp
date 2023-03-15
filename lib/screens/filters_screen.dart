import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters-screen';

  final Function(Map<String, bool>) saveFilters;
  Map<String, bool> currentFilters;
  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactoseFree = false;
  bool _glutenFree = false;

  @override
  void initState() {
    _vegan = widget.currentFilters['vegan'] == true;
    _vegetarian = widget.currentFilters['vegetarian'] == true;
    _lactoseFree = widget.currentFilters['lactose'] == true;
    _glutenFree = widget.currentFilters['gluten'] == true;

    super.initState();
  }

  Widget _buildSwitchListTile(String titleText, String subtitleText,
      bool currentValue, ValueChanged updateValue) {
    return SwitchListTile(
      value: currentValue,
      onChanged: updateValue,
      title: Text(
        titleText,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(subtitleText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };

                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save),
            ),
          ],
          title: Text('Your filters'),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                    'Gluten-free',
                    'Only gluten-free meals.',
                    _glutenFree,
                    (newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Vegan',
                    'Only vegan meals.',
                    _vegan,
                    (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Vegetarian',
                    'Only vegetarian meals.',
                    _vegetarian,
                    (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Lactose-free',
                    'Only lactose-free meals.',
                    _lactoseFree,
                    (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }
}
