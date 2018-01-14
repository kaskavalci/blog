---
id: 291
title: What I learned from Floating Points
date: 2015-04-01T18:35:46.000Z
author: Halil Can Kaşkavalcı
layout: single
guid: 'http://kaskavalci.com/?p=291'
permalink: /what-i-learned-from-floating-points/
dsq_thread_id:
  - '5230393414'
categories:
  - Uncategorized
---

OK I confess, I didn't read the legandary [What Every Computer Scientist Should Know About Floating-Point Arithmetic](http://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html) by Goldberg. It's a must-read however sometimes you just need to find your answer, rather than master on a topic, like floating points. Here, I'll list the things I learned from working with FPs, in case you are looking for an answer too.

# A Floating point number is less than `FLT_MIN` or a double number is less than `DBL_MIN`. How is it possible?

Looking for an underflow error? How would you decide if underflow has occured. Underflow is defined by number computed is less than minimum number representable. Documentation of [strtod](http://www.cplusplus.com/reference/cstdlib/strtod) states the following:

> If the correct value would cause underflow, the function returns a value whose magnitude is no greater than the smallest normalized positive number and sets [errno](http://www.cplusplus.com/errno) to [ERANGE](http://www.cplusplus.com/ERANGE).

We expect a number which is less than or equal to FLT_MIN or DBL_MIN. Let's check what exactly those macros are.

**FLT_MIN** : The value of this macro is the minimum normalized positive floating point number that is representable in type `float`. It is supposed to be no more than `1E-37`. [Source](http://www.gnu.org/software/libc/manual/html_node/Floating-Point-Parameters.html).

**DBL_MIN** : Same as FLT_MIN, for double.

In that case, you may ask what is minimum normalized value? Normalized numbers do not have leading zeros in decimal representation of a float. For instance,

```
Normalized : 1.17549e-038 (FLT_MIN)
Subnormal : 0.0017549e-41 (same number)
```

As you can see, even though FLT_MIN_EXP, exponent of minimum float is 38, we can write smaller numbers than it by allowing subnormal numbers. So, when you have a string represents a float smaller than FLT_MIN, it may be still representable and could smaller than FLT_MIN. Let's look at the code:

```c++
void smallerF()
{
  cout << "MIN FLOAT test" << endl;
  errno = 0;
  stringstream ss;
  ss << "1.17549430e-39";
  cout << "Min possible :\t" << FLT_MIN << endl;
  cout << "str: \t\t" << ss.str() << endl;
  float converted = strtof(ss.str().c_str(), NULL);
  cout << "Error: \t\t" << (errno == ERANGE ? "Range error" : "No error") << endl;
  cout << "Converted: \t" << converted << endl;
  cout << "Normal :\t" << (isnormal(converted) ? "True" : "False") << endl;
  cout << "Comparison: \t" << (converted < FLT_MIN ? "smaller" : "greater or equal") << endl;
}
```

The output:

```
MIN FLOAT test

Min possible :  1.17549e-038
str:            1.17549430e-39
Error:          Range error
Converted:      1.17549e-039
Normal :        True
Comparison:     smaller
```

But wait, how? The number is smaller than FLT_MIN by all terms, exponent is smaller than FLT_MIN_10_EXP and it is still normal? Let's take a close look on the both numbers. My favorite tool for examine floats is [IEEE-754 Analysis](http://babbage.cs.qc.cuny.edu/IEEE-754)by Michael Lubow.

Let's check how FLT_MIN is represented in memory.

Decimal      | HEX        | Exponent (Binary) | Exponent (Decimal) | Significand (Decimal)
------------ | ---------- | ----------------- | ------------------ | ---------------------
1.17549e-037 | 0x021FFFD9 | 00000100          | -123               | 1.24999535084
1.17549e-038 | 0x007FFFE0 | 00000000          | -126               | 0.99999618530
1.17549e-039 | 0x000CCCC9 | 00000000          | -126               | 0.19999921322
1.17549e-040 | 0x000147AD | 00000000          | -126               | 0.01999986172

 See the pattern? Exponent is in its minimum. We can't lower the number any further, that's why we hit FLT_MIN_10_EXP limit. (Why it is not -38? Because it is base<sub>2</sub>. 2<sup>-126</sup>=1.175494e-38.) However something else changes, the significand.

Well, that seem subnormal. Why `isnormal()` didn't return false then? Good question, and I don't have the answer. What I see from the tests, `isnormal()` doesn't return false until the number `1.17549430e-46`.

A word about `errno` for underflow. Standard library is not obligated to raise `ERANGE` when underflow occurs. Do not count on it if you will support multiple compilers.
