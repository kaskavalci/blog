---
id: 220
title: Wait for BackgroundWorker process
date: 2013-09-17T15:39:59+00:00
author: Halil Can Kaşkavalcı
layout: single
guid: http://kaskavalci.com/?p=220
permalink: /wait-for-backgroundworker-process/
dsq_thread_id:
  - "5155686684"
categories:
  - 'C#'
---
Let's say your class is BackgroundWorker and you have a child class who is another BackgroundWorker. If a cancellation is requested from user, you want to cancel both child and parent BWs. Here is the code, assume that this is the parent class.

```csharp
private ManualResetEvent mre = new ManualResetEvent(false);

void startBW() {
	BW = new BW(); //BW is BackgroundWorker class
	BW.RunWorkerCompleted += BW_RunWorkerCompleted;
	BW.ProgressChanged += BW_ProgressChanged;
	BW.RunWorkerAsync();

	//wait until it finishes
	mre.WaitOne();
}

void BW_ProgressChanged(object sender, ProgressChangedEventArgs e)
{
	//if cancellation is pending in this thread, notify the child BW
	if (CancellationPending)
	{
		BW.CancelAsync();
	}
}

void BW_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
{
	//when everyting is set, raise flag so that execution will continue.
	mre.Set();
}
```

What happens is you declare a ManualResetEvent which can block current thread to wait until an event has occurred. This variable is controlled by child, when it finishes, in RunWorkerCompleted method, flag is raised. At each progress step, CancellationPending is checked in parent class, if so, child class is being notified.
