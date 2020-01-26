// zmienna przechowująca pakiet path, umożliwia nam on działanie na ścieżkach plików
const path = require('path');
// zmienna przechowująca pakiet fs (file system), umożliwiająca nam odczytywanie plików po podaniu ścieżki do ów plików
const fs = require('fs');
// zmienna przechowująca pakiet solc, jest to kompilator języka solidity
const solc = require('solc');

// zmienna przechowująca ścieżke do naczego kontraktu,
// dzięki użyciu path.resolve() nie musimy wprowadzać ścieżki ręcznie, co zmniejsza prawdopodobieństwo błędu 
const roulettePath = path.resolve(__dirname, 'contracts', 'CharityExample.sol');
// zmienna przechowująca odczytany plik kontraktu
const source = fs.readFileSync(roulettePath, 'utf8');

// solc.compile() kompiluje nasz kontrakt,
// .contracts[':Roulette'] mówi o tym że chcemy eksportować z pliku compile.js tylko
// skompilowany obiekt kontraktu Roulette, używamy tego dlatego iż czasami zdarza sie
// że w jednym pliku jest kilka kontraktów, dzięki czemu ubezpieczami sie przed przyszłymi błędami
module.exports = solc.compile(source, 1).contracts[':CharityExample'];
