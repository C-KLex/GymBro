# Coding Style and Document guidelines

##  🌍Coding style's general format

### Whitespace in Expressions and Statements

1. **Avoid** extraneous whitespace in the following situations:
- Immediately inside parentheses or braces:

```swift
// Correct:
func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
```
```swift
// Wrong:
func deleteItem( indexSet: IndexSet ) {
        items.remove( atOffsets: indexSet )
    }
```
- Immediately before a comma, semicolon, or colon:

```swift
// Correct:
var item1 = ItemModel(title: "First item!", isCompleted: false)
```

```swift
// Wrong:
var item1 = ItemModel(title : "First item!" , isCompleted : false)
```

- Immediately before the open parenthesis that starts the argument list of a function call:

```swift
// Correct:
ListRowView(item: item)
```

```swift
// Wrong:
ListRowView (item: item)
```

- More than one space around an assignment (or other) operator to align it with another:

```swift
// Correct:
var x = 1
var y = 2
var long_variable = 3
```

```swift
// Wrong:
var x             = 1
var y             = 2
var long_variable = 3
```

2. Other Recommendations
- Separating any reserved word starting a conditional or switch statement (such as `if`, `guard`, `while`, or `switch`) from the expression that follows it if that expression starts with an open parenthesis '('.

```swift
// Correct:
if (x == 0 && y == 0) || z == 0 {
  // ...
}
```

```swift
// Wrong:
if(x == 0 && y == 0) || z == 0 {
  // ...
}
```

- Use a space before any closing curly brace '}' that follows code on the same line, before any open curly brace '{', and after any open curly brace '{' that is followed by code on the same line.

```swift
// Correct:
let nonNegativeCubes = numbers.map { $0 * $0 * $0 }.filter { $0 >= 0 }
```

```swift
// Wrong:
let nonNegativeCubes = numbers.map { $0 * $0 * $0 } .filter { $0 >= 0 }
let nonNegativeCubes = numbers.map{$0 * $0 * $0}.filter{$0 >= 0}
```

- On both sides of any binary or ternary operator, including the “operator-like” symbols described below, with exceptions noted at the end:
    - The `=` sign used in assignment, initialization of variables/properties, and default arguments in functions.
    
    ```swift
    // Correct:
    var x = 5

    func sum(_ numbers: [Int], initialValue: Int = 0) {
  // ...
  }
    ```

    ```swift
    // Wrong:
    var x=5

    func sum(_ numbers: [Int], initialValue: Int=0) {
  // ...
  }
    ```
    
    - The ampersand (`&`) in a protocol composition type.
    
    ```swift
    // Correct:
    func sayHappyBirthday(to person: NameProviding & AgeProviding) {
  // ...
  }
    ```

    ```swift
    // Wrong:
    func sayHappyBirthday(to person: NameProviding&AgeProviding) {
  // ...
  }
  ```
    - The arrow (`->`) preceding the return type of a function.
    
    ```swift
    // Correct:
    func textIsAppropriate() -> Bool {
    // ...
    }
    ```

    ```swift
    // Wrong:
    func textIsAppropriate()->Bool {
    // ...
    }
    ```

    - The ternary operator (`_ ? _ : _`) in determing parameters' values.

    ```swift
    // Correct:
    animate ? 1.1 : 1.0
    ```

    ```swift
    // Wrong:
    animate?1.1:1.0
    ```

    - Always surround these binary operators with a single space on either side: assignment (`=`), augmented assignment (`+=`, `-=`, etc.), comparisons (`==`, `<`, `>`, `!=`, `<>`, `<=`, `>=`), Booleans (`&&`, `||`).
    - **Exception**: There is no space on either side of the dot (.) used to reference value and type members.
    
    ```swift
    // Correct:
    let width = view.bounds.width
    ```

    ```swift
    // Wrong:
    let width = view . bounds . width
    ```
    - **Exception**: There is no space on either side of the `..<` or `...` operators used in range expressions.
    
    ```swift
    // Correct:
    for number in 1...5 {
  // ...
  }
  let substring = string[index..<string.endIndex]
    ```

    ```swift
    // Wrong:
    for number in 1 ... 5 {
  // ...
  }
  let substring = string[index ..< string.endIndex]
    ```

### Vertical Whitespace (Blank Lines)
- A single blank line appears in the following locations:
    - Between consecutive members of a type: properties, initializers, methods, enum cases, and nested types, except that:
        - A blank line is optional between two consecutive stored properties or two enum cases whose declarations fit entirely on a single line. Such blank lines can be used to create logical groupings of these declarations.
        - A blank line is optional between two extremely closely related properties that do not otherwise meet the criterion above; for example, a private stored property and a related public computed property.
    - Only as needed between statements to organize code into logical subsections.
    - Optionally before the first member or after the last member of a type (neither is encouraged nor discouraged).
    - Anywhere explicitly required by other sections of this document.
- Multiple blank lines are permitted, but never required (nor encouraged). If you do use multiple consecutive blank lines, do so consistently throughout your code base.

### Parentheses
- Parentheses are **not** used around the top-most expression that follows an `if`, `guard`, `while`, or `switch` keyword.

```swift
// Correct:
if x == 0 {
  print("x is zero")
}

if (x == 0 || y == 1) && z == 2 {
  print("...")
}
```

```swift
// Wrong:
if (x == 0) {
  print("x is zero")
}

if ((x == 0 || y == 1) && z == 2) {
  print("...")
}
```

### Braces
- There is **no** line break before the opening brace '{'.
- There is a line break after the opening brace '{', except
    - in closures, where the signature of the closure is placed on the same line as the curly brace, if it fits, and a line break follows the in keyword.
    - where it may be omitted as described in one statement per line.
    ```
    guard let value = value else { return 0 }
    ```
    - empty blocks may be written as {}.
- There is a line break before the closing brace '}', except where it may be omitted as described in one statement per line, or it completes an empty block.
- There is a line break after the closing brace '}', **if and only if** that brace terminates a statement or the body of a declaration. For example, an else block is written `} else {` with both braces on the same line.

## 📚Formatting Specific Constructs


### Properties
- With the exception of tuple destructuring, every `let` or `var` statement (whether a property or a local variable) declares exactly one variable.

```swift
// Correct:
var a = 5
var b = 10

let (quotient, remainder) = divide(100, 9)
```

```swift
// Wrong:
var a = 5, b = 10
```

### Switch Statements
Case statements are indented at the same level as the switch statement to which they belong; the statements inside the case blocks are then indented +4 spaces (a tab) from that level.

```swift
// Correct:
switch order {
case .ascending:
    print("Ascending")
case .descending:
    print("Descending")
case .same:
    print("Same")
}
```

```swift
// Wrong:
switch order {
case .ascending:
print("Ascending")
case .descending:
print("Descending")
case .same:
print("Same")
}
```

```swift
// Wrong:
switch order {
    case .ascending:
        print("Ascending")
    case .descending:
        print("Descending")
    case .same:
        print("Same")
}
```

### Enum Cases
- In general, there is only one `case` per line in an `enum`. The comma-delimited form may be used only when none of the cases have associated values or raw values, all cases fit on a single line, and the cases do not need further documentation because their meanings are obvious from their names.

```swift
// Correct
enum Token {
    case comma
    case semicolon
    case identifier
}

enum Token {
    case comma, semicolon, identifier
}

enum Token {
    case comma
    case semicolon
    case identifier(String)
}
```

```swift
// Wrong:
enum Token {
    case comma, semicolon, identifier(String)
}
```

### Trailing Commas
- Trailing commas in array and dictionary literals are required when each element is placed on its own line. Doing so produces cleaner diffs when items are added to those literals later.

```swift
// Correct:
let configurationKeys = [
      "bufferSize",
      "compression",
      "encoding",                         // GOOD.
]
```

```swift
// Wrong:
let configurationKeys = [
      "bufferSize",
      "compression",
      "encoding"                          // AVOID.
]
```

- However it does not make sense to have a trailing comma on the same line as the closing delimiter.

```swift
// Correct:
# Correct:
FILES = [
    'setup.cfg',
    'tox.ini',
    ]
initialize(FILES,
           error=True,
           )
```

```swift
// Wrong:
FILES = ['setup.cfg', 'tox.ini',]
initialize(FILES, error=True,)
```

### Other Recommendations
- Compound statements (multiple statements on the same line) are generally discouraged:

```swift
// Correct:
if foo == 'blah':
    do_blah_thing()
do_one()
do_two()
do_three()
```

```swift
// Wrong:
if foo == 'blah': do_blah_thing()
do_one(); do_two(); do_three()
```
- While sometimes it’s okay to put an `if`/`for`/`while` with a small body on the same line, never do this for multi-clause statements. Also avoid folding such long lines.
Rather not:

```swift
// Wrong:
if foo == 'blah': do_blah_thing()
for x in lst: total += x
while t < 10: t = delay()
```

Definitely not:

```swift
// Wrong:
if foo == 'blah': do_blah_thing()
else: do_non_blah_thing()

try: something()
finally: cleanup()

do_one(); do_two(); do_three(long, argument,
                             list, like, this)

if foo == 'blah': one(); two(); three()
```

## 📜Naming conventions


It is important that naming should only include `alphabetic & numerical` characters!! In addition, naming should be as short and meaningful as possible. Make sure to keep it short and in an easily understandable format. The following are the naming conventions.

* Files: PascalCase
* Class: PascalCase
* Function: camelCase
* Variables: camelCase
* Dates: YYYYMMDD
* Versions: xxx001, xxx002

Here's an example of the file "ArithmeticOfTwoNumber.swift".

```swift
class ArithmeticOfTwoNumber {

    func addTwoNum(a: Int, b: Int) -> Int {
        return a + b
    }

    func subTwoNum(a: Int, b: Int) -> Int {
        return a - b
    }

    func mulTwoNum(a: Int, b: Int) -> Int {
        return a * b
    }

    func divTwoNum(a: Int, b: Int) -> Int {
        return a / b
    }

}
```

## ✏️Github guideline


Follow the guidelines when using github operations.

1. One commit per pull request!!
2. Make sure your code is following the coding guidance
3. Test and avoid possible errors before sending a pull request
4. Keep every pull request as small as possible
5. Write meaningful description in commit message
6. Follow the documentation guidelines


## ✒Example Script without Documentation



```swift
import SwiftUI

struct ContentView: View {
    
    @State var isBlack: Bool = true
    @State var count: Int = 0
    
    var body: some View {
        ZStack {
            background
            
            VStack {
                greetingLine
                addButton
            }
        }
    }
    
    private var background: some View {
        isBlack ? Color.black.ignoresSafeArea() : Color.red.ignoresSafeArea()
    }
    
    private var greetingLine: some View {
        getTextWithNumber(title: "HI HOW ARE YOU", number: count)
            .font(.title)
            .foregroundColor(.white)
    }
    
    private var addButton: some View {
        getText(title: "Add")
            .padding()
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 100, height: 50)
            .background(Color.blue)
            .cornerRadius(20)
            .onTapGesture {
                withAnimation(Animation.spring()) {
                    isBlack.toggle()
                    countAddOne()
                }
            }
    }
    
    func countAddOne() -> Void {
        count += 1
    }
    
    func getText(title: String) -> Text {
        return Text(title.uppercased())
            
    }
    
    func getTextWithNumber(title: String, number: Int) -> Text {
        
        var content = title
        
        content += ": "
        content += String(number)
        
        return Text(content)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

```

## **📄Documentation Guideline**

### **📑Mark**

* Description

    The mark flag aims to create the section on the script.

* Usage

    ```swift
    // MARK: PROPERTY
        
        @State var isBlack: Bool = true
        @State var count: Int = 0 
    ```

* **!!Flag Allowed!!**

    ```swift
    // MARK: PROPERTY
    // MARK: BODY
    // MARK: METHOD
    // MARK: COMPONENT
    // MARK: PREVIEW
    ```

* Guide

  * **2 black lines above the mark and 1 blank line below the mark.**
  * It's not mandatory but highly recommended to use in the long script file.

    ```swift
        import SwiftUI

        struct ContentView: View {


            // MARK: PROPERTY
            
            @State var isBlack: Bool = true
            

            // MARK: BODY

            var body: some View {...}
            

            // MARK: COMPONENT 

            private var background: some View {...}
            

            // MARK: METHOD
            
            func countAddOne() -> Void {...}
        }
    ```

### **💻Code Comment**

* Style
  * Single Line

    Format:

    ```swift
    // write anything 
    ```

  * Multiple Lines

    ```swift
    // anything 
    /*
    anything more detail
    */
    ```

* Guide
  * Comment Above  
  * 1 blank line above the comment, 0 blank line below the comment.

    ```swift
    var body: some View {
        ZStack {

            // Background - Background color with animation.
            background
                
            // Content
            /*
            Consist:
            1. Greeting line.
            2. SAVE button.
            */
            VStack {
                greetingLine
                addButton
            }
        }
    }
    ```

### **🎮Xcode Document**

#### Guide

* Structure

    1. Summary **(BARE MINIMUM)**
    2. Discussion
    3. Code Example
    4. Flag

    ```swift
        /// Summary section.
        ///
        /// Discussion section.
        ///
        /// ```
        /// Example code section.
        /// ```
        ///
        /// - Warning: Give a warning.
        /// - Parameters:
        ///   - parameter name: Description of the parameter.
        /// - Returns: Return description.
        func getTextWithNumber(title: String, number: Int) -> Text {...}
    ```

* Leave 1 blank line above the documentation and 0 blank line below.
* What Must To Documnet
  * Script File
  * Method
  * Property

#### Example

* Script File

    ```swift
    import SwiftUI

    /// A interactive greeting page.
    ///
    /// The page consists with a line of greeting, a ADD button, and a dynamic text field.
    struct ContentView: View {
        ...
    }
    ```

* Property  

    ```swift
    /// Background color status.
    @State var isBlack: Bool = true
    
    /// Number count.
    ///
    /// It records the number of tapping on ADD button.
    @State var count: Int = 0
    ```

* Method

    ```swift
    /// Gets a Text with a string combined with a integer
    ///
    /// The function creates and returns a Text immediately. The Text will combined with a line of String and a Integer number.
    ///
    /// ```
    /// getTextWithNumber(title: "HI", number: 9) -> Text("HI: 9")
    /// ```
    /// - Warning: There is no style for the Text.
    /// - Parameters:
    ///   - title: Title for the Text object.
    ///   - number: A integer comes after the title.
    /// - Returns: Returns a text with a string and a integer number.

    func getTextWithNumber(title: String, number: Int) -> Text {...}
    ```

* Component

    ```swift
    // Background color view.
    ///
    /// Background color have an animation on changing color.
    private var background: some View {...}
    
    /// Text line.
    ///
    /// The number at the end of the text is dinamically changing.
    private var greetingLine: some View {...}
    ```

## 🙌Example Script with Documentation

```swift
import SwiftUI

/// A interactive greeting page.
///
/// The page consists with a line of greeting text, a ADD button, and a dynamic variable.
struct ContentView: View {
    
    
    // MARK: PROPERTY
    
    /// Background color status.
    @State var isBlack: Bool = true
    
    /// Number count.
    ///
    /// It records the number of tapping on ADD button.
    @State var count: Int = 0
    
    
    // MARK: BODY
    
    var body: some View {
        ZStack {
            
            // BACKGROUND
            background
            
            // Content
            /*
            with:
            1. greeting line
            2. ADD button
            */
            VStack {
                greetingLine
                addButton
            }
        }
    }
    
    
    // MARK: COMPENENT
    
    /// Background color view.
    ///
    /// Background color have an animation on changing color.
    private var background: some View {
        isBlack ? Color.black.ignoresSafeArea() : Color.red.ignoresSafeArea()
    }
    
    /// Text line.
    ///
    /// The number at the end of the text is dinamically changing.
    private var greetingLine: some View {
        getTextWithNumber(title: "HI HOW ARE YOU", number: count)
            .font(.title)
            .foregroundColor(.white)
    }
    
    /// A tapping button.
    ///
    /// Tapping the button would increase the number by one, the number shown in the greetingLine
    private var addButton: some View {
        getText(title: "Add")
            .padding()
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 100, height: 50)
            .background(Color.blue)
            .cornerRadius(20)
            .onTapGesture {
                withAnimation(Animation.spring()) {
                    isBlack.toggle()
                    countAddOne()
                }
            }
    }
    
    
    // MARK: METHOD
    
    /// The function simple add the variable count by 1.
    /// - Returns: Void
    func countAddOne() -> Void {
        count += 1
    }
    
    /// Gets a Text with a title in uppercase.
    ///
    /// The function creates and returns a Text immediately. The Text will ONLY have title based on the input parameter title.
    /// ```
    /// getText(title: "hi how are you") -> Text("hi how are you")
    /// ```
    /// - Warning: There is no style for the Text object.
    /// - Parameter title: Title for the text.
    /// - Returns: Returns a text with a title.
    func getText(title: String) -> Text {
        return Text(title.uppercased())
            
    }
    
    /// Gets a Text with a string combined with a integer
    ///
    /// The function creates and returns a Text immediately. The Text will combined with a line of String and a Integer number.
    ///
    /// ```
    /// getTextWithNumber(title: "HI", number: 9) -> Text("HI: 9")
    /// ```
    /// - Warning: There is no style for the Text.
    /// - Parameters:
    ///   - title: Title for the Text object.
    ///   - number: A integer comes after the title.
    /// - Returns: Returns a text with a string and a integer number.

    func getTextWithNumber(title: String, number: Int) -> Text {
        
        var content = title
        
        content += ": "
        content += String(number)
        
        return Text(content)
    }
}


// MARK: PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
