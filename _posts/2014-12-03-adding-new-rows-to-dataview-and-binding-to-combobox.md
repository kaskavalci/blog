---
id: 260
title: Adding new rows to DataView and binding to ComboBox
date: 2014-12-03T16:40:31+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=260
permalink: /adding-new-rows-to-dataview-and-binding-to-combobox/
categories:
  - 'C#'
---
Even though it's a very, very simple problem, it took me a while since I was focusing on a different part of the problem. Here is the code snippet in case anybody needs. Binding to ComboBox is a bonus 🙂

```csharp
void addNewRow(DataView dataView)
{
    DataRowView newRow = dataView.AddNew();
    newRow["Column Name"] = "Column Value";
    newRow.EndEdit();

    comboBoxViews.ItemsSource = dataView.Cast<DataRowView>().Select(o => o["Column Name"]);
}
```
