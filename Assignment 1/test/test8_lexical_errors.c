int main() {
    // 1. Unexpected character
    int @invalid = 5;

    // 2. Another unexpected character
    int `bad_symbol = 10;
    
    // 3. Unterminated string
    char *str = "Unclosed string literal;
    
    // 4. Unterminated block comment
    /* This comment never ends
    
    return 0;
}