# Code Style Guide

## Indentation

Use 4 spaces per indentation level

Make simple line, if function name is short.

```bsl
// Yes:

Function Foo(Param1, Param2)
    
    Return "Bar";
    
EndFunction
```

More indentation included to distinguish this from the rest.

```bsl
// Yes:

Function LongFunctionName(
        Param1,
        Param2,
        Param3,
        Param4
    )
    
    Return "Foo";
    
EndFunction
```

Add some extra line on the conditional continuation line.

```bsl
// Yes:

If ThisIsOneIning
    And ThatIsAnotherThing Then
    
    DoSomething();
EndIf;
```

The closing brace/bracket/parenthesis on multiline constructs must be lined up under the first character of the line that starts the multiline construct, as in:

```bsl
// Yes:

MyList = [
    1, 2, 3,
    4, 5, 6,
]

// Yes:

Result = SomeFunctionThatTakesArguments(
    'a', 'b', 'c',
    'd', 'e', 'f',
)

// Yes:

Result = SomeFunctionThatTakesArguments('a', 'b');

// No:

Result = SomeFunctionThatTakesArguments('a',
                                        'b');

```

## Tabs or Spaces?

Spaces are the preferred indentation method.

Tabs should be used solely to remain consistent with code that is already indented with tabs.

## Maximum Line Length

Limit all lines to a maximum of `120` characters.

## Should a Line Break Before or After a Binary Operator?

For decades the recommended style was to break after binary operators. But this can hurt readability in two ways: the operators tend to get scattered across different columns on the screen, and each operator is moved away from its operand and onto the previous line. Here, the eye has to do extra work to tell which items are added and which are subtracted:

```bsl
// No: operators sit far away from their operands

Income = (GrossWages +
          TaxableInterest +
          (Dividends - QualifiedDividends) -
          IraDeduction -
          StudentLoanInterest)
```

Following the tradition from mathematics usually results in more readable code:

```bsl
Yes: easy to match operators with operands

Income = (GrossWages
          + TaxableInterest
          + (Dividends - QualifiedDividends)
          - IraDeduction
          - StudentLoanInterest)
```

## Blank Lines

Method definitions inside a module are surrounded by a single blank line.

Extra blank lines may be used (sparingly) to separate groups of related functions. Blank lines may be omitted between a bunch of related one-liners (e.g. a set of dummy implementations).

Use blank lines in functions, sparingly, to indicate logical sections.

# Whitespace in Expressions and Statements

Avoid extraneous whitespace in the following situations:

* Immediately inside parentheses, brackets or braces.

Yes: `Spam(Ham[1], Eggs(2))`

No:  `Spam( Ham[ 1 ], Eggs (2) )`

* Immediately before a comma, semicolon, or colon:

Yes: `Print(x,, y);`

No:  `Print(x , , y);`

* Immediately before the open parenthesis that starts the argument list of a function call:

Yes: `Spam(1)`

No:  `Spam (1)`

* Immediately before the open parenthesis that starts an indexing or slicing:

Yes: `Dct["key"] = Lst[Index]`

No:  `Dct ["key"] = Lst [Index]`

* More than one space around an assignment (or other) operator to align it with another.

```bsl
// Yes:

x = 1
y = 2
LongVariable = 3

// No:

x            = 1
y            = 2
LongVariable = 3
```
## Other Recommendations

* Avoid trailing whitespace anywhere. Because it's usually invisible, it can be confusing: e.g. a backslash followed by a space and a newline does not count as a line continuation marker.

* Always surround these binary operators with a single space on either side: assignment (`=`), comparisons (`=, <, >, <>, <=, >=`), Booleans (`And, Or, Not`).

* If operators with different priorities are used, consider adding whitespace around the operators with the lowest priority(ies). Use your own judgment; however, never use more than one space, and always have the same amount of whitespace on both sides of a binary operator.

```bsl
// Yes:

i = i + 1
x = x*2 - 1
Hypot2 = x*x + y*y
c = (a+b) * (a-b)

// No:

i=i+1
x = x * 2 - 1
Hypot2 = x * x + y * y
c = (a + b) * (a - b)
```

* Use spaces around the = sign when used to indicate a keyword argument or a default parameter value.

```bsl
// Yes:

Function Complex(real, imag = 0.0)
    Return Magic(real, imag);
EndFunction

// No:

Function Complex(real, imag=0.0)
    Return Magic(real, imag);
EndFunction
```

* Compound statements (multiple statements on the same line) are generally discouraged.

```bsl
// Yes:

If foo='blah' Then
    DoBlahThing();
EndIf;
DoOne();
DoTwo();
DoThree();

// No:

If foo = 'blah' Then DoBlahThing() EndIf;
DoOne(); DoTwo(); DoThree();
```

# Comments
Comments that contradict the code are worse than no comments. Always make a priority of keeping the comments up-to-date when the code changes!

Comments should be complete sentences. The first word should be capitalized.

## Block Comments
Block comments generally apply to some (or all) code that follows them, and are indented to the same level as that code. Each line of a block comment starts with a `//` and a single space (unless it is indented text inside the comment).

Paragraphs inside a block comment are separated by a line containing a single `//`.

## Inline Comments
Use inline comments sparingly.

An inline comment is a comment on the same line as a statement. Inline comments should be separated by at least `two spaces` from the statement. They should start with a `//` and a `single space`.

## Documentation Strings

Conventions for writing good documentation strings in TODO.

# Naming Conventions

## Descriptive: Naming Styles

There are a lot of different naming styles. It helps to be able to recognize what naming style is being used, independently from what they are used for.

The following naming styles are commonly distinguished:

* `b` (single lowercase letter)
* `B` (single uppercase letter)
* `lowercase`
* `lower_case_with_underscores`
* `UPPERCASE`
* `UPPER_CASE_WITH_UNDERSCORES`
* `CapitalizedWords` (or `CapWords`, or `CamelCase`)
* `mixedCase` (differs from `CapitalizedWords` by initial lowercase character!)
* `Capitalized_Words_With_Underscores` (ugly!)

In addition, the following special forms using leading or trailing underscores are recognized (these can generally be combined with any case convention):

* `_SingleLeadingUnderscore`: weak "internal use" indicator.
* `SingleTrailingUnderscore_`: used by convention to avoid conflicts with 1C:Enterprise keyword.

## Global Variable Names
(Let's hope that these variables are meant for use inside one module only.) The conventions are about the same as those for functions.

Modules that are designed for use mechanism to prevent exporting globals (which you might want to do to indicate these globals are "module non-public").

## Function and Variable Names

Function names should be `CapitalizedWords`.
Variable names follow the same convention as function names.

## Constants

Constants are usually defined on a module level and written in all capital letters with underscores separating words. Examples include `MAX_OVERFLOW` and `TOTAL`.

## Public and Private Interfaces

Any backwards compatibility guarantees apply only to public interfaces. Accordingly, it is important that users be able to clearly distinguish between public and internal interfaces.

Without underscore method name considered public, undescored declares them to be provisional or internal interfaces exempt from the usual backwards compatibility guarantees.

Totaly 2 scope:
- Public - using for everyone with backward compatibility.
- Private - using inside only one subsystem.

Public types with `CamelCases`.

Private starts with `_` (dash) and types with `_CamelCases`.

## Function as structure builder

Always use `Self` for the name of result stucture.
