var HDWalletProvider = require("truffle-hdwallet-provider");
// konstruktor pakietu web3 który umożliwia nam komunikacje z daną siecią etherium którą mu dostarczymy,
// w tym przypadku jest to sieć rinkeby oraz api dostarczone przez darmowy serwis infura
const Web3 = require('web3');
// interface to jest nasz most przez który będziemy sie komunikować
// z kontraktem który został wysłany do sieci etherium w postaci bytecode'u
const { interface, bytecode } = require('./compile')

// stowrzenie dostawcy czyli sieci z której będziemy korzystać
const provider = new HDWalletProvider(
  'canyon rifle purpose yard core sketch asthma drive flash above series agent', 
  'https://rinkeby.infura.io/v3/8f681ce10477476197087c25e3581e15');

// stworzenie instancji web3 poprzez użycie konstruktura oraz wstrzyknieciu wcześniej stworzonego dostawcy 
const web3 = new Web3(provider);


const deploy = async () => {
  // zmienna przechowująca wszystkie konta w naszej lokalnej sieci etherium
  const accounts = await web3.eth.getAccounts();

  console.log('Attempting to deploy from account: ', accounts[0]);

  // zmienna przechowująca zdeploy'owany kontrakt który jest już w sieci etherium
  const result = await new web3.eth.Contract(JSON.parse(interface))
    // wysłanie bytecode kontraktu do sieci etherium wraz z dwoma argumentami konstruktora 
    .deploy({
      data: bytecode
    })
    // podanie z jakiego konta zostaje wysłany konrakt oraz jaki jest limit 'gas' na operacje w kontrakcie 
    .send({
      gas: '3000000',
      from: accounts[0]
    })
  console.log(interface);
  console.log('deploying to: ', result.options.address);
}
// wysłanie kontraktu do sieci etherium
deploy();