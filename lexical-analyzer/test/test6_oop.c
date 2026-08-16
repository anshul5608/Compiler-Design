class Shape {
protected:
    int width, height;
private:
    int id;
public:
    Shape() {}
};

// Inheritance
class Rectangle : public Shape {
public:
    int getArea() {
        return width * height;
    }
};

int main() {
    Rectangle rect; // Object
    return 0;
}