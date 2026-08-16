class Shape {
protected:
    int width, height;
private:
    int id;
public:
    Shape() {}
};

class Rectangle : public Shape {
public:
    int getArea() {
        return width * height;
    }
};

int main() {
    Rectangle rect;
    return 0;
}
