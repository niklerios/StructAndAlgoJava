package StackX;

class BracketChecker {
    private String input;

    public BracketChecker(String in) {
        input = in;
    }

    public void check() {
        int stackSize = input.length();
        StackX theStack = new StackX(stackSize);

        for (int j = 0; j < input.length(); j++) {
            char ch = input.charAt(j);

            switch (ch) {
                case '{':
                case '[':
                case '(':
                    theStack.push(ch);
                    break;

                case '}':
                case ']':
                case ')':
                    if (!theStack.isEmpty()) { // Если стек не пуст
                        char chx = (char) theStack.pop();

                        if ((ch == '}' && chx != '{') ||
                            (ch == ']' && chx != '[') ||
                            (ch == ')' && chx != '('))
                        { // Если скобки не совпадают
                            System.out.println("Error: " + ch + " at " + j);
                        }
                    } else { // Если стек пуст, значит нет открывающей скобки
                        System.out.println("Error: " + ch + " at " + j);
                    }
                    break;

                default: // Для других символов ничего не делаем
                    break;
            }
        }

        // Проверяем, не остались ли открывающие скобки без пары
        if (!theStack.isEmpty()) {
            System.out.println("Error: Unmatched opening bracket");
        }
    }
}
