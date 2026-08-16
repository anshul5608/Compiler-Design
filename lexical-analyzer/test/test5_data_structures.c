typedef unsigned long ulong;

enum Status { IDLE, RUNNING, STOPPED };

union DataValue {
    int intVal;
    float floatVal;
};

struct Node {
    int id;
    union DataValue data;
    enum Status currentStatus;
};

int main() {
    struct Node myNode;
    myNode.currentStatus = RUNNING;
    return 0;
}