class Book {
  String title;
  String author;
  String isbn;
  bool isAvailable = true;

  Book(this.title, this.author, this.isbn);

  void displayInfo() {
    print("Book: $title, Author: $author, ISBN: $isbn, Available: $isAvailable");
  }
}
abstract class User {
  String name;
  String id;
  List<Book> borrowedBooks = [];

  User(this.name, this.id);

  void borrowBook(Book book);
  void returnBook(Book book);
}
class Student extends User {
  Student(String name, String id) : super(name, id);

  @override
  void borrowBook(Book book) {
    if (book.isAvailable) {
      borrowedBooks.add(book);
      book.isAvailable = false;
      print("$name borrowed ${book.title}");
    } else {
      print("${book.title} is not available.");
    }
  }

  @override
  void returnBook(Book book) {
    borrowedBooks.remove(book);
    book.isAvailable = true;
    print("$name returned ${book.title}");
  }
}

class Teacher extends User {
  Teacher(String name, String id) : super(name, id);

  @override
  void borrowBook(Book book) {
    if (book.isAvailable) {
      borrowedBooks.add(book);
      book.isAvailable = false;
      print("$name borrowed ${book.title}");
    } else {
      print("${book.title} is not available.");
    }
  }

  @override
  void returnBook(Book book) {
    borrowedBooks.remove(book);
    book.isAvailable = true;
    print("$name returned ${book.title}");
  }
}
class Library {
  List<Book> books = [];

  void addBook(Book book) {
    books.add(book);
    print("Book ${book.title} added to library.");
  }

  void displayBooks() {
    for (var book in books) {
      book.displayInfo();
    }
  }
}
void main() {
  Library library = Library();

  Book book1 = Book("Dart Programming", "John Smith", "12345");
  Book book2 = Book("OOP Concepts", "Alice Brown", "67890");

  library.addBook(book1);
  library.addBook(book2);

  Student student = Student("Alice", "S101");
  Teacher teacher = Teacher("Dr. Bob", "T202");

  library.displayBooks();

  student.borrowBook(book1);
  teacher.borrowBook(book1); // Should show "not available"

  student.returnBook(book1);
  teacher.borrowBook(book1); // Should succeed now

  library.displayBooks();
}
