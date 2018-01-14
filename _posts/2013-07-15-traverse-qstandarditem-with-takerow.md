---
id: 190
title: Traverse QStandardItem with takeRow
date: 2013-07-15T16:01:22+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=190
permalink: /traverse-qstandarditem-with-takerow/
categories:
  - C++
  - 'Tricks &amp; Tips'
tags:
  - qt
---
If you appendRow a `QList<QStandardItem *>` to a `QStandardItem`, you should get the entire row. However `takeRow` function removes the element thus you cannot use

```cpp
//DO NOT USE THIS
QStandardItem *cName;
for (int k = 0; k < cName->rowCount(); ++k) {
	QList<QStandardItem*> listOfItems = cName->takeRow(k);
}
```

Because `takeRow` deletes the row from the item. You should use this instead:

```cpp
//USE THIS
while (cName->hasChildren()) {
	QList<QStandardItem*> listOfItems = cName->takeRow(0);
}
```
