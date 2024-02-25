import 'package:flexirank/flexirank.dart';

class ShoppingListItem {
  ShoppingListItem({required String title, required String rank}) : item = MapEntry(title, rank);

  final MapEntry<String, String> item;

  String get title => item.key;
  String get rank => item.value;
}

class ShoppingList {
  final Map<String, String> items = {};

  void add(ShoppingListItem item) {
    items[item.title] = item.rank;
  }

  String rankFor(String title) => items[title] ?? '';

  void moveItem(String title, {required String newRank}) {
    items[title] = newRank;
  }

  void show() {
    final mapToList = items.entries.toList();
    mapToList.sort((a, b) => a.value.compareTo(b.value));
    print(mapToList.map((e) => e.key).toList());
  }
}

void main() {
  var shoppingList = ShoppingList();

  //? Example 1: add milk as first item in shopping list

  // create new rank for first item
  var rank = FlexiRank.newRank();
  shoppingList.add(ShoppingListItem(title: 'Milk', rank: rank));

  shoppingList.show();
  //* Output: [Milk]

  //? Example 2: add eggs below milk

  // create new rank when adding item to bottom of list
  rank = FlexiRank.newRank(previousItemRank: shoppingList.rankFor('Milk'));
  shoppingList.add(ShoppingListItem(title: 'Eggs', rank: rank));

  shoppingList.show();
  //* Output: [Milk, Eggs]

  //? Example 3: add cheese above milk

  // create new rank when adding item to top of list
  rank = FlexiRank.newRank(nextItemRank: shoppingList.rankFor('Milk'));
  shoppingList.add(ShoppingListItem(title: 'Cheese', rank: rank));

  shoppingList.show();
  //* Output: [Cheese, Milk, Eggs]

  //? Example 4: add chicken between cheese and milk

  // create new rank when adding item in between two items
  rank = FlexiRank.newRank(previousItemRank: shoppingList.rankFor('Cheese'), nextItemRank: shoppingList.rankFor('Milk'));
  shoppingList.add(ShoppingListItem(title: 'Chicken', rank: rank));

  shoppingList.show();
  //* Output: [Cheese, Chicken, Milk, Eggs]

  //? Example 5: move cheese between milk and eggs
  rank = FlexiRank.newRank(previousItemRank: shoppingList.rankFor('Milk'), nextItemRank: shoppingList.rankFor('Eggs'));
  shoppingList.moveItem('Cheese', newRank: rank);

  shoppingList.show();
  //* Output: [Chicken, Milk, Cheese, Eggs]

  //? Example 6: move eggs to top of the list
  rank = FlexiRank.newRank(nextItemRank: shoppingList.rankFor('Chicken'));
  shoppingList.moveItem('Eggs', newRank: rank);

  shoppingList.show();
  //* Output: [Eggs, Chicken, Milk, Cheese]

  //? Example 7: move chicken to bottom of the list
  rank = FlexiRank.newRank(previousItemRank: shoppingList.rankFor('Cheese'));
  shoppingList.moveItem('Chicken', newRank: rank);

  shoppingList.show();
  //* Output: [Eggs, Milk, Cheese, Chicken]
}
