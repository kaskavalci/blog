---
id: 223
title: Data binding is not updating property
date: 2013-09-17T17:41:29+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=223
permalink: /data-binding-is-not-updating-property/
categories:
  - 'C#'
---
You used DataBinding to bind a property to an object but even though state has been changed, your object is not updated. In my case I have a CheckBox and I bound it to another class' variable. Settings is the other class and Form1 is the main GUI.

In the following example you will see how to bind a CheckBox to a bool variable. Further, that variable resides in another Class instance. By adding DataSourceUpdateMode update mode is changed to OnPropertyChanged. In the end, property is changed at each change in the CheckBox.

```csharp
public class Settings
{
	private bool showid = true;
	public bool showID
	{
		get
		{
			return showid;
		}
		set
		{
			showid = value;
		}
	}
}

public class Form1
{
	private CheckBox ShowID;
	public Form1()
	{
		Settings mySettings = new Settings();
		this.ShowID.DataBindings.Add("Checked", mySettings, "showID");
		this.ShowID.DataBindings[0].DataSourceUpdateMode = DataSourceUpdateMode.OnPropertyChanged;
	}
}
```
