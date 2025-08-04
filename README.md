# Kode Start by Kobe

Neste repositório se encontram os aplicativos desenvolvidos durante as aulas, outros projetos desenvolvidos ao longo do programa e, também, documentações

## Links úteis
- Dart Tour: https://dart.dev/guides/language/language-tour
- Projects: https://github.com/kobeapps/kode-start/tree/main/projects

## Dart
Dart é uma linguagem de programação lançada primeiramente em 2011, sua aplicação inicial era substituir o JavaScript como linguagem principal de desenvolvimento Web. Hoje em dia seu principal uso é através do framework Flutter.

É uma linguagem estaticamente tipada, isto é, após um tipo ser atribuído o mesmo não pode mais ser alterado. Sua estrutura é muito parecida com a do Java.

## Hello World
Uma ótima maneira de entender a estrutura básica de uma linguagem é conhecendo como fazer o mais básico e conhecido dos códigos, o "Hello World". Sua estrutura em dart é desta maneira:

    void main() {
     print('Olá, Mundo!');
    }

## Comentários
    // Para adicionar um comentário basta escrevê-lo desta maneira.
    
    /*
    Mas se tiver que falar muita coisa
    Você pode escrever desta maneira
    */
    
    /// E se quiser documentar uma função ou classe escreva assim.

## Fortemente tipada:
Dart é fortemente tipada, mas por sua vez não é necessário definir os tipos explicitamente, podendo se utilizar. Por exemplo ao atribuir a variável:

    var value = 1;

value é inferido como sendo um inteiro. Logo atribuir um valor de um tipo diferente na sequência, como um booleano, resultará em um erro.

    var value = 1;
    value = false; //Erro

Se por alguma necessidade for necessário que o tipo seja dinâmico, existe um tipo especial que foge desta regra, o dynamic, que permite fazer essas atribuições. Porém perdem-se todos os benefícios de uma linguagem fortemente tipada e aumenta e muito a chance de alguma atribuição errada passar despercebida.

    dynamic value = 1;
    value = false;

## Palavras-chave

Se você quer que uma variável nunca seja alterada deve-se usar final ou const, em vez de usar var ou somente o tipo. Uma variável definida como final pode ter seu valor definido apenas uma vez, já uma variável const é uma constante de tempo de compilação. (Uma variável const é implicitamente final)

Se a constante estiver em uma classe deve ser marcado como static const, assim a mesma variável será compartilhada por todas as instâncias da classe e também ser acessível sem instanciar a classe.

    final name = 'Bob';
    final String nickname = 'Bobby';

  

    class DetailsPage {
     static const routeName = '/details';
    }

## Tipos de variáveis

### Números:

Dart possui int e double que são subtipos de num;

    int a = 1;
    double b = 0.1;
    num c = a + b;

### Booleanos:

    bool a = true;
    bool b = false;

### Strings:

Strings podem ser atribuidas com aspas simples ou duplas

    String a = 'a';
    String b = "b";

A interpolação pode ser feita usando um cifrão

    int number = 1;
    String text = "$number";

No caso de ser uma expressão é necessário adicionar chaves.

    int number = 1;
    String text = "${number.isEven}";

### Listas:

    var list = [1, 2, 3];
    var list2 = [...list];
    
    var nav = [
     'Home',
     'Furniture',
     'Plants',
     if (promoActive) 'Outlet',
     promoActive ? 'Sale' : 'Normal
    ];

### Mapas/Dicionários:

    var nobleGases = {
     2: 'helium',
     10: 'neon',
     18: 'argon',
    };

### Generics:

Tipos como listas e mapas possuem possibilidade de utilizar generics para definir os tipos de seus valores internos.

    List<dynamic> myList;
    Map<dynamic, dynamic> myMap;
    
    List<int> myList;
    Map<String, bool> myMap;

## Propriedades privadas:

Em Dart não existem palavras como public, protected, e private, para definir uma variável, função ou classe como privada e que só possa ser acessada dentro de determinado contexto basta que seu nome comece com um underline (_);

    class _Class {}
    var _variable;
    void _function(){}

## Controle de fluxo e repetição

    if (year >= 2001) {
     print('21st century');
    } else if (year >= 1901) {
     print('20th century');
    }
    
    final maior = a > b ? a : b;
    
    switch (expression) {
     case value1:
     // Code to execute if expression matches value1
     break;
     case value2:
     // Code to execute if expression matches value2
     break;
     // ... more cases
     default:
     // Code to execute if no case matches
     break;
    }

    for (final object in flybyObjects) {
     print(object);
    }

    for (int month = 1; month <= 12; month++) {
     print(month);
    }

    while (year < 2016) {
     year += 1;
    }

  

## Null safety:

Dart recentemente recebeu suporte a null safety, isso significa que é possível definir quais variáveis podem ou não receber null. O que tornou o seu analisador muito mais eficiente não permitindo que uma variável seja utilizada antes de ser definida.

    void main() {
     int value;
     value = 0;
     print(value);
    }

Dependendo do contexto de declaração de uma variável é necessário utilizar a palavra-chave late. Isto só é necessário em casos que o próprio Dart não consegue detectar previamente que uma variável será definida antes de ser executada.

    late int value;

    void main() {    
     value = 0;    
     print(value);    
    }

E quando esta variável pode ser nula, mas quando iremos utilizá-la, a mesma já terá seu valor definido, podemos usar uma exclamação.

    int? value;
        
    void main() {    
     value = 0;    
     print(value!.toDouble());    
    }

E se quisermos que uma variável seja nula? Basta Adicionar uma interrogação junto ao tipo.

    String? value;

Além do null safety, o Dart também possui operadores null-aware.

    main() async {
     String? value;
     String? trimmedValue = value?.trim();
     String secondValue = value ?? '';
    }

  

## Parâmetros:

Dart dá suporte a parâmetros obrigatórios, opcionais, nomeados e posicionais.

    void enableFlags({required bool bold, bool? hidden}) {...}
    void enableFlags({required bool bold, bool hidden = false}) {...}
    enableFlags(bold: true, hidden: false);

    String say(String from, String msg, [String? device]) {
     var result = '$from says $msg';
     if (device != null) {
     result = '$result with a $device';
     }
     return result;
    }
    
    assert(say('Bob', 'Howdy') == 'Bob says Howdy');
    assert(say('Bob', 'Howdy', 'smoke signal') == 'Bob says Howdy with a smoke signal');

## Funções:

Dart possui suporte a funções nomeadas e anônimas, arrow functions, inclusive declaração como variáveis com tipagem de retorno e de parâmetros.

    int sum(int a, int b) {return a + b;}
    int sum2(int a, int b) => a + b;
    int Function (int, int) sum3;
    sum3 = (int a, int b) => a + b;

  

    const list = ['apples', 'bananas', 'oranges'];
    list.forEach((item) {
     print('${list.indexOf(item)}: $item');
    });

  

## Classes:

Possui classes abstratas, uso de implements e extends, além de enums e extensions.

    import 'dart:math';

    class Point {
     static const double xOrigin = 0;
     static const double yOrigin = 0;
     double x;
     double y;
     Point(this.x, this.y);
    
     // Named constructor
    
     Point.origin()
     : x = xOrigin,
     y = yOrigin;
     double distanceToOrigin() {
     return sqrt(x * x + y * y);
     }
    }
    
      
    
    class Point3d extends Point {
     static const double zOrigin = 0;
     double z;
     Point3d(double x, double y, this.z) : super(x, y);
     
     // Named constructor
     Point3d.origin(): z = zOrigin, super.origin();

     @override
     double distanceToOrigin() {
     return sqrt(x * x + y * y + z * z);
     }
    }

    main() {
     var a = Point(1, 2);
     var b = Point.origin();
     var c = Point(Point.xOrigin, 2);
     print(a.distanceToOrigin());
    }

  

## Enum:

    enum SelectedColor {
     primaryColor,
     secondaryColor,
    }
    
    extension SelectedColorExtension on SelectedColor {
     String get name => describeEnum(this);
     String get displayTitle {
     switch (this) {
     case SelectedColor.PrimaryColor:
     return 'This is the Primary Color';
     case SelectedColor.SecondaryColor:
     return 'This is the Secondary Color';
     default:
     return 'SelectedScheme Title is null';
     }
     }
    }

## Async e Await

Utilização para tarefas que devem ser feitas de forma assíncrona.

    main() async {
     try {
     var value = await Future.delayed(Duration(seconds: 1));
     print(value.a);
     } catch (e) {
     print(e);
     }
    }

    main() {
    Future.delayed(Duration(seconds: 1))
     .then(
     (value) => print(value.a),
     )
     .catchError((error)=>print(error));
    }

